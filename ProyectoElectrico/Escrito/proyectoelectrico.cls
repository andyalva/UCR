% ------------------------------------
% Universidad de Costa Rica
% Facultad de Ingeniería
% Escuela de Ingeniería Eléctrica
% IE0499 - Proyecto Eléctrico
%
% CLASE DE LATEX DEL TRABAJO ESCRITO
% ------------------------------------

% Declaraciones iniciales
% -----------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{proyectoelectrico}[2016/01/31 Informe del Proyecto Eléctrico de Ingeniería Eléctrica - UCR]
\LoadClass[letterpaper,11pt,twoside]{memoir}

\DeclareOption*{\PassOptionsToclass{\CurrentOption}{book}}

% Opciones de la clase
% --------------------

% Documento tipo borrador
\newif\ifborrador
\DeclareOption{borrador}{\borradortrue}

% Documento tipo ebook
\newif\ifebook
\DeclareOption{ebook}{\ebooktrue}

% Documento versión final
\newif\iffinal
\DeclareOption{final}{\finaltrue}

% Documento versión final
\newif\ifpordefecto
\DeclareOption{}{\pordefectotrue}

\ProcessOptions

% Paquetes requeridos
% -------------------

% General
\RequirePackage[english,spanish,es-noindentfirst,es-nolists,es-noquoting]{babel}
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage[calc,english]{datetime2}
\RequirePackage{xparse}

% Matemática
\RequirePackage{amsthm}
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amsfonts}

% Gráficas y figuras
\RequirePackage{graphicx}
\RequirePackage[lofdepth,lotdepth]{subfig}
\RequirePackage{tikz}
\RequirePackage{pgfplots}
\RequirePackage[american]{circuitikz}

% Estilo
\RequirePackage{siunitx}
\RequirePackage[colorlinks=true,urlcolor=blue,linkcolor=black,citecolor=green]{hyperref}
	\urlstyle{same}
\RequirePackage{float}
\RequirePackage{multicol}
\RequirePackage[leftcaption]{sidecap}
	\sidecaptionvpos{figure}{t}
\RequirePackage{enumitem}

% Bibliografía
\RequirePackage{cite}
%\bibliographystyle{apalike_es}

% Estilo del encabezado y pie de página
\createmark{chapter}{both}{shownumber}{}{. \ }
\nouppercaseheads
\spanishlcroman

% Otros ajustes
\setsecnumdepth{subsection}
\settocdepth{subsection}
\setfloatadjustment{figure}{\centering}
\setfloatadjustment{table}{\centering}

% Nuevos comandos especiales
% --------------------------

\newcolumntype{C}[1]{>{\centering\arraybackslash}m{#1}}

% Formato de la página y área de escritura
% ----------------------------------------

% Borrador
\ifborrador
	\settypeblocksize{20cm}{13cm}{*}
	\setbinding{0cm}
	\setulmargins{*}{*}{1}
	\setlrmargins{*}{*}{1}
	\checkandfixthelayout
	\usepackage{eso-pic}
	\usepackage{color}
	\usepackage{type1cm}
	\makeatletter
	\AddToShipoutPicture{%
		\setlength{\@tempdimb}{0.10\paperwidth}%
		\setlength{\@tempdimc}{0.50\paperheight}%
		\setlength{\unitlength}{1pt}%
		\put(\strip@pt\@tempdimb,\strip@pt\@tempdimc){%
			\makebox(0,0){\rotatebox{90}{\textcolor[gray]{0.75}{\fontsize{2.5cm}{2.5cm}
			\selectfont{BORRADOR}}}}
			}
	}
	\DoubleSpacing
	\openany
\fi

% E-Book
\ifebook
	\settypeblocksize{24cm}{19cm}{*}
	\setbinding{1.5cm}
	\setulmargins{*}{*}{1}
	\setlrmargins{*}{*}{1}
	\checkandfixthelayout
\fi

% Versión final o por defecto
\iffinal
	\settypeblocksize{20cm}{15cm}{*}
	\setbinding{1.5cm}
	\setulmargins{*}{*}{1}
	\setlrmargins{*}{*}{1}
	\checkandfixthelayout
\fi

\settypeblocksize{20cm}{15cm}{*}
\setbinding{1.5cm}
\setulmargins{*}{*}{1}
\setlrmargins{*}{*}{1}
\checkandfixthelayout

% Textos predefinidos
% -------------------

\newcommand{\UCR}{Universidad de Costa Rica}
\newcommand{\FI}{Facultad de Ingeniería}
\newcommand{\EIE}{Escuela de Ingeniería Eléctrica}
\newcommand{\PE}{IE0499 -- Proyecto Eléctrico}
\newcommand{\por}{por}
\newcommand{\lugar}{Ciudad Universitaria Rodrigo Facio}
\newcommand{\aprobado}{Aprobado por}
\newcommand{\introguia}{Profesor guía}
\newcommand{\introlectorA}{Profesor lector}
\newcommand{\introlectorB}{Profesor lector}

% Definición de datos globales del proyecto
% -----------------------------------------

\def\titulo#1{\gdef\@titulo{#1}}
\def\autor#1{\gdef\@autor{#1}}
\def\carne#1{\gdef\@carne{#1}}
\def\guia#1{\gdef\@guia{#1}}
\def\lectorA#1{\gdef\@lectorA{#1}}
\def\lectorB#1{\gdef\@lectorB{#1}}
\def\fecha#1{\gdef\@fecha{#1}}
\def\mes#1{\gdef\@mes{#1}}
\def\ano#1{\gdef\@ano{#1}}

% 1. Formato de portada
% ---------------------

\newcommand{\portada}{
\thispagestyle{empty}
\pdfbookmark[1]{Portada}{portada}
\begin{center}
	{\Large\bfseries\scshape\UCR}
    \vskip 0.7em
    {\Large\bfseries\FI}
    \vskip 0.5em
    {\Large\bfseries\EIE}
	\vskip 2em
    \large\bfseries\PE
	\vskip 4em
    \LARGE\bfseries\@titulo
	\vskip 2em
	\large\normalfont\por
	\vskip 1em
	\large\bfseries\@autor \\
	\vfill
	\large\bfseries\lugar
	\vskip 1em
	\large\normalfont\DTMMonthname{\@mes}{ de }\@ano
\end{center}
\cleardoublepage
}

% 2. Formato de la hoja de aprobación
% -----------------------------------

\newcommand{\aprobacion}{
\newpage
\thispagestyle{empty}
\pdfbookmark[1]{Firmas}{firmas}
\begin{center}
	\vspace*{2em} 
    \LARGE\bfseries\@titulo
	\vskip 2em
	\large\normalfont\por
	\vskip 1em
	\large\bfseries\@autor
    \vskip 1em
	\large\normalfont\@carne
	\vfill
	\large\bfseries\PE
	\vskip 0.5em
    \large\normalfont\aprobado
	\vskip 4em
	\rule {6cm}{0.1pt} \\
	\large\normalfont\@guia \\
	\large\itshape\introguia
	\vskip 3em
	\begin{tabular}{C{7cm}C{7cm}}
        \rule {6cm}{0.1pt} 
        & \rule {6cm}{0.1pt} 
        \\
		\large\normalfont\@lectorA 
        & \large\normalfont\@lectorB 
        \\ 
		\large\itshape\introlectorA 
        & \large\itshape\introlectorB
	\end{tabular}
    \vskip 2em
    \large\normalfont\DTMMonthname{\@mes}{ de }\@ano \\
\end{center}
\cleardoublepage
}

% 3. Formato del resumen
% ----------------------

\NewDocumentEnvironment{resumen}{ m }
{	% Encabezado
	\thispagestyle{empty}
	\pdfbookmark[1]{Resumen}{resumen}
	\begin{center}
		\large\bfseries Resumen
    	\vskip 1em
		\LARGE\bfseries \@titulo
   		\vskip 2em
		\large\normalfont\por 
    	\vskip 1em
		\large\bfseries\@autor
    	\vskip 1em
    	\normalfont\UCR\\\EIE\\\introguia{: }\@guia \\
        \DTMMonthname{\@mes}{ de }\@ano		
    	\vskip 1em
	\end{center} 
}{	% Pie
    \vskip 0.5em
    \noindent{\itshape {\bfseries Palabras claves}: #1.} 
    \vfill
	\noindent\hrulefill \\
	{\footnotesize \textbf{Acerca de \PE} \\ 
	El Proyecto Eléctrico es un curso semestral bajo la modalidad de trabajo individual supervisado, con el propósito de aplicar estrategias de diseño y análisis a un problema de temática abierta de la ingeniería eléctrica. Es un requisito de graduación para el grado de bachiller en Ingeniería Eléctrica de la Universidad de Costa Rica.
	}
	\cleardoublepage
}

% 4. Formato del abstract
% -----------------------

\NewDocumentEnvironment{theabstract}{ m m }
{	% Encabezado
	\thispagestyle{empty}
	\pdfbookmark[1]{Abstract}{abstract}
	\begin{center}
		\large\bfseries Abstract
    	\vskip 1em
		\LARGE\bfseries \@titulo
        \vskip 0em
		{\Large\normalfont Original in Spanish. Translated as: ``#1''}
    	\vskip 1em
		{\large\normalfont by}
    	\vskip 1em
		\large\bfseries\@autor
    	\vskip 1em
    	{\normalfont
        University of Costa Rica \\
        Department of Electrical Engineering \\
        Tutor: \@guia \\
        \DTMenglishmonthname{\@mes}{ of }\@ano
        }		
        \vskip 1em
	\end{center}    
}{	% Pie
	\vskip 0.5em
	\noindent{\itshape {\bfseries Keywords}: #2.} 
    \vfill
	\noindent\hrulefill \\
	{\footnotesize\textbf{About \PE\ (``Electrical Project'')} \\ 
	 The ``Electrical Project'' is a course of supervised individual work of one semester, with the purpose of applying design and analysis strategies to a problem in an open topic in electrical engineering. It is a requisite of graduation for the Bachelor of Science in Electrical Engineering, granted by the University of Costa Rica.
	}
	\cleardoublepage
}

% 5. Formato de la dedicatoria
% ----------------------------

\newenvironment{dedicatoria}
{
	\thispagestyle{empty}
    \begin{vplace}[0.333]
    \begin{flushright}
    \itshape
}{
    \end{flushright}
    \end{vplace}
    \cleardoublepage
}

% 6. Formato de los agradecimientos
% ---------------------------------

\newenvironment{agradecimientos}
{
	\thispagestyle{empty}
    \begin{vplace}[1]
    \begin{center}
    {\LARGE\bfseries Agradecimientos}
    \vskip 2em
}{
    \end{center}
    \end{vplace}
    \cleardoublepage
}

% Formato del título de los capítulos
% -----------------------------------

% Definición de \chapter{ }
\def\@makechapterhead#1{ 
  	\vspace*{5em}            
  	{
  	\parindent 0pt \raggedright
    \ifnum \c@secnumdepth >\m@ne     
      	\fontfamily{\sfdefault}\selectfont 
      	{\Large \scshape \@chapapp{} \thechapter}
      	\par
    	\vskip 5pt 
   	\fi                
    \fontfamily{\sfdefault}\selectfont 
    \huge\bfseries\scshape
    #1\par
    \nobreak                     
    \vskip 2em 
  	} 
}

% Definición de \chapter*{ }
\def\@makeschapterhead#1{
    \vspace*{5em}
  	{ 
    \parindent 0pt \raggedright
    \fontfamily{\sfdefault}\selectfont
    \huge\scshape\bfseries
    #1\par
    \nobreak
    \vskip 2em
	} 
}

% Estilos de capítulo predefinidos
%\chapterstyle{madsen} 	% (Ver "Various chapter styles for the memoir class" por Lars Madsen).

% Formato de las secciones
% ------------------------

% Sección
\setsecheadstyle{\Large\bfseries\fontfamily{\sfdefault}\selectfont}

% Sub-sección
\setsubsecheadstyle{\large\bfseries\fontfamily{\sfdefault}\selectfont}

% Sub-sub-sección
\setsubsubsecheadstyle{\normalfont\bfseries\fontfamily{\sfdefault}\selectfont}

% Párrafo
\setparaheadstyle{\normalfont\bfseries\fontfamily{\sfdefault}\selectfont}

% Sub-párrafo
\setsubparaheadstyle{\normalfont\bfseries\fontfamily{\sfdefault}\selectfont}

%%%%%%%%%
\endinput
%%%%%%%%%
