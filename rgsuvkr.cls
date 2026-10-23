\NeedsTeXFormat{LaTeX2e}
\ProvidesExplClass{rgsuvkr}{2026-10-02}{1.0}{RGSU VKR}

\RequirePackage{iftex}
\RequireLuaTeX

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   параметры
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Объявление переменных с значениями по умолчанию
\tl_new:N \g_rgsuvkr_year_tl
\tl_gset:Nn \g_rgsuvkr_year_tl {2026}

\tl_new:N \g_rgsuvkr_name_tl
\tl_gset:Nn \g_rgsuvkr_name_tl {Иванов Сергей Петрович}

\tl_new:N \g_rgsuvkr_faculty_tl
\tl_gset:Nn \g_rgsuvkr_faculty_tl {Факультет политических и социальных технологий}

\tl_new:N \g_rgsuvkr_field_tl
\tl_gset:Nn \g_rgsuvkr_field_tl {Статистика, системный анализ и управление, обработка информации}

\tl_new:N \g_rgsuvkr_maintitle_tl
\tl_gset:Nn \g_rgsuvkr_maintitle_tl {Выпускная квалификационная работа}

\tl_new:N \g_rgsuvkr_title_tl
\tl_gset:Nn \g_rgsuvkr_title_tl {Тема работы}

% Обработка опций класса
\DeclareKeys
{
  year .tl_set:N = \g_rgsuvkr_year_tl,
  name .tl_set:N = \g_rgsuvkr_name_tl,
  faculty .tl_set:N = \g_rgsuvkr_faculty_tl,
  field .tl_set:N = \g_rgsuvkr_field_tl,
  maintitle .tl_set:N = \g_rgsuvkr_maintitle_tl,
  title .tl_set:N = \g_rgsuvkr_title_tl
}

\ProcessKeyOptions

% Пользовательские параметры
\NewDocumentCommand \rgsuvkrYear {}{
  \tl_use:N \g_rgsuvkr_year_tl
}

\NewDocumentCommand \rgsuvkrName {}{
  \tl_use:N \g_rgsuvkr_name_tl
}

\NewDocumentCommand \rgsuvkrFaculty {}{
  \tl_use:N \g_rgsuvkr_faculty_tl
}

\NewDocumentCommand \rgsuvkrField {}{
  \tl_use:N \g_rgsuvkr_field_tl
}

\NewDocumentCommand \rgsuvkrMainTitle {}{
  \tl_use:N \g_rgsuvkr_maintitle_tl
}

\NewDocumentCommand \rgsuvkrTitle {}{
  \tl_use:N \g_rgsuvkr_title_tl
}

% Загрузка базового класса
\LoadClass[twoside,14pt]{extreport}

\RequirePackage{geometry}
\geometry{left=3cm}
\geometry{right=2cm}
\geometry{top=2cm}
\geometry{bottom=2cm}


\linespread{1.3}
\RequirePackage{setspace}

\RequirePackage[no-math]{fontspec}

\RequirePackage{polyglossia}
\setmainlanguage[babelshorthands=true]{russian}
\setotherlanguage{english}

\defaultfontfeatures{Scale=MatchLowercase}
\setmainfont{erewhon}
\setromanfont{erewhon}
\setmonofont{Liberation Mono}

\newfontfamily\cyrillicfontsf{erewhon}

\RequirePackage[%
backend=biber,
bibencoding=utf8,
style=gost-numeric,
language=autobib,
autolang=other,
clearlang=true,
sortcites=true,
]{biblatex}

\RequirePackage{csquotes}

% Вначале выводим русскоязычныке источники по langid
\DeclareSourcemap{
    \maps[datatype=bibtex]{
        \map{
            \step[fieldsource=langid, match=russian, final]
            \step[fieldset=presort, fieldvalue={a}]
        }
        \map{
            \step[fieldsource=langid, notmatch=russian, final]
            \step[fieldset=presort, fieldvalue={z}]
        }
    }
}

% Перенос длинных URL в библиографии
\setcounter{biburllcpenalty}{7000}
\setcounter{biburlucpenalty}{8000}

% Запрет кодирования URL
\DeclareFieldFormat{url}{%
    \mkbibacro{URL}\addcolon\space
    \href{#1}{\nolinkurl{\thefield{urlraw}}}}

\makeatletter    
% Нумерация библиографии с точкой
\renewcommand\@biblabel[1]{#1.}
\makeatother

% автоматизация запрета на отрыв предлогов
\RequirePackage{luavlna}
\singlechars{russian}{ВСАКИОУвсакиоу}


\RequirePackage{microtype}


%*******************
% Списки
%*******************
\RequirePackage{enumitem}
% Используем короткое тире (endash) для ненумерованных списков
\renewcommand{\labelitemi}{\normalfont{--}}

\setlist{nosep, nolistsep, topsep=0pt, labelindent=*,leftmargin=*}

% счетчик кириллицей
\AddEnumerateCounter{\asbuk}{\russian@alph}{щ}

\RequirePackage{color}
\RequirePackage{graphicx}
\graphicspath{{images/}}


\RequirePackage[dvipsnames]{xcolor}



\renewcommand\labelitemi{--}

\RequirePackage{tabularray}

\DefTblrTemplate{contfoot-text}{default}{Продолжение на следующей странице}
\DefTblrTemplate{conthead-text}{default}{(Продолжение таблицы)}


\RequirePackage[labelfont={small}, textfont={small}]{caption}

\RequirePackage{lscape}

\RequirePackage{float}

% ***** Листинги *****
\RequirePackage[newfloat]{minted}
\setminted{
      baselinestretch=1.0,
       breaklines,
      %fontsize=\footnotesize,
      frame=lines,
      framesep=2mm
    }

\SetupFloatingEnvironment{listing}{name=Листинг}
\newenvironment{longlisting}{\captionsetup{type=listing}}{}

% Нумерация, счетчики

\renewcommand{\thelisting}{\arabic{listing}}
\renewcommand{\thefigure}{\arabic{figure}}

\RequirePackage{chngcntr}
\counterwithout{figure}{chapter}
\counterwithout{table}{chapter}

\RequirePackage{placeins}

\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage[math-style=TeX, math-style=ISO]{unicode-math}
%\setmathfont[Scale=MatchLowercase, StylisticSet={3,4}]{Erewhon Math}
\setmathfont[Scale=MatchLowercase, StylisticSet=2]{NewCMMath-Book}

\RequirePackage{siunitx}
\sisetup{detect-all, range-units = single, range-phrase= \text{--}, per-mode=symbol, output-decimal-marker = {,}}

% прямые начертания для констант, i и d
\def\eu{\ensuremath{\mathrm{e}}}
\def\iu{\ensuremath{\mathrm{i}}}
\def\du{\ensuremath{\mathrm{d}}}

\RequirePackage[pagestyles]{titlesec}
\RequirePackage{titletoc}


\titleformat{\chapter}[block]
  {\centering\bfseries} % Формат: центр, жирный, верхний регистр, запрет переносов
  {\thechapter.}          % Метка: номер главы с точкой
  {0.5em}                   % Отступ между меткой и текстом заголовка
  {\MakeUppercase}                      % Команда перед текстом (пусто)
  {}                      % Команда после текста (пусто)


\titleformat{\section}[block]
  {\normalfont\raggedright} % Формат: обычный шрифт, выравнивание влево, запрет переносов
  {\thesection.}          % Метка: номер раздела с точкой
  {0.5em}                   % Отступ между меткой и текстом
  {\parindent=1.5em\relax} % Абзацный отступ для первой строки заголовка
  {}                      % После текста


\titleformat{\subsection}[block]
  {\normalfont\raggedright}
  {\thesubsection.}
  {0.5em}
  {\parindent=1.5em\relax}
  {}



\titlespacing*{\chapter}
    {0pt} % left
    {0pt} % before
    {2em} % after



\titlecontents{chapter}
  [2em] % отступ слева (0pt = без отступа)
  {\addvspace{1.5ex}\normalfont\filright} % формат перед записью
  {\contentslabel[{\thecontentslabel.}]{1em}\MakeUppercase} % формат пронумерованной записи
  {\hspace*{-1em}\MakeUppercase} % формат ненумерованной записи
  {\titlerule*[0.5pc]{.}\contentspage} % заполнитель точками и номер страницы

% Раздел: обычный шрифт, небольшой отступ
\titlecontents{section}
  [3.5em] % отступ слева
  {\addvspace{0.5ex}\normalfont\filright}
  {\contentslabel[{\thecontentslabel.}]{1.7em}}
  {\hspace*{-1.5em}}
  {\titlerule*[0.5pc]{.}\contentspage}

% Подраздел: обычный шрифт, чуть больший отступ
\titlecontents{subsection}
  [4.5em] % отступ слева
  {\addvspace{0.5ex}\normalfont\filright}
  {\contentslabel[{\thecontentslabel.}]{2.5em}}
  {\hspace*{-2.5em}}
  {\titlerule*[0.5pc]{.}\contentspage}



\RequirePackage[final,
pdfauthor=\rgsuvkrName,
pdftitle=\rgsuvkrTitle, luatex]{hyperref} % adds hyper links inside the generated pdf file
\hypersetup{
	unicode=true,
	colorlinks=true,       % false: boxed links; true: colored links
	linkcolor=BlueViolet,        % color of internal links
	citecolor=RedViolet,        % color of links to bibliography
	filecolor=magenta,     % color of file links
	urlcolor=BlueViolet
}