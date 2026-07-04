%% auburn-thesis.cls  --  accessible Auburn University ETD class (LuaLaTeX)
%% A quiet, accessible design: no running header, no rules, no decoration;
%% every visible size is 12 pt, page numbers are centred at the bottom, and
%% the heading hierarchy is carried by weight and white space alone (chapter
%% = Bold, section = Semibold, subsection = Medium, subsubsection = Italic).
%% The body text is black; the only colour is on the teaching signposts --
%% the run-in "Why:"/"How:" labels and the "Good:"/"Poor:" (do/don't) markers
%% -- in accessible shades (navy for Why/How, green for Good/Right, red for
%% Poor/Wrong) so a reader can find them at a glance. Each is also a bold
%% word, so the colour is never the only cue. Theorem/definition labels and
%% table headers are Semibold.
%% Official LaTeX class for Auburn University Electronic Theses and
%% Dissertations (ETD), built to the Graduate School format rules:
%%   * uniform margins of at least 1" on all sides (1.5" left with the
%%     [binding] option); major-heading pages start at the 1" top margin;
%%   * 12 pt text; subscripts/superscripts no more than 2 pt smaller
%%     than the text font (see \DeclareMathSizes below);
%%   * continuous Arabic pagination -- every page is counted, every page
%%     except the title page shows its number, centred at the bottom and
%%     at least 1/2" from the bottom edge;
%%   * embedded fonts only (LuaLaTeX embeds every font it uses);
%%   * a sans-serif body (Source Sans 3), as the Graduate School
%%     recommends for federal digital-accessibility compliance, with
%%     STIX Two Math for formulas and Atkinson Hyperlegible Mono for
%%     code;
%%   * headings marked as real Heading 1/2/3/4 structure (tagged);
%%   * alt text / descriptive captions for figures, header rows for
%%     tables (done in the document; see the manual chapters);
%%   * required preliminary pages incl. the AI-use disclosure.
%%
%% ACCESSIBILITY: this class is designed to produce a TAGGED, WCAG 2.1
%% Level AA / PDF/UA-1 conformant PDF. That requires TWO things you do in
%% the main file (see main.tex):
%%   1. \DocumentMetadata{lang=en-US, pdfstandard=ua-1, tagging=on}
%%      as the VERY FIRST line, before \documentclass.
%%   2. Compile with LuaLaTeX (required for tagging + automatic MathML).
%% The class itself is built to be tagging-safe: it formats headings with
%% the LaTeX kernel's own sectioning hooks (NOT titlesec, which would
%% strip heading tags), uses unicode-math (automatic MathML for screen
%% readers), accessible colours, and colour+underline hyperlinks.
%%
%% Requirements: TeX Live 2023 or later, LuaLaTeX. (Tested on the
%% TeX Live 2025 / LaTeX2e 2024-11-01 kernel, which tags at the
%% PDF/UA-1 level.)
%%
%% Class options:
%%   dissertation   (default) | thesis      -> wording on the title page
%%   doublespacing  (default) | onehalfspacing | singlespacing
%%   binding        -> 1.5" left margin for bound paper copies
%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{auburn-thesis}[2026/06/13 v3.1 Auburn University ETD, accessible, quiet + signpost colour (LuaLaTeX)]

%% ----------------------------------------------------------------------
%% Options
%% ----------------------------------------------------------------------
\newif\ifauetd@dissertation \auetd@dissertationtrue
\DeclareOption{dissertation}{\auetd@dissertationtrue}
\DeclareOption{thesis}{\auetd@dissertationfalse}

\newif\ifauetd@binding \auetd@bindingfalse
\DeclareOption{binding}{\auetd@bindingtrue}

% body line spacing: store the setspace command to run after setspace loads
\newcommand{\auetd@bodyspacing}{\doublespacing}
\DeclareOption{doublespacing}{\renewcommand{\auetd@bodyspacing}{\doublespacing}}
\DeclareOption{onehalfspacing}{\renewcommand{\auetd@bodyspacing}{\onehalfspacing}}
\DeclareOption{singlespacing}{\renewcommand{\auetd@bodyspacing}{\singlespacing}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax

\LoadClass[12pt,letterpaper,oneside]{report}

%% ----------------------------------------------------------------------
%% Page geometry  (>= 1" all sides; 1.5" left if binding; page number
%% centered at the bottom, >= 1/2" from the bottom edge). No header.
%% ----------------------------------------------------------------------
\RequirePackage[letterpaper,margin=1in,footskip=0.4in]{geometry}
\ifauetd@binding\geometry{left=1.5in}\fi

%% ----------------------------------------------------------------------
%% Fonts (LuaLaTeX): a sans-serif body in Adobe's
%% open-source Source Sans 3 (the Graduate School recommends sans-serif
%% type), STIX Two Math for the formulas, and Atkinson Hyperlegible Mono
%% for code. All fonts are bundled in fonts/ (with their OFL licences),
%% so the project is self-contained and every font is embedded.
%% EVERY visible size is 12 pt -- body, headings, captions, table text,
%% page numbers. The heading hierarchy is weight, not size:
%%   chapter title    -> Source Sans 3 Bold, 12 pt
%%   chapter label    -> Source Sans 3 Medium, 12 pt
%%   section          -> Source Sans 3 Semibold, 12 pt
%%   subsection       -> Source Sans 3 Medium, 12 pt
%%   subsubsection    -> Source Sans 3 Italic, 12 pt
%%   caption label    -> Source Sans 3 Semibold, 12 pt
%%   code / URLs      -> Atkinson Hyperlegible Mono
%% ----------------------------------------------------------------------
\RequirePackage{mathtools}  % loads amsmath too; both before unicode-math
\RequirePackage{amsthm}
\RequirePackage{fontspec}
% Body text: Source Sans 3 Regular (bundled in fonts/).
\setmainfont{SourceSans3}[
  Path = fonts/, Extension = .otf,
  UprightFont = *-Regular, BoldFont = *-Bold,
  ItalicFont  = *-It,      BoldItalicFont = *-BoldIt,
]
% Heading and label faces (intermediate weights for the hierarchy).
\newfontfamily\aulabelface{SourceSans3}[Path=fonts/, Extension=.otf,
  UprightFont=*-Medium, ItalicFont=*-It]
\newfontfamily\ausecface{SourceSans3}[Path=fonts/, Extension=.otf,
  UprightFont=*-Semibold]
% Code: Atkinson Hyperlegible Mono (bundled). Its 0/O and 1/l/I are
% unmistakable, which is exactly what source code needs -- the format
% rules' reason for allowing a different face for code.
\setmonofont{AtkinsonHyperlegibleMono}[
  Path = fonts/, Extension = .otf,
  UprightFont = *-Regular, BoldFont = *-Bold,
  ItalicFont  = *-Italic,  BoldItalicFont = *-BoldItalic,
  Scale = MatchLowercase,
]
% babel: language support, so \foreignlanguage{<lang>}{...} can mark
% phrases in other languages for screen readers (correct pronunciation),
% as the manual recommends. Under LuaLaTeX babel imports other languages
% on the fly, so \foreignlanguage{french}{...} needs no extra setup.
% (american = US English, matching the document language en-US.)
\RequirePackage[american]{babel}
\RequirePackage{csquotes}   % \enquote{...} for quotation marks

%% Math: unicode-math gives the LuaLaTeX tagging engine the information it needs
%% to emit MathML, so every formula is read by a screen reader. Source Sans has
%% no math companion, so STIX Two Math (bundled in fonts/) sets the formulas;
%% serif mathematics against a sans body is a long-standing convention.
\RequirePackage{unicode-math}
\setmathfont{STIXTwoMath-Regular.otf}[Path=fonts/]

%% Subscript/superscript size. The format rules: "Subscripts and
%% superscripts should be no more than 2 points smaller than the size of
%% the text font." For the 12 pt body this sets ALL scripts (exponents,
%% nested subscripts, footnote markers, \textsuperscript) to 10 pt
%% instead of LaTeX's defaults (8 pt / 6 pt). The second declaration
%% covers mathematics inside 10 pt contexts (captions, footnotes).
\DeclareMathSizes{12}{12}{10}{10}
\DeclareMathSizes{10}{10}{10}{10}

%% ----------------------------------------------------------------------
%% Spacing
%% ----------------------------------------------------------------------
\RequirePackage{setspace}
\auetd@bodyspacing % apply chosen body spacing
\setlength{\parindent}{0.5in}
% Allow a little extra space stretch as a last resort so long words or
% URLs do not run into the margin.
\setlength{\emergencystretch}{2em}
% Indent the FIRST paragraph after every heading too (Auburn wants the
% first line of the abstract etc. indented; keeps indentation uniform).
\RequirePackage{indentfirst}

\RequirePackage{etoolbox}
% Long quotations are single-spaced (per the format rules)
\AtBeginEnvironment{quote}{\singlespacing}
\AtBeginEnvironment{quotation}{\singlespacing}
% Code blocks are single-spaced too
\AtBeginEnvironment{Verbatim}{\singlespacing}
% Single-space footnotes regardless of body spacing
\AtBeginDocument{%
  \let\auetd@footnotetext\@footnotetext
  \renewcommand{\@footnotetext}[1]{\auetd@footnotetext{\begin{singlespace}#1\end{singlespace}}}%
}

%% ----------------------------------------------------------------------
%% Other useful packages
%% ----------------------------------------------------------------------
\RequirePackage{graphicx}
\RequirePackage{booktabs}
\RequirePackage[font={stretch=1.0}]{caption} % 12 pt single-spaced captions
% Caption label ("Table 2.1:") in Source Sans 3 Semibold; the caption text
% itself stays in the body face. With PDF tagging on the caption package's
% labelfont key is bypassed, so the label font is set through the kernel's
% own \fnum@... label macros, which the tagged caption code actually uses.
\renewcommand{\fnum@figure}{{\ausecface\figurename~\thefigure}}
\renewcommand{\fnum@table}{{\ausecface\tablename~\thetable}}
% Table text stays in the 12 pt body face: one size everywhere.
% Workaround: with PDF tagging on, the tagged-tabular code hoists a
% booktabs \toprule about one line upward, so it is drawn through the
% caption text above the table (visible in earlier versions of this
% template). Giving the rule extra glue above it (\abovetopsep, normally
% 0 pt) puts it back between the caption and the header row.
\setlength{\abovetopsep}{12pt}
\RequirePackage{enumitem}
% NOTE: do NOT pass enumitem-only keys (style=nextline, itemsep, ...) to the
% description environment -- on the newest LaTeX kernels the tagged-list
% ("block") code parses the description options itself and raises
% "Package block Error: Some keys ... are unknown" for anything but a few
% keys such as leftmargin=. The description lists below therefore use only
% leftmargin= and take the default (run-in) label style, which compiles on
% old and new kernels alike.
\RequirePackage{microtype}
% fancyvrb for code: its Verbatim/\VerbatimInput are tagged and read by
% screen readers. (listings and minted are NOT yet tagging-compatible.)
\RequirePackage{fancyvrb}

%% ----------------------------------------------------------------------
%% Commutative diagrams (tikz-cd), made tagging-safe AND accessible.
%% Drawing diagrams in LaTeX (rather than importing an image) keeps them
%% editable and resolution-independent. Two problems have to be solved for
%% them to work in this accessible/tagged template:
%%   1. On TeX Live 2025+ the math-to-MathML tagging engine makes "$" active
%%      and "grabs" each formula; tikz-cd's $-delimited matrix cells break
%%      that grab with a fatal \__math_grab_dollar_delim:w error.
%%      \MathCollectFalse turns the grab off locally (no-op on older kernels).
%%   2. A raw tikzpicture is tagged as a decorative Artifact, so a screen
%%      reader skips it. \auCDFigure wraps the diagram in a Figure structure
%%      with real Alt text, exactly like \includegraphics[alt=...] does.
%% \auCDFigure{<alt text>}{<tikz-cd code>} -- use it INSIDE a figure
%% environment, with \caption and \label as usual. Needs tikz-cd:
\RequirePackage{tikz-cd}
% zref-savepos lets us record the on-page position (in sp, from the page
% origin) of any point. We use it to find the four corners of the diagram
% so we can attach a /BBox to the Figure structure -- exactly what
% \includegraphics figures get automatically, and what PDF/UA checkers
% (PAC's "Figure on a single page with no bounding box") expect.
\RequirePackage{zref-savepos}
% \MathCollectFalse/\MathCollectTrue exist only when math tagging is on
% (TL2025+); make them harmless no-ops otherwise.
\providecommand{\MathCollectFalse}{}
\providecommand{\MathCollectTrue}{}
% \tagstructbegin/\tagstructend come from tagpdf; no-op fallback if absent.
\providecommand{\tagstructbegin}[1]{}
\providecommand{\tagstructend}{}
%% ----------------------------------------------------------------------
%% \auCDFigure draws the tikz diagram EXACTLY as a bare tikzpicture would
%% (so the existing tagging is untouched), but does two extra things:
%%  (a) it injects, via tikz's "execute at end picture" hook, two
%%      \zsavepos marks at the south-west and north-east corners of the
%%      diagram's bounding box;
%%  (b) once the page is shipped and those positions are known, it reads
%%      them back (sp -> bp) and writes a /BBox onto the still-open Figure
%%      structure with \tag_struct_gput, mirroring how latex-lab's graphic
%%      code attaches a /BBox to \includegraphics.
%% A per-figure counter gives each diagram unique savepos labels. Positions
%% need an extra LaTeX pass to settle (like any \label/savepos); until then
%% the four corners read 0 and the box is simply omitted that pass.
%% ----------------------------------------------------------------------
\newcounter{auCDfig}
% Helper (expl3): attach /O /Layout /BBox to the currently-open structure.
% \auCD@bbox{llx}{lly}{urx}{ury} -- all four arguments in bp (decimals).
\ExplSyntaxOn
% \auCD@bbox{<struct number>}{llx}{lly}{urx}{ury}
\cs_new_protected:Npn \auCD@bbox #1#2#3#4#5
  {
    \tag_struct_gput:ene { #1 } { attribute }
      { /O~/Layout~/BBox~[ #2 \c_space_tl #3 \c_space_tl #4 \c_space_tl #5 ] }
  }
% \auCD@grabnum -> stash the number of the structure we just opened.
\cs_new_protected:Npn \auCD@grabnum
  { \tl_set:Ne \auCD@num { \tag_get:n { struct_num } } }
% \auCD@bp{<dimen expression>} -> that length in bp as a bare decimal.
\cs_new:Npn \auCD@bp #1 { \dim_to_decimal_in_bp:n { #1 } }
\ExplSyntaxOff
% Guard: if expl3 tagging is not available (tagging off / old kernel),
% make the helpers harmless no-ops so the diagram still draws.
\providecommand{\auCD@bbox}[5]{}
\providecommand{\auCD@grabnum}{}
\providecommand{\auCD@num}{0}
\providecommand{\auCD@bp}[1]{0}
\newcommand{\auCDFigure}[2]{%
  \tagstructbegin{tag=Figure,alt={#1}}%
  \auCD@grabnum % remember THIS structure's number for the /BBox below
  \stepcounter{auCDfig}%
  % Names for this figure's two corner marks.
  \edef\auCD@sw{auCDsw\the\value{auCDfig}}%
  \edef\auCD@ne{auCDne\the\value{auCDfig}}%
  % Draw the diagram UNCHANGED, but tell every tikzpicture inside #2 to
  % drop a zero-size savepos node at its bounding-box SW and NE corners.
  {\MathCollectFalse
   \tikzset{every picture/.append style={execute at end picture={%
       \path (current bounding box.south west)
             node[inner sep=0pt,outer sep=0pt]{\zsavepos{\auCD@sw}};
       \path (current bounding box.north east)
             node[inner sep=0pt,outer sep=0pt]{\zsavepos{\auCD@ne}};}}}%
   #2}%
  % If both corners are known (positions non-zero, i.e. after the savepos
  % pass), attach the /BBox to the open Figure structure. \zposx/\zposy are
  % absolute page coordinates in sp -- the same frame latex-lab uses.
  \ifnum\numexpr\zposx{\auCD@sw}+\zposy{\auCD@sw}+\zposx{\auCD@ne}+\zposy{\auCD@ne}\relax=0 %
  \else
    \auCD@bbox{\auCD@num}%
      {\auCD@bp{\zposx{\auCD@sw}sp}}%
      {\auCD@bp{\zposy{\auCD@sw}sp}}%
      {\auCD@bp{\zposx{\auCD@ne}sp}}%
      {\auCD@bp{\zposy{\auCD@ne}sp}}%
  \fi
  \tagstructend}

%% ----------------------------------------------------------------------
%% Colour. The body text is black; the ONLY colour in the document is on
%% the teaching signposts -- the run-in "Why:"/"How:" labels and the
%% "Good:"/"Poor:" (do/don't) markers -- so a reader can find them at a
%% glance. The three shades all clear WCAG 2.1 AA contrast on white, and
%% every coloured label is ALSO a word set in bold, so the meaning never
%% depends on colour alone (exactly the rule that Section "Colour and
%% contrast" teaches, demonstrated live on the page):
%%   AccessibleNavy  ~12:1   Why:/How: lead-ins, \BlueText
%%   AccessibleGreen ~7.2:1  Good:/Right:, the right thing to do (\GreenText)
%%   AccessibleRed   ~5.9:1  Poor:/Wrong:, warnings, don't (\RedText)
%% To go fully monochrome, redefine the three helpers below as \textbf{#1}.
%% ----------------------------------------------------------------------
\RequirePackage{xcolor}
\definecolor{AccessibleNavy}{RGB}{16,45,98}   % ~12:1 on white
\colorlet{AccessibleRed}{red!80!black}         % ~5.9:1 on white
\colorlet{AccessibleGreen}{green!40!black}      % ~7.2:1 on white
\newcommand{\BlueText}[1]{\textcolor{AccessibleNavy}{\textbf{#1}}}
\newcommand{\RedText}[1]{\textcolor{AccessibleRed}{\textbf{#1}}}
\newcommand{\GreenText}[1]{\textcolor{AccessibleGreen}{\textbf{#1}}}
% \auLead -- a coloured, bold run-in label (e.g. "Why:" "How:").
\newcommand{\auLead}{\BlueText}% same as \BlueText; a name for run-in labels
% \auhead -- a table header cell in Source Sans 3 Semibold. Header cells
% stand out by weight (no rules or colour needed), per the format rules;
% wrap each cell of the header row: \auhead{Ring} & \auhead{Dim} & ...
% \auhead also writes a DIRECT /Scope attribute onto the cell's tag structure.
% \tagpdfsetup{table/header-rows=...} records Scope only in the shared ClassMap
% (the /C key), which PAC and Adobe ignore -> "table header cell has no
% associated subcells". A direct attribute is what those checkers read.
% \auhead = a COLUMN header (a header row); \auheadrow = a row/stub header.
\ExplSyntaxOn
\cs_new_protected:Npn \auetd@th@scope #1
  { \tag_struct_gput:nnn { \tag_get:n {struct_num} } {attribute} {/O~/Table~/Scope~/#1} }
\ExplSyntaxOff
\newcommand{\auhead}[1]{{\ausecface #1}\auetd@th@scope{Column}}
\newcommand{\auheadrow}[1]{{\ausecface #1}\auetd@th@scope{Row}}

%% Code blocks are plain fancyvrb Verbatim: single-spaced monospace,
%% no box, no background -- the change of face is the only signal.

%% ----------------------------------------------------------------------
%% Headings: quiet. Everything is 12 pt; the hierarchy is carried by
%% weight and white space alone. The top level is CENTRED -- numbered
%% chapter titles and the preliminary-page headings (Abstract, AI
%% disclosure, Acknowledgments, Table of Contents, Lists, References,
%% ...) are centred over the text block; section headings and below stay
%% left-aligned. Chapter pages start at the 1" top margin with a
%% "Chapter N" label (Medium) over the title (Bold), then two blank
%% lines. Sections are Semibold, subsections Medium, subsubsections
%% Italic. Headings are formatted through the kernel's OWN sectioning
%% hooks (\@makechapterhead, \@startsection), NOT titlesec, so the
%% tagging engine still tags them (chapter->H1, section->H2, ...). Do
%% NOT add titlesec.
%% ----------------------------------------------------------------------
\renewcommand{\@makechapterhead}[1]{%
  {\normalfont\centering
    \ifnum\c@secnumdepth>\m@ne
      {\aulabelface \@chapapp\space\thechapter\par}%
      \nobreak\vskip0.4\baselineskip
    \fi
    {#1\par}%
    \nobreak\vskip2.2\baselineskip}%
}
\renewcommand{\@makeschapterhead}[1]{%
  {\normalfont\centering
    {#1\par}%
    \nobreak\vskip2.2\baselineskip}%
}
%% TeX Live 2025+ workaround. On recent kernels \DocumentMetadata
%% (tagging=on) loads the new sectioning code (latex-lab-testphase-sec),
%% which typesets chapter titles through a heading TEMPLATE and no longer
%% calls the \@makechapterhead / \@makeschapterhead redefinitions above.
%% The kernel's default chapter template is \raggedright + \huge, so on
%% TL2025+ the titles silently come out LEFT-ALIGNED and oversized, while
%% older TeX Live (e.g. an older Overleaf compiler) still uses the centred
%% 12 pt \@makechapterhead. Re-center the chapter heading INSTANCE so the
%% intended look (centred, 12 pt, Medium "Chapter N" label, Bold title)
%% is restored on the new code too. This edits the ONE instance shared by
%% \chapter and \chapter*, so numbered chapters AND the preliminary pages
%% (Abstract, Table of Contents, References, ...) are all centred again.
%% On older kernels \IfInstanceExistsTF is undefined or the instance does
%% not exist, the block is skipped, and \@makechapterhead is used instead
%% -- so this is safe on every TeX Live version.
\AtBeginDocument{%
  \@ifundefined{IfInstanceExistsTF}{}{%
    \IfInstanceExistsTF{heading}{chapter}{%
      \EditInstance{heading}{chapter}{%
        heading-decls = \centering\normalfont\aulabelface\normalsize ,
        title-decls   = \normalfont\normalsize ,
      }%
    }{}%
  }%
}
\renewcommand\section{\@startsection{section}{1}{\z@}%
  {-3.2ex \@plus -1ex \@minus -.2ex}{1.4ex \@plus .2ex}%
  {\normalsize\ausecface}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
  {-2.75ex \@plus -1ex \@minus -.2ex}{1.0ex \@plus .2ex}%
  {\normalsize\aulabelface}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
  {-2.5ex \@plus -1ex \@minus -.2ex}{0.8ex \@plus .2ex}%
  {\normalsize\itshape}}

%% ----------------------------------------------------------------------
%% Theorem environments (numbered within chapters).
%% The format rules ask that italic type be limited to non-English words
%% and quotations -- and long italic passages are harder for low-vision
%% readers -- so every theorem-like environment uses an upright style
%% (Semibold head, roman black body) instead of the traditional italic
%% "plain" style. The label ("Theorem 2.1.") is Source Sans 3 Semibold,
%% black -- the same quiet weight the section headings and table headers
%% use. If your department expects italic theorem statements, switch the
%% \theoremstyle below back to "plain".
%% ----------------------------------------------------------------------
\newtheoremstyle{ausemibold}% name
  {\topsep}% space above
  {\topsep}% space below
  {\normalfont}% body font: upright roman, black
  {0pt}% indent
  {\normalfont\ausecface}% head font: Source Sans 3 Semibold, black
  {.}% punctuation after the head
  { }% space after the head
  {}% default head layout (label number, optional note)
\theoremstyle{ausemibold}
\newtheorem{theorem}{Theorem}[chapter]
\newtheorem{lemma}[theorem]{Lemma}
\newtheorem{proposition}[theorem]{Proposition}
\newtheorem{corollary}[theorem]{Corollary}
\newtheorem{definition}[theorem]{Definition}
\newtheorem{example}[theorem]{Example}
\newtheorem{remark}[theorem]{Remark}

%% Tagging robustness. A display-math environment (equation, align, ...)
%% immediately followed by a theorem-like environment with NO blank line
%% between them leaves the PDF tag tree unbalanced and untags everything that
%% follows (e.g. the bibliography). Forcing a \par at the start of every
%% theorem-like environment closes the preceding structure cleanly. In the
%% normal case (a blank line precedes the theorem) we are already in vertical
%% mode, so \par is a no-op and nothing changes visually.
\AtBeginEnvironment{theorem}{\par}
\AtBeginEnvironment{lemma}{\par}
\AtBeginEnvironment{proposition}{\par}
\AtBeginEnvironment{corollary}{\par}
\AtBeginEnvironment{definition}{\par}
\AtBeginEnvironment{example}{\par}
\AtBeginEnvironment{remark}{\par}

%% ----------------------------------------------------------------------
%% Table of contents / lists. 12 pt centered titles (made by \auPrelimHeading
%% below), dot leaders on every level, page numbers flush right.
%%
%% IMPORTANT: this template deliberately does NOT use the tocloft package.
%% On TeX Live 2025+ the new tagged-ToC code (latex-lab-testphase-toc) makes
%% the kernel's OWN \l@chapter/\@dottedtocline carry the hyperlink (so every
%% ToC line jumps to its chapter/section when clicked). tocloft replaces
%% those with its own NON-link-aware versions, which silently strips the
%% jumps -- the ToC entries stop being clickable. So instead of tocloft we
%% format the entries directly on top of the kernel's link-aware
%% \@dottedtocline: same look (Chapter-N prefix, dot leaders, indents) but
%% the entries stay live hyperlinks (and tagged ToC links).
%% ----------------------------------------------------------------------
\renewcommand{\contentsname}{Table of Contents}
\renewcommand{\listtablename}{List of Tables}
\renewcommand{\listfigurename}{List of Figures}

% Titles for the ToC / LoT / LoF are produced by \auPrelimHeading via the
% \auTableOfContents / \auListOfTables / \auListOfFigures wrappers below,
% so each one starts on its own page with the uniform 12 pt heading.

% Word printed before a top-level number in the ToC ("Chapter N ..."); the
% \auAppendices command switches it to "Appendix" for the appendix entries.
% (No @ in the name, so it survives being written to and read back from .toc.)
\newcommand{\auTocChapWord}{\chaptername}
% Chapter / preliminary-page entries: "Chapter N  Title ....... p" (numbered
% chapters) or "Abstract ....... p" (preliminary \chapter* pages, which have
% no number), normal weight, dot leaders. Built on the kernel's link-aware
% \@dottedtocline so each entry jumps to its page when clicked.
\newcommand{\auetd@lchapter}[2]{%
  \begingroup
    \let\auetd@savednumberline\numberline
    \def\numberline##1{\auetd@savednumberline{\auTocChapWord\ ##1}}%
    \@dottedtocline{0}{0em}{6.5em}{#1}{#2}%
  \endgroup}
% Apply at \begin{document}, AFTER the kernel's tagged-ToC code has installed
% its own link-aware \l@chapter/\l@section, so we override the right macros.
% Section / subsection entries are indented under the chapter.
\AtBeginDocument{%
  \let\l@chapter\auetd@lchapter
  \renewcommand*\l@section{\@dottedtocline{1}{2em}{2.8em}}%
  \renewcommand*\l@subsection{\@dottedtocline{2}{4em}{3.6em}}%
}

%% ----------------------------------------------------------------------
%% Pagination -- per the format rules: CONTINUOUS Arabic numbers
%% (1, 2, 3, ...) across the preliminary, body, and reference pages.
%% Every page is counted; every page except the title page shows its
%% number, centred at the bottom in 12 pt, >= 1/2" from the bottom edge
%% (1" bottom margin - 0.4" footskip = 0.6" from the edge). No running
%% header anywhere.
%% ----------------------------------------------------------------------
\RequirePackage{fancyhdr}
\fancypagestyle{plain}{%
  \fancyhf{}%
  \fancyfoot[C]{\normalfont\fontsize{12}{14}\selectfont\thepage}%
  \renewcommand{\headrulewidth}{0pt}%
  \renewcommand{\footrulewidth}{0pt}%
}
\pagestyle{plain}
\pagenumbering{arabic}  % title = 1 (hidden), Abstract = 2, ...

%% ----------------------------------------------------------------------
%% Bibliography (biblatex + biber). Entries single-spaced with a blank
%% line between them (per the format rules). Default style is alphabetic;
%% change the style= option below to suit your department.
%% ----------------------------------------------------------------------
\RequirePackage[backend=biber,style=alphabetic,sorting=nyt,giveninits=true,maxbibnames=99,doi=true,isbn=false]{biblatex}
\setlength{\bibitemsep}{\baselineskip}
\AtBeginBibliography{\singlespacing}

%% ----------------------------------------------------------------------
%% Hyperlinks (accessible), PDF metadata, bookmarks.
%% Monochrome: links are printed in black like everything else, and
%% external links are marked by the underline of \hrefu / \urlu (an
%% underline is a perfectly good non-colour cue). Bibliography URLs are
%% cued by the literal "URL:" prefix that biblatex prints, and by the
%% monospace face.
%% ----------------------------------------------------------------------
\RequirePackage[normalem]{ulem} % \uline for underlined links (normalem: \emph stays italic)
\RequirePackage{url}
\RequirePackage[bookmarksnumbered,bookmarksopen,bookmarksopenlevel=0]{hyperref}
\hypersetup{
  colorlinks = true,   % "coloured" black: suppresses the ugly link boxes
  linkcolor  = black,  % internal links (ToC, cross-references)
  urlcolor   = black,  % external URLs (underlined via \hrefu / \urlu)
  citecolor  = black,  % citations
  allbordercolors = black, % no coloured /C arrays in the annotations
  pdflang    = en-US,
  pdfdisplaydoctitle = true
}
\RequirePackage{bookmark} % robust PDF bookmarks (navigation outline / pane)
\urlstyle{tt} % URLs in Atkinson Hyperlegible Mono (0/O, 1/l unambiguous)
\newcommand{\hrefu}[2]{\href{#1}{\uline{#2}}} % underlined external hyperlink
\newcommand{\urlu}[1]{\uline{\url{#1}}}       % underlined, clickable bare URL
% Put the document title and author into the PDF metadata. WCAG 2.4.2
% (Page Titled) requires a title; pdfdisplaydoctitle then shows it in the
% viewer's title bar instead of the file name. (\auTitle/\auAuthor are set
% in the preamble of main.tex, so we read them at \begin{document}.)
\AtBeginDocument{\hypersetup{pdftitle={\auetd@title},pdfauthor={\auetd@author}}}

%% ----------------------------------------------------------------------
%% Title-page data commands
%% ----------------------------------------------------------------------
\newcommand{\auetd@title}{}
\newcommand{\auetd@author}{}
\newcommand{\auetd@degree}{}
\newcommand{\auetd@date}{}
\newcommand{\auetd@keywords}{}
\newcommand{\auetd@copyrightyear}{}
\newcommand{\auetd@chair}{}
\newcommand{\auetd@committeelines}{}

\newcommand{\auTitle}[1]{\renewcommand{\auetd@title}{#1}}
\newcommand{\auAuthor}[1]{\renewcommand{\auetd@author}{#1}}
\newcommand{\auDegree}[1]{\renewcommand{\auetd@degree}{#1}}
\newcommand{\auGradDate}[1]{\renewcommand{\auetd@date}{#1}}
\newcommand{\auKeywords}[1]{\renewcommand{\auetd@keywords}{#1}}
\newcommand{\auCopyrightYear}[1]{\renewcommand{\auetd@copyrightyear}{#1}}
% First "Approved by" line: chair (include the word "Chair"/"Co-chair").
\newcommand{\auChair}[1]{\renewcommand{\auetd@chair}{#1}}
% Each additional committee member (call once per member, in order).
\newcommand{\auCommitteeMember}[1]{\g@addto@macro\auetd@committeelines{\\#1}}

%% ----------------------------------------------------------------------
%% \auMakeTitlePage  -- builds the required title page exactly to spec.
%% ----------------------------------------------------------------------
\newcommand{\auMakeTitlePage}{%
  \thispagestyle{empty}%
  \begingroup
    \singlespacing
    \centering
    \vspace*{1in}% title sits 2" from the top (1" margin + 1")
    {\bfseries\auetd@title\par}% centred, bold, 12 pt (Auburn rule)
    \vspace{\baselineskip}%
    by\par
    \vspace{\baselineskip}%
    \auetd@author\par
    \vspace{4\baselineskip}%
    A \ifauetd@dissertation dissertation\else thesis\fi\ submitted to the Graduate Faculty of\\
    Auburn University\\
    in partial fulfillment of the\\
    requirements for the Degree of\\
    \auetd@degree\par
    \vspace{\baselineskip}%
    Auburn, Alabama\\
    \auetd@date\par
    \vspace{4\baselineskip}%
    \ifx\auetd@keywords\@empty\else
      Keywords: \auetd@keywords\par
      \vspace{2\baselineskip}%
    \fi
    \ifx\auetd@copyrightyear\@empty\else
      Copyright \auetd@copyrightyear\ by \auetd@author\par
      \vspace{2\baselineskip}%
    \fi
    Approved by\par
    \vspace{\baselineskip}%
    \auetd@chair\auetd@committeelines\par
  \endgroup
  \clearpage
}

%% ----------------------------------------------------------------------
%% \auPrelimHeading{Title} -- a 12 pt, centered, bold preliminary-page
%% heading (Abstract, AI disclosure, Acknowledgments, References, ...).
%% It is produced with \chapter*, so the heading is TAGGED as a level-1
%% heading (H1) for screen readers, started on a new page, and recorded
%% in the ToC and PDF bookmarks. Body text that follows is indented.
%% ----------------------------------------------------------------------
\newcommand{\auPrelimHeading}{\@ifstar\auetd@prelim@notoc\auetd@prelim@toc}
% Link targets are made with \MakeLinkTarget (not the legacy
% \phantomsection), so in a tagged PDF each destination is attached to a
% structure element and the ToC/bookmark links get a proper /Ref.
\newcounter{auetdprelim}
% starred form: no ToC entry (used by the Table of Contents page itself)
\newcommand{\auetd@prelim@notoc}[1]{%
  \chapter*{#1}%
  \markboth{}{#1}%
  \stepcounter{auetdprelim}%
  \MakeLinkTarget*{auetd-prelim-\theauetdprelim}%
  \pdfbookmark[0]{#1}{auetd-bm-\theauetdprelim}% bookmark (no ToC entry)
}
% unstarred form: also recorded in the ToC and the PDF bookmarks
\newcommand{\auetd@prelim@toc}[1]{%
  \chapter*{#1}%
  \markboth{}{#1}%
  \stepcounter{auetdprelim}%
  \MakeLinkTarget*{auetd-prelim-\theauetdprelim}%
  \addcontentsline{toc}{chapter}{#1}%
}

% Preliminary lists, each starting on its own page with a 12 pt heading.
\newcommand{\auTableOfContents}{\auPrelimHeading*{\contentsname}\@starttoc{toc}}
\newcommand{\auListOfTables}{\auPrelimHeading{\listtablename}\@starttoc{lot}}
\newcommand{\auListOfFigures}{\auPrelimHeading{\listfigurename}\@starttoc{lof}}

% Bibliography heading that matches the preliminary-page style
\defbibheading{auetd}[\bibname]{\auPrelimHeading{#1}}

%% ----------------------------------------------------------------------
%% Appendices: relabel as "Appendix 1, 2, ..." (Arabic), matching the
%% Graduate School sample. Call \auAppendices once before the appendices.
%% ----------------------------------------------------------------------
\newcommand{\auAppendices}{%
  \appendix
  \renewcommand{\thechapter}{\arabic{chapter}}%
  \setcounter{chapter}{0}%
  % Number everything inside an appendix with an "A" prefix (A1.1, Table
  % A1.1, equation (A1.1), ...) so appendix numbers can never collide
  % with the body's Chapter-N numbers in the ToC, the lists of tables
  % and figures, or cross-references.
  \renewcommand{\thesection}{A\arabic{chapter}.\arabic{section}}%
  \renewcommand{\thetable}{A\arabic{chapter}.\arabic{table}}%
  \renewcommand{\thefigure}{A\arabic{chapter}.\arabic{figure}}%
  \renewcommand{\theequation}{A\arabic{chapter}.\arabic{equation}}%
  \renewcommand{\thetheorem}{A\arabic{chapter}.\arabic{theorem}}%
  % Switch the ToC label from "Chapter N" to "Appendix N" at this point
  \addtocontents{toc}{\protect\renewcommand{\protect\auTocChapWord}{\appendixname}}%
}
\endinput
