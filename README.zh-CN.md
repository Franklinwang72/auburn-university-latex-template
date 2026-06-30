<p align="center">
    <br> <a href="README.md">English</a> | <b>中文</b>
</p>

<h1 align="center">🎓 Auburn Accessible Thesis</h1>

<p align="center">
    <em>奥本大学学位论文 LaTeX 模板 —— 无障碍（WCAG 2.1 AA / PDF/UA-1）。</em>
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

非官方的奥本大学电子学位论文（ETD）模板，编译生成**带标签、符合 WCAG 2.1 AA / PDF/UA-1** 的 PDF —— 真正的标题层级、图片替代文字、表头，以及每个公式自动生成的 MathML。用 **LuaLaTeX** 编译；所有字体已内嵌，项目完全自包含。

> 非官方模板，提交前请以最新的 [奥本研究生院 ETD 指南](https://graduate.auburn.edu/etd/) 为准。

## 预览

<p align="center">
  <img width="1000" src="preview.png" alt="标题页、插图页，以及带标签的蛇引理交换图" />
</p>

## 快速开始

**Overleaf** —— 上传项目，**Menu → Compiler** 选 **LuaLaTeX**、**TeX Live version** 选**最新版**，再点 **Recompile**。（必须用 LuaLaTeX，pdfLaTeX / XeLaTeX 不会给 PDF 打标签。）

**本地** —— 需 TeX Live 2023 或更新版：

```bash
latexmk -lualatex main.tex   # 生成 main.pdf（自动运行 biber）
latexmk -c                   # 清掉中间文件，保留 main.pdf
```

## 特性

- **从根上无障碍** —— 带标签 PDF：标题层级、图片替代文字、表头，以及每个公式的 MathML。已用 veraPDF 验证符合 PDF/UA-1。
- **自包含字体** —— 正文 Source Sans 3、公式 STIX Two Math、代码 Atkinson Hyperlegible Mono，连同 OFL 许可证一起打包。
- **符合格式规定** —— 页边距 ≥1 英寸（加 `binding` 时左边 1.5 英寸）、正文 12 pt、页码居中、含 AI 使用声明在内的全部必备前置页。
- **交换图** —— 用 `tikz-cd` 在源码里画（无需图片），正确打标签并带替代文字和边界框。
- **开箱即用** —— 章节标题居中，目录 / 表格目录 / 插图目录可点击跳转。

## 改哪些文件

- `main.tex` —— 标题页信息 + 包含哪些章节
- `chapters/` · `frontmatter/` · `appendices/` —— 正文内容
- `references.bib` —— 参考文献（biblatex / biber）
- `figures/` —— 用 `\includegraphics` 插入的图片

引擎类文件别动：`auburn-thesis.cls`、`fonts/`、`.latexmkrc`。

## 须知

- **`\chapter{...}` 标题里别用逗号** —— TeX Live 2025+ 的标签引擎会误读；用冒号或破折号代替。
- **替代文字和表头行要你自己写**；其余（标题层级、MathML）都自动生成。具体见第 2 章。
- 本地重编时若报 `Command \cftchappresnum undefined`，是旧的 `main.toc` 残留：先跑一次 `latexmk -C` 再编译。

## 贡献者

<a href="https://github.com/Franklinwang72">
  <img src="https://github.com/Franklinwang72.png" width="60" height="60" style="border-radius:50%" alt="Franklinwang72" />
</a>

## 许可证

模板采用 [MIT](LICENSE)。内嵌字体采用 SIL 开放字体许可证（`fonts/OFL-*.txt`）。
