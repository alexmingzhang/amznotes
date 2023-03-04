% ------------------------------------------------------------
% amznotes - Alex M Zhang notes
% Credit to David Zhang for the original template

% To fix header for unnumbered chapters, do:
% \chapter*{Chapter Title}
% \markboth{Chapter Title}{Chapter Title}

% TODO:
%   - make math in box titles bold
%   - make macro for lower case namerefs
%   - fix big numbers messing up index
%   - maybe make index two columns?
%   - macro \chapter* as the unnumbered chapter fix above

\ProvidesClass{amznotes}[2023/03/03 amznotes]
\NeedsTeXFormat{LaTeX2e}

\LoadClass[12pt]{report}

% ------------------------------------------------------------
% PROCESS OPTIONS

\RequirePackage{kvoptions}
\DeclareBoolOption{math}        % enables thmbox and math macros
\DeclareBoolOption{code}        % enables codebox, amzcode, and \amzinputcode
\DeclareBoolOption{fastcompile} % turns off some features for faster compiling

\ProcessKeyvalOptions{amznotes}

% ------------------------------------------------------------
% LOAD REQUIRED PACKAGES

\RequirePackage[margin=1in]{geometry}   % set margins
\RequirePackage{fontspec}               % set main font
\RequirePackage{unicode-math}           % set math font; replaces amssymb
\RequirePackage[dvipsnames]{xcolor}     % pretty colors
\RequirePackage{hyperref}               % hyperlinks in pdf viewers; will appear underlined only in pdf viewer
\RequirePackage{fancyhdr}               % fancy headers
\RequirePackage{lastpage}               % "X of Y" footer
\RequirePackage{parskip}                % new line after each paragraph w/o indent
\RequirePackage{setspace}               % 1.5 line spacing
\RequirePackage[explicit]{titlesec}     % chapter styling
\RequirePackage[most]{tcolorbox}        % pretty boxes
\RequirePackage{ifthen}                 % disable index entries not being used
\RequirePackage{multicol}
\RequirePackage{enumitem}                           % customize itemize spacing
\RequirePackage{xfrac}                              % small fractions
\RequirePackage[textsize=scriptsize]{todonotes}     % todo notes
\RequirePackage{tabularx}

\ifamznotes@math
    \RequirePackage{mathtools}          % for math macros; also loads amsmath
    \RequirePackage{amsthm}
    \renewcommand\qedsymbol{$\squoval$}
\fi

\ifamznotes@code
    \RequirePackage{minted}             % syntax coloring for code
    \tcbuselibrary{minted}
\fi

% ------------------------------------------------------------
% FONTS

\setmainfont{STIXTwoText}[
  Extension = .otf,
  UprightFont = *-Regular,
  BoldFont = *-SemiBold,
  ItalicFont = *-Italic,
  BoldItalicFont = *-SemiBoldItalic,
]
\setmathfont{STIXTwoMath-Regular.otf}
\setmathfont{STIXTwoMath-Regular.otf}[range={scr,bfscr},StylisticSet=01]
\setmonofont{Inconsolata}

% ------------------------------------------------------------
% PAGE LAYOUT


\onehalfspacing
\renewcommand{\arraystretch}{1.25}

% ------------------------------------------------------------
% COLORS

% Color palette from https://flatuicolors.com/palette/us
\definecolor{amzchaptercolor}{HTML}{0984e3}
\definecolor{amzdfnboxcolor}{HTML}{0984e3}
\definecolor{amzthmboxcolor}{HTML}{6c5ce7}
\definecolor{amzexboxcolor}{HTML}{fdcb6e}
\definecolor{amzgenboxcolor}{HTML}{00b894}
\definecolor{amztecboxcolor}{HTML}{e17055}
\definecolor{amzcodeboxcolor}{HTML}{2d3436}
\definecolor{amznoteboxcolor}{HTML}{d63031}

% ------------------------------------------------------------
% LINKS

\hypersetup{
    colorlinks=false,
    linkbordercolor=black,
    urlbordercolor=blue,
    pdfborderstyle={/S/U/W 1}   % Underline links; only appears in pdf viewer, not printed
}

% ------------------------------------------------------------
% CHAPTER STYLING

\ifamznotes@fastcompile
\else

\titleformat{\chapter}[display]
{\normalfont\huge\bfseries}
{}
{20pt}
{
    \begin{tcolorbox}[
        enhanced,
        left=23mm,
        right=25mm,
        top=2mm,
        spread sidewards,
        sharp corners,
        colback=amzchaptercolor,
        colframe=amzchaptercolor,
        boxrule=1mm,
        title=\thechapter,
        attach boxed title to top right={xshift=-15mm, yshift=-4mm},
        boxed title style={
            size=small,
            colback=amzchaptercolor,
            colframe=white
        }
    ]
        \strut \textcolor{white}{#1}
    \end{tcolorbox}
}

\titleformat{name=\chapter,numberless}[display]{\normalfont\huge\bfseries}
{}
{20pt}
{
    \begin{tcolorbox}[
        enhanced,
        left=23mm,
        right=25mm,
        top=2mm,
        spread sidewards,
        sharp corners,
        colback=amzchaptercolor,
        colframe=amzchaptercolor,
        boxrule=1mm,
    ]
        \strut \textcolor{white}{#1}
    \end{tcolorbox}
}

\titlespacing*{\chapter}{0pt}{-40mm}{-10mm}

\fi %\ifamznotes@fastcompile

% ------------------------------------------------------------
% SECTION STYLING

% \sectionfont{\color{amzchaptercolor}}  % sets colour of sections

% ------------------------------------------------------------
% HEADER STYLING

\ifamznotes@fastcompile
\else

\pagestyle{fancy}
\lhead{\footnotesize\nouppercase{\leftmark}}
\rhead{\footnotesize\nouppercase{\rightmark}}
\cfoot{\thepage\ of \pageref{LastPage}}

\fancypagestyle{plain}{
    \renewcommand{\headrulewidth}{0pt}
    \fancyhead{}
    \cfoot[C]{\thepage\ of \pageref{LastPage}}
}

\fi %\ifamznotes@fastcompile


% ------------------------------------------------------------
% COLOR BOXES
\newcommand{\amzcolorboxtitlesep}{\ \raisebox{2.3pt}{\scalebox{0.5}{ $\blacktriangleright$}}}

\ifamznotes@fastcompile
\tcbset{
    amzdefaultstyle/.style={
        fonttitle=\strut\bfseries,  % strut for uniform title height
        separator sign=\amzcolorboxtitlesep,
        breakable
    },
    genboxstyle/.style={
        amzdefaultstyle,
    },
    noteboxstyle/.style={breakable},
    codeboxstyle/.style={
        overlay={\begin{tcbclipinterior}\fill[darkgray!20!white] (frame.south west) rectangle ([xshift=6mm]frame.north west);\end{tcbclipinterior}},
        skin=bicolor,
        collower=white,
        colbacklower=darkgray
    },
}

%test

\else %\ifamznotes@fastcompile
\tcbset{
    amzdefaultstyle/.style={
        enhanced,
        drop fuzzy shadow,
        fonttitle=\strut\bfseries,  % strut for uniform title height
        boxrule=0pt,
        frame hidden,
        separator sign=\amzcolorboxtitlesep,
        parbox=false,               % normal paragraph spacing
        breakable,
    },
    genboxstyle/.style={
        amzdefaultstyle,
        frame style={fill=amzgenboxcolor!85!black},
        interior style={fill=amzgenboxcolor!5!white},
        segmentation style={solid,draw=amzgenboxcolor!50!black,opacity=0.25,line width=1pt}
    },
    noteboxstyle/.style={
        enhanced,
        boxrule=0pt,
        frame hidden,
        borderline west={4pt}{0pt}{amznoteboxcolor},
        colback=amznoteboxcolor!7!white,
        sharp corners,
    },
    codeboxstyle/.style={
        overlay={\begin{tcbclipinterior}\fill[darkgray!20!white] (frame.south west) rectangle ([xshift=6mm]frame.north west);\end{tcbclipinterior}},
        skin=bicolor,
        collower=white,
        colbacklower=darkgray
    },
}

\fi %\ifamznotes@fastcompile

% Give the index numbers some more space
\renewcommand{\l@tcolorbox}{\@dottedtocline{1}{0pt}{3em}}
\setlength{\columnsep}{3em}

\newcommand{\amzindex}{
    \addcontentsline{toc}{chapter}{Index}
    \chapter*{Index}

    % Remove header for index
    \renewcommand{\headrulewidth}{0pt}
    \fancyhead{}

    \begin{multicols}{2}
        \amzindexbody
    \end{multicols}
}

\newcommand{\amzindexbody}{}

\newcommand{\addindexentry}[2]{%
    \appto\amzindexbody{
        \iftoggle{#2}{
            \tcblistof[\section*]{#2}{#1}
        }{}
    }
}

%\newamzbox{environment name}{title}{ref label}{color}[tcolorbox style]
\newcounter{amzboxcounter}
\NewDocumentCommand{\newamzbox}{m m m m O{}}{
    \newtcbtheorem[use counter=amzboxcounter,number within=section,list inside={#3}]{tc#1}{#2}{
        amzdefaultstyle,
        frame style={fill=#4!85!black},
        interior style={fill=#4!5!white},
        segmentation style={solid,draw=#4!50!black,opacity=0.25,line width=1pt},
        #5
    }{#3}

    \providetoggle{#3}
    \settoggle{#3}{false}

    \newenvironment{#1}[2]{
        \global\settoggle{#3}{true}
        \begin{tc#1}{##1}{##2}
    }{
        \end{tc#1}
    }

    \newenvironment{#1*}[1]{
        \begin{tc#1*}{##1}
    }{
        \end{tc#1*}
    }

    \addindexentry{#2s}{#3}
}

\newamzbox{dfnbox}{Definition}{dfn}{amzdfnboxcolor}
\newamzbox{exbox}{Example}{ex}{amzexboxcolor}
\newamzbox{tecbox}{Technique}{tec}{amztecboxcolor}

\newtcolorbox{genbox}[1]{amzdefaultstyle, genboxstyle, title={#1}}
\newtcolorbox{notebox}{noteboxstyle}

\ifamznotes@math
    \newamzbox{lembox}{Lemma}{lem}{amzthmboxcolor}
    \newamzbox{thmbox}{Theorem}{thm}{amzthmboxcolor}
\fi

\ifamznotes@code
    \renewcommand{\theFancyVerbLine}{\ttfamily\scriptsize{\arabic{FancyVerbLine}}}

    \newamzbox{codebox}{Code Snippet}{code}{amzcodeboxcolor}[codeboxstyle]

    \newenvironment{amzcode}[2][]{
        \VerbatimEnvironment
        \begin{minted}[
        linenos,            % Display line numbers
        breaklines,         % Allow line breaks
        autogobble,         % Collapse extra white spaces
        xleftmargin=3.75mm,
        ]{#2}}
    {\end{minted}}

    \newcommand{\amzinputcode}[2]{\inputminted[
        linenos,            % Display line numbers
        breaklines,         % Allow line breaks
        autogobble,         % Collapse extra white spaces
        xleftmargin=3.75mm,
    ]{#1}{#2}}
\fi

% ------------------------------------------------------------
% TEXT MACROS

\newcommand{\dfntxt}[1]{\textit{\textbf{#1}}}

% from https://tex.stackexchange.com/a/150650
\newcommand{\tabitem}{~~\llap{\textbullet}~~}

% ------------------------------------------------------------
% MATH MACROS

\ifamznotes@math
    \newcommand{\rel}[1]{\mathrel{\mathcal{#1}}}

    \newcommand{\N}{\mathbb{N}}
    \newcommand{\Z}{\mathbb{Z}}
    \newcommand{\Q}{\mathbb{Q}}
    \newcommand{\R}{\mathbb{R}}
    \newcommand{\C}{\mathbb{C}}
    \newcommand{\F}{\mathbb{F}}

    \DeclareMathOperator{\laplace}{\mathscr{L}}
    \DeclareMathOperator{\proj}{proj}
    \DeclareMathOperator{\comp}{comp}

    \newcommand{\id}{\text{id}}
    \newcommand{\bigO}{\mathcal{O}}
    \newcommand{\symdiff}{\bigtriangleup}

    \newcommand{\alg}[1]{{\left\langle {#1} \right\rangle}}

    \DeclarePairedDelimiter\abs{\lvert}{\rvert}    \DeclarePairedDelimiter\norm{\lVert}{\rVert}
    \DeclarePairedDelimiter\ceil{\lceil}{\rceil}
    \DeclarePairedDelimiter\floor{\lfloor}{\rfloor}

    % Function Restriction
    % From https://tex.stackexchange.com/a/22255
    \newcommand\restrict[2]{{
        \left.\kern-\nulldelimiterspace
        #1
        \vphantom{\big|}
        \right|_{#2}
    }}
\fi %\ifamznotes@math
