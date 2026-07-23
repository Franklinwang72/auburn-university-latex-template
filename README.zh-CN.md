<p align="center">
    <br> <a href="README.md">English</a> | <b>中文</b>
</p>

<h1 align="center">Auburn University LaTeX Template (WCAG 2.1 AA)</h1>

<p align="center">
    <em>奥本大学学位论文 LaTeX 模板（无障碍）。</em>
</p>

<p align="center">
  <a href="https://github.com/Franklinwang72/auburn-university-latex-template/stargazers">
    <img alt="Stars" src="https://img.shields.io/github/stars/Franklinwang72/auburn-university-latex-template?style=flat-square" />
  </a>
  <img alt="LuaLaTeX" src="https://img.shields.io/badge/-LuaLaTeX-008080?style=flat-square&logo=latex&logoColor=white" />
  <img alt="PDF/UA-2" src="https://img.shields.io/badge/-PDF%2FUA--2-1f6feb?style=flat-square" />
  <img alt="WCAG 2.1 AA" src="https://img.shields.io/badge/-WCAG%202.1%20AA-2da44e?style=flat-square" />
  <a href="https://github.com/Franklinwang72/auburn-university-latex-template/actions/workflows/ci.yml">
    <img alt="CI" src="https://github.com/Franklinwang72/auburn-university-latex-template/actions/workflows/ci.yml/badge.svg" />
  </a>
  <img alt="TeX Live 2025-2026" src="https://img.shields.io/badge/-TeX%20Live%202025--2026-black?style=flat-square&logo=latex&logoColor=white" />
</p>

奥本大学官方电子学位论文（ETD）模板，编译生成**带标签、无障碍（PDF/UA-2，数学公式可被读屏朗读）** 的 PDF。用 **LuaLaTeX** 编译；所有字体已内嵌，项目完全自包含。

> 遵循 [奥本研究生院 ETD 页面](https://graduate.auburn.edu/current-students/academic-resources/etd.php) 的格式规定。

## 预览

<p align="center">
  <a href="preview.pdf">
    <img width="1000" src="preview.png" alt="标题页、插图页，以及带标签的蛇引理交换图——点击打开完整 PDF" />
  </a>
</p>

## 用法

<p align="center">
  <a href="https://github.com/Franklinwang72/auburn-university-latex-template/archive/refs/heads/main.zip">
    <img alt="下载 ZIP" src="https://img.shields.io/badge/-Download%20ZIP-1f6feb?style=flat-square&logo=github&logoColor=white" />
  </a>
</p>

点上方的 **Download ZIP** 下载，上传到 **Overleaf**（New Project → Upload Project），把 **Menu → Compiler** 选 **LuaLaTeX**、**TeX Live version** 选**最新版**，再点 **Recompile**。（必须用 LuaLaTeX，pdfLaTeX / XeLaTeX 不会给 PDF 打标签。）

## 改哪些文件

- `main.tex` — 标题页信息 + 包含哪些章节
- `chapters/` · `frontmatter/` · `appendices/` — 正文内容
- `references.bib` — 参考文献（biblatex / biber）
- `figures/` — 用 `\includegraphics` 插入的图片

引擎类文件别动：

- `auburn-thesis.cls` — 文档类：版式、字体、标题、页边距，以及全部 PDF 标签（无障碍）设置
- `.latexmkrc` — 编译配置，让 `latexmk` 用 LuaLaTeX 编译并自动跑 biber 处理参考文献
- `fonts/` — 内嵌字体（含 OFL 许可证）

## 须知

- **`\chapter{...}` 标题里别用逗号** — TeX Live 2025+ 的标签引擎会误读；用冒号或破折号代替。
- **替代文字和表头行要你自己写**；其余（标题层级、MathML）都自动生成。具体见第 2 章。

## 实用资源

- [Mikael Arvola](https://github.com/marvel-uiuc) — [UIUC `uofithesis` 模板](https://github.com/graduatecollege/uofithesis)的维护者，同样基于 LaTeX 标签机制的无障碍（PDF/UA-2）学位论文模板。
- [Paul Hurtado 的 LaTeX 资源页](https://pauljhurtado.com/latex/) — 教程、速查表，以及注重无障碍的论文、作业、海报模板。

## 贡献者

<a href="https://github.com/Franklinwang72">
  <img src="https://github.com/Franklinwang72.png" width="60" height="60" style="border-radius:50%" alt="Franklinwang72" />
</a>
