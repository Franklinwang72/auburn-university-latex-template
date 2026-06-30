<p align="center">
    <br> <b>English</b> | <a href="README.zh-CN.md">中文</a>
</p>

<h1 align="center">🎓 Auburn LaTeX Template (WCAG 2.1 AA)</h1>

<p align="center">
    <em>An accessible LaTeX template for Auburn University theses & dissertations.</em>
</p>

<p align="center">
  <a href="https://github.com/Franklinwang72/auburn-accessible-thesis/stargazers">
    <img alt="Stars" src="https://img.shields.io/github/stars/Franklinwang72/auburn-accessible-thesis?style=flat-square" />
  </a>
  <img alt="LuaLaTeX" src="https://img.shields.io/badge/-LuaLaTeX-008080?style=flat-square&logo=latex&logoColor=white" />
  <img alt="PDF/UA-1" src="https://img.shields.io/badge/-PDF%2FUA--1-1f6feb?style=flat-square" />
  <img alt="WCAG 2.1 AA" src="https://img.shields.io/badge/-WCAG%202.1%20AA-2da44e?style=flat-square" />
  <img alt="TeX Live 2023+" src="https://img.shields.io/badge/-TeX%20Live%202023+-black?style=flat-square&logo=latex&logoColor=white" />
</p>

An unofficial Auburn University ETD template that compiles to a **tagged, accessible (PDF/UA-1)** PDF. Compile with **LuaLaTeX**; all fonts are bundled, so the project is fully self-contained.

> Unofficial — check the [Auburn Graduate School ETD page](https://graduate.auburn.edu/current-students/academic-resources/etd.php) for the format rules before you submit.

## Preview

<p align="center">
  <img width="1000" src="preview.png" alt="Title page, a figure page, and the tagged snake-lemma diagram" />
</p>

## Usage

Download this repository, upload it to **Overleaf**, set **Menu → Compiler → LuaLaTeX** and **TeX Live version → the latest**, then **Recompile**. (LuaLaTeX is required — pdfLaTeX / XeLaTeX will not produce a tagged PDF.)

## What You Edit

- `main.tex` — title-page info and which chapters are included
- `chapters/` · `frontmatter/` · `appendices/` — your content
- `references.bib` — bibliography (biblatex / biber)
- `figures/` — images you place with `\includegraphics`

Leave the engine alone: `auburn-thesis.cls`, `fonts/`, `.latexmkrc`.

## Good to Know

- **No commas in `\chapter{...}` titles** — the TeX Live 2025+ tagging engine misreads them; use a colon or dash.
- **You write** figure alt text and table header rows; everything else (heading structure, MathML) is automatic. Chapter 2 shows how.

## Contributors

<a href="https://github.com/Franklinwang72">
  <img src="https://github.com/Franklinwang72.png" width="60" height="60" style="border-radius:50%" alt="Franklinwang72" />
</a>
