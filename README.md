# Auburn University Thesis / Dissertation — Accessible LaTeX Template

**English** | [中文](README.zh-CN.md)

An unofficial LaTeX class for Auburn University Electronic Theses and
Dissertations (ETD) that produces a **tagged, WCAG 2.1 AA / PDF/UA-1 conformant**
PDF. Compile with **LuaLaTeX**; every font is bundled, so the project is fully
self-contained.

> Unofficial template — check the current
> [Auburn Graduate School ETD Guide](https://graduate.auburn.edu/etd/) for the
> format rules before you submit.

## Features

- **Accessible by construction** — a tagged PDF with real heading structure,
  figure alt text, table headers, and automatic MathML for every formula.
  Verified PDF/UA-1 with veraPDF.
- **Self-contained fonts** — Source Sans 3 (body), STIX Two Math (formulas),
  Atkinson Hyperlegible Mono (code), bundled with their OFL licences.
- **Format-compliant** — ≥1″ margins (1.5″ left with the `binding` option),
  12 pt text, page numbers centred at the bottom, all required preliminary pages
  including the AI-use disclosure.
- **Just works** — centred chapter headings, clickable Table of Contents / List
  of Tables / List of Figures, and commutative diagrams drawn in `tikz-cd`
  (no image files) — all correctly tagged.

## Quick start

**Overleaf** — upload the project, then **Menu → Compiler → LuaLaTeX** and
**Menu → TeX Live version → the latest**, and **Recompile**. (LuaLaTeX is
required; pdfLaTeX / XeLaTeX will not produce a tagged PDF.)

**Local** — TeX Live 2023 or later:

```bash
latexmk -lualatex main.tex   # build main.pdf (runs biber automatically)
latexmk -c                   # remove build files, keep main.pdf
```

## What to edit

Start in **`main.tex`** (title-page info + which chapters are included), then:

- `frontmatter/*.tex` — abstract, AI-use disclosure, acknowledgments, abbreviations
- `chapters/chapter1.tex … chapter3.tex` — your body chapters
- `appendices/appendix1.tex` — appendix
- `references.bib` — bibliography database (biblatex / biber)
- `figures/` — images you include with `\includegraphics`

Leave the engine alone: `auburn-thesis.cls` (layout, fonts, headings, tagging),
`fonts/`, and `.latexmkrc`.

To add a chapter, create `chapters/chapter4.tex` beginning with `\chapter{...}`
and add `\include{chapters/chapter4}` in `main.tex`.

## Good to know

- **No commas in `\chapter{...}` titles** — the TeX Live 2025+ tagging engine
  misreads them as a key list. Use a colon or dash.
- **Commutative diagrams** — `\auCDFigure{<alt text>}{<tikz-cd code>}` inside a
  `figure` environment (see the snake lemma in `chapters/chapter3.tex`).
- **You write** meaningful figure alt text and table header rows; everything
  else (heading structure, MathML) is automatic. Chapter 2 shows how.
- A local rebuild erroring with `Command \cftchappresnum undefined` means a
  stale `main.toc` — run `latexmk -C` once, then rebuild.

## Licence

The bundled fonts use the SIL Open Font License (see `fonts/OFL-*.txt`). Choose
and add your own licence for the template and your thesis content.
