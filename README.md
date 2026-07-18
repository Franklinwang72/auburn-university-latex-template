<p align="center">
    <br> <b>English</b> | <a href="README.zh-CN.md">中文</a>
</p>

<h1 align="center">Auburn University LaTeX Template (WCAG 2.1 AA)</h1>

<p align="center">
    <em>An accessible LaTeX template for Auburn University theses & dissertations.</em>
</p>

<p align="center">
  <a href="https://github.com/Franklinwang72/auburn-university-latex-template/stargazers">
    <img alt="Stars" src="https://img.shields.io/github/stars/Franklinwang72/auburn-university-latex-template?style=flat-square" />
  </a>
  <img alt="LuaLaTeX" src="https://img.shields.io/badge/-LuaLaTeX-008080?style=flat-square&logo=latex&logoColor=white" />
  <img alt="PDF/UA-2" src="https://img.shields.io/badge/-PDF%2FUA--2-1f6feb?style=flat-square" />
  <img alt="WCAG 2.1 AA" src="https://img.shields.io/badge/-WCAG%202.1%20AA-2da44e?style=flat-square" />
  <img alt="TeX Live 2023+" src="https://img.shields.io/badge/-TeX%20Live%202023+-black?style=flat-square&logo=latex&logoColor=white" />
</p>

The official Auburn University ETD template that compiles to a **tagged, accessible (PDF/UA-2, readable MathML)** PDF. Compile with **LuaLaTeX**; all fonts are bundled, so the project is fully self-contained.

> Built to the [Auburn Graduate School ETD](https://graduate.auburn.edu/current-students/academic-resources/etd.php) format rules.

## Preview

<p align="center">
  <a href="preview.pdf">
    <img width="1000" src="preview.png" alt="Title page, a figure page, and the tagged snake-lemma diagram — click to open the full PDF" />
  </a>
</p>

## Usage

<p align="center">
  <a href="https://github.com/Franklinwang72/auburn-university-latex-template/archive/refs/heads/main.zip">
    <img alt="Download ZIP" src="https://img.shields.io/badge/-Download%20ZIP-1f6feb?style=flat-square&logo=github&logoColor=white" />
  </a>
</p>

Click **Download ZIP** above, upload the file to **Overleaf** (New Project → Upload Project), set **Menu → Compiler → LuaLaTeX** and **TeX Live version → the latest**, then **Recompile**. (LuaLaTeX is required — pdfLaTeX / XeLaTeX will not produce a tagged PDF.)

## What You Edit

- `main.tex` — title-page info and which chapters are included
- `chapters/` · `frontmatter/` · `appendices/` — your content
- `references.bib` — bibliography (biblatex / biber)
- `figures/` — images you place with `\includegraphics`

Leave the engine alone:

- `auburn-thesis.cls` — the document class: page layout, fonts, headings, margins, and all the PDF-tagging (accessibility) setup
- `.latexmkrc` — build config that makes `latexmk` compile with LuaLaTeX and run biber for the bibliography
- `fonts/` — the bundled fonts (with their OFL licences)

## Good to Know

- **No commas in `\chapter{...}` titles** — the TeX Live 2025+ tagging engine misreads them; use a colon or dash.
- **You write** figure alt text and table header rows; everything else (heading structure, MathML) is automatic. Chapter 2 shows how.

## Useful Resources

- [Mikael Arvola](https://github.com/marvel-uiuc) — maintainer of the [UIUC `uofithesis` class](https://github.com/graduatecollege/uofithesis), an accessible (PDF/UA-2) thesis template built on the same tagging machinery.
- [Paul Hurtado's LaTeX resource page](https://pauljhurtado.com/latex/) — tutorials, reference sheets, and accessibility-minded thesis, homework, and poster templates.

## Contributors

<a href="https://github.com/Franklinwang72">
  <img src="https://github.com/Franklinwang72.png" width="60" height="60" style="border-radius:50%" alt="Franklinwang72" />
</a>
