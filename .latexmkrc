## Build this thesis with: latexmk
## (LuaLaTeX is REQUIRED for accessible/tagged PDF output.)
$pdf_mode = 4;            # 4 = LuaLaTeX
$lualatex = 'lualatex -interaction=nonstopmode -synctex=1 -file-line-error %O %S';
$bibtex_use = 2;          # run biber as needed
$clean_ext = 'bbl run.xml';
