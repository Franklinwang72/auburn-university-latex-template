#!/usr/bin/env python3
"""CI checks for the Auburn accessible ETD template.

One script, three layers -- each check encodes a REAL failure we have hit:

  A. Compile-log gate ... errors, undefined refs, non-convergence, and a
     WARNING-FINGERPRINT BASELINE: every warning the template is known to
     produce is whitelisted below; any NEW warning fails the build. This is
     how an upstream change (tagpdf / luamml / kernel) gets caught by CI
     before a student ever sees it. (The mathml:mo warnings appeared exactly
     this way when TeX Live 2026 updated tagpdf's parent-child checker.)

  B. Metadata gate ... XMP dc:title present and /DisplayDocTitle true
     (WCAG 2.4.2), and the class still forces \\contentsname to
     "Table of Contents" AFTER babel loads (babel silently reverted it to
     "Contents" until the \\AtBeginDocument fix).

  C. Source lints ... forbid the constructs that silently break tagging:
       C1 \\resizebox around content (kills table-cell tagging)
       C2 a comma inside \\chapter{...} (TL2025+ tagging engine chokes)
       C3 \\includegraphics without alt={...} or [artifact]

  Plus the veraPDF PDF/UA-2 verdict (report parsed, non-compliant fails).

Usage:  check.py --name TL2026 --log main.log --pdf main.pdf \
                 --verapdf verapdf.xml --src .
Exit 0 = all green; exit 1 = at least one check failed.
"""
import argparse, os, re, sys, glob

# ----------------------------------------------------------------------
# Warning baseline. Fingerprint = (package, first line normalised: every
# number -> '#', whitespace collapsed). Values are generous caps so a page
# reflow never trips CI; a NEW fingerprint or an exploding count does.
# ----------------------------------------------------------------------
KNOWN_WARNINGS = {
    # luamml emits <mo> directly under <math>; tagpdf >= TL2026 flags the
    # pair. Upstream behaviour, harmless to readers, veraPDF-clean.
    ("tagpdf", "Parent-Child 'mathml:mo' --> 'mathml:math'."): 30,
    # hyperref structure destinations for captions not linked back; cosmetic.
    ("tagpdf", "Destination 'figure.caption.#' has no related"): 20,
    ("tagpdf", "Destination 'table.caption.#' has no related"): 20,
    # unicode-math boilerplate.
    ("unicode-math", "Using \\overbracket and \\underbracket from"): 4,
    ("unicode-math", "I'm going to overwrite the following commands"): 4,
    # The tagging kernel owns footnotes; these two packages skip their patch.
    ("microtype", "Unable to apply patch `footnote' on input line #."): 4,
    ("biblatex", "Patching footnotes failed."): 4,
}

# Prefix-matched whitelist for warnings whose wrap point varies between
# distributions. The block "unknown-keys" message is an ERROR downgraded to a
# warning by the class, so the TL2025 module ignores enumitem list keys
# (leftmargin=...) instead of aborting; it never fires on TL2026, which
# knows those keys.
KNOWN_WARNING_PREFIXES = [
    ("block", "Some keys"),
]

results = []          # (ok, label, detail)
def check(ok, label, detail=""):
    results.append((bool(ok), label, detail))
    return ok

def norm(s):
    s = re.sub(r"\d+", "#", s)
    return re.sub(r"\s+", " ", s).strip()

# ----------------------------------------------------------------------
# A. compile log
# ----------------------------------------------------------------------
def check_log(path):
    log = open(path, errors="replace").read()
    # Errors come in TWO shapes: classic "! ..." lines, and (because
    # .latexmkrc sets -file-line-error) "file.tex:123: Package foo Error:".
    # The TL2025 block-module failure logged ONLY in the second shape and
    # slipped past a "^!"-only grep -- match both, always.
    errs = re.findall(r"^! .*", log, re.M)
    errs += re.findall(r"^[^\n:]+:\d+: .*", log, re.M)
    check(not errs, "A: 0 compile errors",
          "; ".join(e[:80] for e in errs[:3]))
    check("undefined references" not in log and
          not re.search(r"Citation .* undefined", log),
          "A: no undefined references/citations")
    check("multiply-defined" not in log and "multiply defined" not in log,
          "A: no multiply-defined labels")
    check("Label(s) may have changed" not in log,
          "A: build converged (no rerun request)",
          "latexmk did not run enough passes")

    seen = {}
    pat = re.compile(r"^(?:Package|Class|Module) ([\w-]+) Warning: (.*)$|"
                     r"^(LaTeX(?: Font)?) Warning: (.*)$", re.M)
    for m in pat.finditer(log):
        pkg = m.group(1) or m.group(3)
        txt = m.group(2) or m.group(4)
        key = (pkg, norm(txt))
        if pkg in ("LaTeX", "LaTeX Font"):
            key = (pkg.lower().replace(" ", "-"), norm(txt))
        seen[key] = seen.get(key, 0) + 1

    fresh, over = [], []
    for key, n in sorted(seen.items()):
        cap = KNOWN_WARNINGS.get(key)
        if cap is None:
            if any(key[0] == pkg and key[1].startswith(pre)
                   for pkg, pre in KNOWN_WARNING_PREFIXES):
                continue
            fresh.append(f"{key[0]}: {key[1]} (x{n})")
        elif n > cap:
            over.append(f"{key[0]}: {key[1]} (x{n} > cap {cap})")
    check(not fresh, "A: no NEW warnings vs baseline",
          " | ".join(fresh[:5]))
    check(not over, "A: known-warning counts within caps",
          " | ".join(over[:5]))

# ----------------------------------------------------------------------
# B. PDF metadata (pikepdf)
# ----------------------------------------------------------------------
def check_pdf(path):
    import pikepdf
    pdf = pikepdf.open(path)
    try:
        with pdf.open_metadata() as meta:
            title = meta.get("dc:title")
    except Exception:
        title = None
    check(bool(title), "B: XMP dc:title present (WCAG 2.4.2)")
    vp = pdf.Root.get("/ViewerPreferences")
    check(bool(vp) and bool(vp.get("/DisplayDocTitle")),
          "B: /DisplayDocTitle = true")

# ----------------------------------------------------------------------
# B (source side) + C. lints over the .tex/.cls sources
# ----------------------------------------------------------------------
def strip_comments(text):
    return re.sub(r"(?<!\\)%.*", "", text)

def check_sources(srcdir):
    cls = os.path.join(srcdir, "auburn-thesis.cls")
    s = open(cls, errors="replace").read() if os.path.exists(cls) else ""
    check(r"\AtBeginDocument{\renewcommand{\contentsname}{Table of Contents}}" in s,
          "B: ToC heading survives babel (AtBeginDocument fix present)")

    texs = [p for p in glob.glob(os.path.join(srcdir, "**", "*.tex"), recursive=True)
            if "/.git" not in p and "/build" not in p]
    rb, comma, noalt = [], [], []
    for p in texs:
        t = strip_comments(open(p, errors="replace").read())
        if "\\resizebox" in t:
            rb.append(os.path.relpath(p, srcdir))
        for m in re.finditer(r"\\chapter\*?(?:\[[^\]]*\])?\{([^{}]*)\}", t):
            if "," in m.group(1):
                comma.append(f"{os.path.relpath(p, srcdir)}: {m.group(1)[:40]}")
        for m in re.finditer(r"\\includegraphics\s*(\[(?:[^\[\]])*\])?\s*\{", t):
            opts = m.group(1) or ""
            if "alt=" not in opts and "artifact" not in opts:
                noalt.append(os.path.relpath(p, srcdir))
    check(not rb, "C1: no \\resizebox in sources (kills cell tagging)",
          ", ".join(rb[:4]))
    check(not comma, "C2: no comma inside \\chapter{...} titles",
          " | ".join(comma[:3]))
    check(not noalt, "C3: every \\includegraphics has alt= or [artifact]",
          ", ".join(noalt[:4]))

# ----------------------------------------------------------------------
# veraPDF report
# ----------------------------------------------------------------------
def check_verapdf(path):
    if not path or not os.path.exists(path):
        check(False, "veraPDF: report present", "file missing"); return
    x = open(path, errors="replace").read()
    ok = 'isCompliant="true"' in x
    m = re.search(r'passedChecks="(\d+)" failedChecks="(\d+)"', x)
    detail = f"{m.group(1)} passed / {m.group(2)} failed" if m else "unparsed"
    check(ok, "veraPDF: PDF/UA-2 compliant", detail)

# ----------------------------------------------------------------------
# Overleaf drift table (INFORMATIONAL, never fails the build): compare the
# package versions this build loaded against the captured manifest of
# Overleaf's default image, so the gap between CI and Overleaf is a table,
# not a guess. Refresh the manifest with the probe when Overleaf updates.
# ----------------------------------------------------------------------
def overleaf_drift(logpath, manifestpath):
    if not (logpath and manifestpath and os.path.exists(manifestpath)):
        return ""
    log = open(logpath, errors="replace").read()
    here = {}
    m = re.search(r"LaTeX2e <([0-9-]+)>", log)
    if m: here["format"] = m.group(1)
    for pm in re.finditer(r"^Package: ([\w-]+) (\d{4}[-/]\d{2}[-/]\d{2})\s*(v?[\w.]*)",
                          log, re.M):
        here[pm.group(1) + ".sty"] = (pm.group(2).replace("/", "-") + " "
                                      + pm.group(3)).strip()
    lines = ["<details><summary>Overleaf drift (vs captured default image)</summary>",
             "", "| file | Overleaf | this build |", "|---|---|---|"]
    for raw in open(manifestpath):
        raw = raw.strip()
        if not raw or raw.startswith("#"): continue
        parts = raw.split(None, 1)
        name, over = parts[0], (parts[1] if len(parts) > 1 else "")
        mine = here.get(name, "--- not loaded ---")
        mark = "" if over.split(" v")[0].strip("()") in mine else " ⚠️"
        lines.append(f"| {name} | {over} | {mine}{mark} |")
    lines += ["", "</details>"]
    return "\n".join(lines)

# ----------------------------------------------------------------------
def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--name", default="local")
    ap.add_argument("--log"); ap.add_argument("--pdf")
    ap.add_argument("--verapdf"); ap.add_argument("--src", default=".")
    ap.add_argument("--manifest")
    a = ap.parse_args()

    if a.log: check_log(a.log)
    if a.pdf: check_pdf(a.pdf)
    check_sources(a.src)
    if a.verapdf: check_verapdf(a.verapdf)

    fails = [r for r in results if not r[0]]
    lines = [f"## {a.name}: {'✅ all checks passed' if not fails else '❌ FAILED'}",
             "", "| check | result | detail |", "|---|---|---|"]
    for ok, label, detail in results:
        lines.append(f"| {label} | {'✅' if ok else '❌'} | {detail if not ok else ''} |")
    drift = overleaf_drift(a.log, a.manifest)
    report = "\n".join(lines) + ("\n\n" + drift if drift else "")
    print(report)
    summary = os.environ.get("GITHUB_STEP_SUMMARY")
    if summary:
        with open(summary, "a") as f:
            f.write(report + "\n\n")
    sys.exit(1 if fails else 0)

main()
