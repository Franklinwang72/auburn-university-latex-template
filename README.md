<p align="center">
    <br> <b>English</b> | <a href="README.zh-CN.md">中文</a>
</p>

<h1 align="center">🎓 Auburn Accessible Thesis</h1>

<p align="center">
    <em>An accessible (WCAG 2.1 AA / PDF/UA-1) LaTeX template for Auburn University theses & dissertations.</em>
</p>

<p align="center">
  <a href="LICENSE" target="_blank">
    <img alt="MIT License" src="https://img.shields.io/github/license/Franklinwang72/auburn-accessible-thesis.svg?style=flat-square" />
  </a>
  <a href="https://github.com/Franklinwang72/auburn-accessible-thesis/stargazers">
    <img alt="Stars" src="https://img.shields.io/github/stars/Franklinwang72/auburn-accessible-thesis?style=flat-square" />
  </a>
  <img alt="LuaLaTeX" src="https://img.shields.io/badge/-LuaLaTeX-008080?style=flat-square&logo=latex&logoColor=white" />
  <img alt="PDF/UA-1" src="https://img.shields.io/badge/-PDF%2FUA--1-1f6feb?style=flat-square" />
  <img alt="WCAG 2.1 AA" src="https://img.shields.io/badge/-WCAG%202.1%20AA-2da44e?style=flat-square" />
  <img alt="TeX Live 2023+" src="https://img.shields.io/badge/-TeX%20Live%202023+-black?style=flat-square&logo=latex&logoColor=white" />
</p>

An unofficial Auburn University ETD template that compiles to a **tagged, WCAG 2.1 AA / PDF/UA-1** PDF — real heading structure, figure alt text, table headers, and automatic MathML for every formula. Compile with **LuaLaTeX**; all fonts are bundled, so the project is fully self-contained.

> Unofficial — check the current [Auburn Graduate School ETD Guide](https://graduate.auburn.edu/etd/) for the format rules before you submit.

## Preview

<p align="center">
  <img width="1000" src="preview.png" alt="Title page, a figure page, and the tagged snake-lemma diagram" />
</p>

## Quick Start

**Overleaf** — upload the project, set **Menu → Compiler → LuaLaTeX** and **TeX Live version → the latest**, then **Recompile**. (LuaLaTeX is required; pdfLaTeX / XeLaTeX will not tag the PDF.)

**Local** — TeX Live 2023 or later:

```bash
latexmk -lualatex main.tex   # build main.pdf (runs biber automatically)
latexmk -c                   # remove build files, keep main.pdf
```

## Features

- **Accessible by construction** — tagged PDF with heading structure, figure alt text, table headers, and MathML for every formula. Verified PDF/UA-1 with veraPDF.
- **Self-contained fonts** — Source Sans 3 (body), STIX Two Math (formulas), Atkinson Hyperlegible Mono (code), bundled with their OFL licences.
- **Format-compliant** — ≥1″ margins (1.5″ left with `binding`), 12 pt text, centred page numbers, all required preliminary pages including the AI-use disclosure.
- **Commutative diagrams** — drawn in `tikz-cd` (no image files), correctly tagged with alt text and a bounding box.
- **Just works** — centred chapter headings, clickable Table of Contents / List of Tables / List of Figures.

## What You Edit

- `main.tex` — title-page info and which chapters are included
- `chapters/` · `frontmatter/` · `appendices/` — your content
- `references.bib` — bibliography (biblatex / biber)
- `figures/` — images you place with `\includegraphics`

Leave the engine alone: `auburn-thesis.cls`, `fonts/`, `.latexmkrc`.

## Good to Know

- **No commas in `\chapter{...}` titles** — the TeX Live 2025+ tagging engine misreads them; use a colon or dash.
- **You write** figure alt text and table header rows; everything else (heading structure, MathML) is automatic. Chapter 2 shows how.
- A local rebuild erroring with `Command \cftchappresnum undefined` means a stale `main.toc` — run `latexmk -C` once, then rebuild.

## Contributors

<a href="https://github.com/Franklinwang72">
  <img src="https://github.com/Franklinwang72.png" width="60" height="60" style="border-radius:50%" alt="Franklinwang72" />
</a>

## License

[MIT](LICENSE) for the template. Bundled fonts use the SIL Open Font License (`fonts/OFL-*.txt`).
