# 奥本大学学位论文 LaTeX 模板（无障碍）

[English](README.md) | **中文**

一个非官方的奥本大学（Auburn University）电子学位论文（ETD）LaTeX 模板，生成**带标签、
符合 WCAG 2.1 AA / PDF/UA-1 无障碍标准**的 PDF。用 **LuaLaTeX** 编译；所有字体已内嵌，
项目完全自包含。

> 非官方模板——提交前请以最新的
> [奥本研究生院 ETD 指南](https://graduate.auburn.edu/etd/) 为准。

## 特性

- **从根上无障碍**——带标签 PDF：真正的标题层级、图片替代文字、表头，以及每个公式自动
  生成的 MathML。已用 veraPDF 验证符合 PDF/UA-1。
- **自包含字体**——正文 Source Sans 3、公式 STIX Two Math、代码 Atkinson Hyperlegible
  Mono，连同 OFL 许可证一起打包。
- **符合格式规定**——页边距 ≥1 英寸（加 `binding` 时左边 1.5 英寸）、正文 12 pt、页码
  居中于页脚、含 AI 使用声明在内的全部必备前置页。
- **开箱即用**——章节标题居中，目录 / 表格目录 / 插图目录可点击跳转，交换图用 `tikz-cd`
  在源码里画（无需图片文件）——全部正确打标签。

## 快速开始

**Overleaf**——上传项目后，**Menu → Compiler** 选 **LuaLaTeX**，**TeX Live version**
选**最新版**，再点 **Recompile**。（必须用 LuaLaTeX，pdfLaTeX / XeLaTeX 不会生成带标签的
PDF。）

**本地**——需 TeX Live 2023 或更新版：

```bash
latexmk -lualatex main.tex   # 生成 main.pdf（自动运行 biber）
latexmk -c                   # 清掉中间文件，保留 main.pdf
```

## 改哪些文件

从 **`main.tex`** 开始（标题页信息 + 包含哪些章节），然后：

- `frontmatter/*.tex`——摘要、AI 使用声明、致谢、缩写表
- `chapters/chapter1.tex … chapter3.tex`——正文各章
- `appendices/appendix1.tex`——附录
- `references.bib`——参考文献库（biblatex / biber）
- `figures/`——用 `\includegraphics` 插入的图片

引擎类文件别动：`auburn-thesis.cls`（版式、字体、标题、标签）、`fonts/`、`.latexmkrc`。

加一章：新建 `chapters/chapter4.tex`，开头写 `\chapter{...}`，再到 `main.tex` 加一行
`\include{chapters/chapter4}`。

## 须知

- **`\chapter{...}` 标题里别用逗号**——TeX Live 2025+ 的标签引擎会把逗号误当成参数分隔。
  用冒号或破折号代替。
- **交换图**——用 `\auCDFigure{<替代文字>}{<tikz-cd 代码>}` 写在 `figure` 环境里
  （见 `chapters/chapter3.tex` 里的蛇引理）。
- **替代文字和表头行要你自己写**；其余（标题层级、MathML）都会自动生成。具体做法见第 2 章。
- 本地重编时若报 `Command \cftchappresnum undefined`，是旧的 `main.toc` 残留：先跑一次
  `latexmk -C` 再编译。

## 许可证

内嵌字体采用 SIL 开放字体许可证（见 `fonts/OFL-*.txt`）。模板本身和你的论文内容请自行
选择并添加许可证。
