% pgc.cls
%
% A LaTeX2e document class for preparing pgc exercises sheets.

%% pgc.cls
%% Copyright (c) 2012 François Bianco, University of Geneva
%% under the GNU GPL v.3

\def\fileversion{1.0}
\def\filedate{2012/09/17}

\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{pgc}[\filedate\space Version \fileversion\space  by
  François Bianco]

\newif\if@exerciseoutput      \@exerciseoutputtrue % internal
\newif\ifissolution           \issolutionfalse % global

\DeclareOption{solution}     {\@exerciseoutputfalse\issolutiontrue}

\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}%
}
\ProcessOptions\relax
\LoadClass{article}

\RequirePackage{ifthen, verbatim, enumerate}

\usepackage[utf8x]{inputenc}
\usepackage[T1]{fontenc}
\usepackage[french]{babel}

\usepackage{textcomp}
\usepackage{amsfonts}
\usepackage{lmodern}
\usepackage{epsfig}
\usepackage{graphicx}
\usepackage{pstricks}
\usepackage{pst-plot}
\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{amstext}
\usepackage{cancel}
% \usepackage[colorlinks=true]{hyperref}
\usepackage[detect-all]{siunitx}

% Retro-compatibility with old PGC template
\newboolean{enonce}
\if@exerciseoutput
    \setboolean{enonce}{true}
\else
    \setboolean{enonce}{false}
\fi

%====================================================
% Macros physique générale
%====================================================
\renewcommand{\vec}[1]{\boldsymbol{#1}}

\newcommand\fbh{\fbox{H}\hspace{.5em}}
\newcommand\fbc{\fbox{C}\hspace{.5em}}
\newcommand\fbd{\fbox{D}\hspace{.5em}}

\newcommand\Deg{\ensuremath{^{\circ}}}
\newcommand\DegC{\ensuremath{^{\circ} C}}
\newcommand\un[1]{\ensuremath{\,\mathrm{#1}}}
\newcommand\produ{\ensuremath{\!\cdot\!}}
\newcommand\refeq[1]{(\ref{#1})}
\newcommand\reffig[1]{Fig.~\ref{#1}}


\newcommand\dd{{\ensuremath{\,\rm{d}}}}
%\newcommand{\dd}{\ensuremath{\text{d}}}
\newcommand{\dr}{\ensuremath{\dd r}}
\newcommand{\ds}{\ensuremath{\dd s}}
\newcommand{\dt}{\ensuremath{\dd t}}
\newcommand{\du}{\ensuremath{\dd u}}
\newcommand{\dv}{\ensuremath{\dd v}}
\newcommand{\dV}{\ensuremath{\dd V}}
\newcommand{\dx}{\ensuremath{\dd x}}
\newcommand{\dy}{\ensuremath{\dd y}}
\newcommand{\dz}{\ensuremath{\dd z}}

%====================================================
% End Macros physique générale B
%====================================================

% Fuzz
\hfuzz2pt % Don't bother to report over-full boxes if over-edge is < 2pt
\hfuzz-2pt


%---------------------------------------------------------------------
% This is partially Based on Exam class
%---------------------------------------------------------------------
%%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2003/12/01 or later.
%
%                         *****************
%                         ** PAGE LAYOUT **
%                         *****************


% We set the parameters in terms of \paperwidth and \paperheight
% so that the options

% a4paper
% a5paper
% b5paper
% letterpaper
% legalpaper
% executivepaper
% landscape

% will all work:

\setlength{\textwidth}{\paperwidth}
\addtolength{\textwidth}{-2in}
\setlength{\oddsidemargin}{0pt}
\setlength{\evensidemargin}{0pt}

\setlength{\headheight}{15pt}
\setlength{\headsep}{15pt}
\setlength{\topmargin}{0in}
\addtolength{\topmargin}{-\headheight}
\addtolength{\topmargin}{-\headsep}
\setlength{\footskip}{29pt}
\setlength{\textheight}{\paperheight}
\addtolength{\textheight}{-2.2in}

\setlength{\marginparwidth}{.5in}
\setlength{\marginparsep}{5pt}

%--------------------------------------------------------------------

%                          ****************
%                          ** EXTRAWIDTH **
%                          ****************

\newlength\@extrawidth

% \@rightmargin is needed for \pointsinrightmargin and
% \pointsdroppedatright, so that we can right justify the points:
\newlength\@rightmargin
\setlength{\@rightmargin}{1in}

% We put the argument of \extrawidth into a length so that it will
% work correctly even if it's negative:

\def\extrawidth#1{%
  \@extrawidth=#1
  \advance \textwidth by \@extrawidth
  \divide\@extrawidth by 2
  \advance\oddsidemargin by -\@extrawidth
  \advance\evensidemargin by -\@extrawidth
  % Bug fix, 13 April 2004:
  %\advance\@rightmargin by \@extrawidth
  \advance\@rightmargin by -\@extrawidth
}

%--------------------------------------------------------------------
%--------------------------------------------------------------------
%             Making room for large headers and footers

% The following are used to save the effect of any changes to
% \topmargin and \textheight caused by \extraheadheight or
% \extrafootheight commands.  They hold the values currently in effect.
% We put them into lengths so that it will work correctly even if the
% argument is negative:

\newlength\@extrahead
\newlength\@extrafoot
\setlength{\@extrahead}{0in}
\setlength{\@extrafoot}{0in}

% The following are used to hold the requested values for extrahead and
% extrafoot, first page and all pages after the first, and then the
% similar things requested for the cover pages:
\newlength\run@exhd
\newlength\fp@exhd
\newlength\run@exft
\newlength\fp@exft
\newlength\covrun@exhd
\newlength\covfp@exhd
\newlength\covrun@exft
\newlength\covfp@exft

\setlength{\run@exhd}{0in}
\setlength{\fp@exhd}{0in}
\setlength{\run@exft}{0in}
\setlength{\fp@exft}{0in}
\setlength{\covrun@exhd}{0in}
\setlength{\covfp@exhd}{0in}
\setlength{\covrun@exft}{0in}
\setlength{\covfp@exft}{0in}

\newcommand*\adj@hdht@ftht{%
  \if@coverpages
    \ifnum\value{page}=1\relax
      \@setheadheight{\covfp@exhd}%
      \@setfootheight{\covfp@exft}%
    \else
      \@setheadheight{\covrun@exhd}%
      \@setfootheight{\covrun@exft}%
    \fi
  \else
    \ifnum\value{page}=1\relax
      \@setheadheight{\fp@exhd}%
      \@setfootheight{\fp@exft}%
    \else
      \@setheadheight{\run@exhd}%
      \@setfootheight{\run@exft}%
    \fi
  \fi
}

\newcommand*\extraheadheight{%
  \@ifnextchar[{\@xtrahd}{\@ytrahd}%
}

\def\@xtrahd[#1]#2{%
  \setlength{\fp@exhd}{#1}%
  \setlength{\run@exhd}{#2}%
  \adj@hdht@ftht
}

\def\@ytrahd#1{%
  \setlength{\fp@exhd}{#1}%
  \setlength{\run@exhd}{#1}%
  \adj@hdht@ftht
}

\newcommand*\extrafootheight{%
  \@ifnextchar[{\@xtraft}{\@ytraft}%
}

\def\@xtraft[#1]#2{%
  \setlength{\fp@exft}{#1}%
  \setlength{\run@exft}{#2}%
  \adj@hdht@ftht
}

\def\@ytraft#1{%
  \setlength{\fp@exft}{#1}%
  \setlength{\run@exft}{#1}%
  \adj@hdht@ftht
}

\newcommand*\coverextraheadheight{%
  \@ifnextchar[{\cov@xtrahd}{\cov@ytrahd}%
}

\def\cov@xtrahd[#1]#2{%
  \setlength{\covfp@exhd}{#1}%
  \setlength{\covrun@exhd}{#2}%
  \adj@hdht@ftht
}

\def\cov@ytrahd#1{%
  \setlength{\covfp@exhd}{#1}%
  \setlength{\covrun@exhd}{#1}%
  \adj@hdht@ftht
}

\newcommand*\coverextrafootheight{%
  \@ifnextchar[{\cov@xtraft}{\cov@ytraft}%
}

\def\cov@xtraft[#1]#2{%
  \setlength{\covfp@exft}{#1}%
  \setlength{\covrun@exft}{#2}%
  \adj@hdht@ftht
}

\def\cov@ytraft#1{%
  \setlength{\covfp@exft}{#1}%
  \setlength{\covrun@exft}{#1}%
  \adj@hdht@ftht
}

\def\@appendoutput#1{%
  \output=\expandafter{\the\output #1}%
}

\@appendoutput{\adj@hdht@ftht}

%--------------------------------------------------------------------
%                 \@setheadheight and \@setfootheight:

\def\@setheadheight#1{%
  \begingroup % Avoid trouble from using \@temp and \@spaces
    % Reset the effect of the most recent change:
    \global\advance\topmargin by -\@extrahead
    \global\advance\textheight by \@extrahead
    % Save the newly set value:
    \def\@temp{#1}
    \def\@spaces{ }
    \ifx\@temp\@empty
      \global\@extrahead=0in
    \else
      \ifx\@temp\@spaces
        \global\@extrahead=0in
      \else
        \global\@extrahead=#1
      \fi
    \fi
    % Set the new values:
    \global\advance\topmargin by \@extrahead
    \global\advance\textheight by -\@extrahead
    % Make it take effect RIGHT NOW!:
    % (The following stuff isn't necessary if \@setheadheight is
    % executed only in the preamble or as we return from the output
    % routine, but we're leaving it in so that this will still work if
    % we use this at some random point in the middle of composing a
    % page).
    % Bugfix, Version 2.306beta, 2009/03/28:
    % We don't do this!!
    % If the user had a figure environment that floated to the
    % top of a page, then this would cause that page to run
    % over the footer and off the bottom of the page, because
    % this somehow caused a full page's worth of stuff to be
    % placed after the figure, as if the figure wasn't taking
    % up space on the page.
    % We *do* need to put \@colht at the correct new value, though,
    % apparently because \@colht is set near the end of the
    % output routine.
    \global\@colht=\textheight
%     \global\@colroom=\textheight
%     \global\vsize=\textheight
%     \global\pagegoal=\textheight
  \endgroup
}

\def\@setfootheight#1{%
  \begingroup % Avoid trouble from using \@temp and \@spaces
    % Reset the effect of the most recent change:
    \global\advance\textheight by \@extrafoot
    % Save the newly set value:
    \def\@temp{#1}
    \def\@spaces{ }
    \ifx\@temp\@empty
      \global\@extrafoot=0in
    \else
      \ifx\@temp\@spaces
        \global\@extrafoot=0in
      \else
        \global\@extrafoot=#1
      \fi
    \fi
    % Set the new values:
    \global\advance\textheight by -\@extrafoot
    % Make it take effect RIGHT NOW!:
    % (The following stuff isn't necessary if \@setfootheight is
    % executed only in the preamble or as we return from the output
    % routine, but we're leaving it in so that this will still work if
    % we use this at some random point in the middle of composing a
    % page).
    % Bugfix, Version 2.306beta, 2009/03/28:
    % We don't do this!!
    % If the user had a figure environment that floated to the
    % top of a page, then this would cause that page to run
    % over the footer and off the bottom of the page, because
    % this somehow caused a full page's worth of stuff to be
    % placed after the figure, as if the figure wasn't taking
    % up space on the page.
    % We *do* need to put \@colht at the correct new value, though,
    % apparently because \@colht is set near the end of the
    % output routine.
    \global\@colht=\textheight
%     \global\@colroom=\textheight
%     \global\vsize=\textheight
%     \global\pagegoal=\textheight
  \endgroup
}




%---------------------------------------------------------------------
%
%                      *************************
%                      ** HEADERS AND FOOTERS **
%                      *************************
%
% The pagestyles available are head, foot, headandfoot, and empty.
% \pagestyle{head} prints the head, and gives an empty foot.
% \pagestyle{foot} prints the foot, and gives an empty head.
% \pagestyle{headandfoot} prints both the head and the foot.
% \pagestyle{empty} gives an empty head and an empty foot.
%

%                            Pagestyles:

\newcommand*\ps@head{%
  \@dohead
  \@nofoot
}

\newcommand*\ps@headandfoot{%
  \@dohead
  \@dofoot
}

\newcommand*\ps@foot{%
  \@nohead
  \@dofoot
}

% \ps@empty is already defined by article.cls, so we'll
% say \def instead of \newcommand*:
\def\ps@empty{%
  \@nohead
  \@nofoot
}

\newif\if@coverpages
\@coverpagesfalse

\newcounter{num@coverpages}
% We'll set this to zero in case there is no coverpages environment:
\setcounter{num@coverpages}{0}

\newenvironment{coverpages}{%
    \ifnum \value{numquestions}>0\relax
      \ClassError{exam}{%
        Coverpages cannot be used after questions have begun.\MessageBreak
      }{%
        All question, part, subpart, and subsubpart environments
        \MessageBreak
        must begin after the cover pages are complete.\MessageBreak
      }%
    \fi
    \@coverpagestrue
    \pagenumbering{roman}%
    \adj@hdht@ftht
  }{%
    \clearpage
    \setcounter{num@coverpages}{\value{page}}%
    \addtocounter{num@coverpages}{-1}%
    \pagenumbering{arabic}%
    % Bugfix, Version 2.307\beta, 2009/06/11:
    % We have to say \@coverpagesfalse before \adj@hdht@ftht
    % because we're still inside the group created by the
    % coverpages environment and we want to set the
    % extraheadheight and extrafootheight to the values correct
    % for the first non-cover page:
    \@coverpagesfalse
    \adj@hdht@ftht
}

\newcommand*\cover@question@error{%
  \ClassError{exam}{%
    No questions are allowed in the cover pages.\MessageBreak
  }{%
    All question, part, subpart, and subsubpart environments
    \MessageBreak
    must begin after the cover pages are complete.\MessageBreak
  }%
}

\newcommand*\@dohead{%
  \def\@oddhead{%
    \if@coverpages
      \ifnum\value{page}=1\relax
        \cov@fullhead
      \else
        \covrun@fullhead
      \fi
    \else
      \ifnum\value{page}=1\relax
        \@fullhead
      \else
        \run@fullhead
      \fi
    \fi
  }% @oddhead
  \let\@evenhead=\@oddhead
}

\newcommand*\@dofoot{%
  \def\@oddfoot{%
    \if@coverpages
      \ifnum\value{page}=1\relax
        \cov@fullfoot
      \else
        \covrun@fullfoot
      \fi
    \else
      \ifnum\value{page}=1\relax
        \@fullfoot
      \else
        \run@fullfoot
      \fi
    \fi
  }% @oddfoot
  \let\@evenfoot=\@oddfoot
}

\newcommand*\@nohead{%
  \def\@oddhead{}%
  \let\@evenhead=\@oddhead
}

\newcommand*\@nofoot{%
  \def\@oddfoot{}%
  \let\@evenfoot=\@oddfoot
}

%--------------------------------------------------------------------
%       \@fullhead, \run@fullhead, \@fullfoot, and \run@fullfoot:

\newcommand*\@fullhead{%
  \vbox to \headheight{%
    \vss
    \hbox to \textwidth{%
      \normalfont\rlap{\parbox[b]{\textwidth}{\raggedright\@lhead\strut}}%
        \hss\parbox[b]{\textwidth}{\centering\@chead\strut}\hss
        \llap{\parbox[b]{\textwidth}{\raggedleft\@rhead\strut}}%
    }% hbox
    \if@headrule
      \hrule
    \else
      % an invisible hrule, to keep positioning constant:
      \hrule width 0pt
    \fi
  }% vbox
}

\newcommand*\run@fullhead{%
  \vbox to \headheight{%
    \vss
    \hbox to \textwidth{%
      \normalfont\rlap{\parbox[b]{\textwidth}{\raggedright\run@lhead\strut}}%
        \hss\parbox[b]{\textwidth}{\centering\run@chead\strut}\hss
        \llap{\parbox[b]{\textwidth}{\raggedleft\run@rhead\strut}}%
    }% hbox
    \ifrun@headrule
      \hrule
    \else
      % an invisible hrule, to keep positioning constant:
      \hrule width 0pt
    \fi
  }% vbox
}

% We arrange it so that the very top of first line of text in the
% foot is at a fixed position on the page, whether or not there's
% a footrule:

\newcommand*\@fullfoot{%
  \vbox to 0pt{%
    \if@footrule
      \hrule
    \else
      % an invisible hrule, to keep positioning constant:
      \hrule width 0pt
    \fi
    \vskip 3pt
    \hbox to \textwidth{%
      \normalfont\rlap{\parbox[t]{\textwidth}{\raggedright\@lfoot}}%
        \hss\parbox[t]{\textwidth}{\centering\@cfoot}\hss
        \llap{\parbox[t]{\textwidth}{\raggedleft\@rfoot}}%
    }% hbox
    \vss
  }% vbox
}

\newcommand*\run@fullfoot{%
  \vbox to 0pt{%
    \ifrun@footrule
      \hrule
    \else
      % an invisible hrule, to keep positioning constant:
      \hrule width 0pt
    \fi
    \vskip 3pt
    \hbox to \textwidth{%
      \normalfont\rlap{\parbox[t]{\textwidth}{\raggedright\run@lfoot}}%
        \hss\parbox[t]{\textwidth}{\centering\run@cfoot}\hss
        \llap{\parbox[t]{\textwidth}{\raggedleft\run@rfoot}}%
    }% hbox
    \vss
  }% vbox
}

%--------------------------------------------------------------------
%       \cov@fullhead, \covrun@fullhead, \cov@fullfoot, and
%       \covrun@fullfoot:

\newcommand*\cov@fullhead{%
  \vbox to \headheight{%
    \vss
    \hbox to \textwidth{%
      \normalfont\rlap{\parbox[b]{\textwidth}{\raggedright\cov@lhead\strut}}%
        \hss\parbox[b]{\textwidth}{\centering\cov@chead\strut}\hss
        \llap{\parbox[b]{\textwidth}{\raggedleft\cov@rhead\strut}}%
    }% hbox
    \ifcov@headrule
      \hrule
    \else
      % an invisible hrule, to keep positioning constant:
      \hrule width 0pt
    \fi
  }% vbox
}

\newcommand*\covrun@fullhead{%
  \vbox to \headheight{%
    \vss
    \hbox to \textwidth{%
      \normalfont\rlap{\parbox[b]{\textwidth}{\raggedright\covrun@lhead\strut}}%
        \hss\parbox[b]{\textwidth}{\centering\covrun@chead\strut}\hss
        \llap{\parbox[b]{\textwidth}{\raggedleft\covrun@rhead\strut}}%
    }% hbox
    \ifcovrun@headrule
      \hrule
    \else
      % an invisible hrule, to keep positioning constant:
      \hrule width 0pt
    \fi
  }% vbox
}

% We arrange it so that the very top of first line of text in the
% foot is at a fixed position on the page, whether or not there's
% a footrule:

\newcommand*\cov@fullfoot{%
  \vbox to 0pt{%
    \ifcov@footrule
      \hrule
    \else
      % an invisible hrule, to keep positioning constant:
      \hrule width 0pt
    \fi
    \vskip 3pt
    \hbox to \textwidth{%
      \normalfont\rlap{\parbox[t]{\textwidth}{\raggedright\cov@lfoot}}%
        \hss\parbox[t]{\textwidth}{\centering\cov@cfoot}\hss
        \llap{\parbox[t]{\textwidth}{\raggedleft\cov@rfoot}}%
    }% hbox
    \vss
  }% vbox
}

\newcommand*\covrun@fullfoot{%
  \vbox to 0pt{%
    \ifcovrun@footrule
      \hrule
    \else
      % an invisible hrule, to keep positioning constant:
      \hrule width 0pt
    \fi
    \vskip 3pt
    \hbox to \textwidth{%
      \normalfont\rlap{\parbox[t]{\textwidth}{\raggedright\covrun@lfoot}}%
        \hss\parbox[t]{\textwidth}{\centering\covrun@cfoot}\hss
        \llap{\parbox[t]{\textwidth}{\raggedleft\covrun@rfoot}}%
    }% hbox
    \vss
  }% vbox
}

%--------------------------------------------------------------------
%--------------------------------------------------------------------
%
%            ********************************************
%            ** COMMANDS TO DEFINE HEADERS AND FOOTERS **
%            ********************************************
%
% \lhead[#1]{#2} sets the first page left head to #1, and the
%   running left head to #2
%
% \lhead{#1} sets both the first page left head and the running
%   left head to #1
%
% \chead, \rhead, \lfoot, \cfoot, and \rfoot work similarly.
%
%
% \@lhead is the left head for Page 1
% \run@lhead is the running left head
% (i.e., for all pages other than the first)
%
% \@chead is the center head for Page 1
% \run@chead is the running center head
% (i.e., for all pages other than the first)
%
% etc.
%
% Alternative commands are:
% \firstpageheader{LEFT}{CENTER}{RIGHT}
% \runningheader{LEFT}{CENTER}{RIGHT}
% or
% \header{LEFT}{CENTER}{RIGHT}
% which is equivalent to the two commands
%          \firstpageheader{LEFT}{CENTER}{RIGHT}
%          \runningheader{LEFT}{CENTER}{RIGHT}
%
% Alternative commands are:
% \firstpagefooter{LEFT}{CENTER}{RIGHT}
% \runningfoother{LEFT}{CENTER}{RIGHT}
% or
% \footer{LEFT}{CENTER}{RIGHT}
% which is equivalent to the two commands
%          \firstpagefooter{LEFT}{CENTER}{RIGHT}
%          \runningfoother{LEFT}{CENTER}{RIGHT}

\def\firstpageheader#1#2#3{%
  \def\@lhead{#1}%
  \def\@chead{#2}%
  \def\@rhead{#3}%
}

\def\runningheader#1#2#3{%
  \def\run@lhead{#1}%
  \def\run@chead{#2}%
  \def\run@rhead{#3}%
}

\def\header#1#2#3{%
  \firstpageheader{#1}{#2}{#3}%
  \runningheader{#1}{#2}{#3}%
}

\def\firstpagefooter#1#2#3{%
  \def\@lfoot{#1}%
  \def\@cfoot{#2}%
  \def\@rfoot{#3}%
}

\def\runningfooter#1#2#3{%
  \def\run@lfoot{#1}%
  \def\run@cfoot{#2}%
  \def\run@rfoot{#3}%
}

\def\footer#1#2#3{%
  \firstpagefooter{#1}{#2}{#3}%
  \runningfooter{#1}{#2}{#3}%
}

\def\lhead{\@ifnextchar[{\@xlhead}{\@ylhead}}
\def\@xlhead[#1]#2{\def\@lhead{#1}\def\run@lhead{#2}}
\def\@ylhead#1{\def\run@lhead{#1}\def\@lhead{#1}}

\def\chead{\@ifnextchar[{\@xchead}{\@ychead}}
\def\@xchead[#1]#2{\def\@chead{#1}\def\run@chead{#2}}
\def\@ychead#1{\def\run@chead{#1}\def\@chead{#1}}

\def\rhead{\@ifnextchar[{\@xrhead}{\@yrhead}}
\def\@xrhead[#1]#2{\def\@rhead{#1}\def\run@rhead{#2}}
\def\@yrhead#1{\def\run@rhead{#1}\def\@rhead{#1}}

\def\lfoot{\@ifnextchar[{\@xlfoot}{\@ylfoot}}
\def\@xlfoot[#1]#2{\def\@lfoot{#1}\def\run@lfoot{#2}}
\def\@ylfoot#1{\def\run@lfoot{#1}\def\@lfoot{#1}}

\def\cfoot{\@ifnextchar[{\@xcfoot}{\@ycfoot}}
\def\@xcfoot[#1]#2{\def\@cfoot{#1}\def\run@cfoot{#2}}
\def\@ycfoot#1{\def\run@cfoot{#1}\def\@cfoot{#1}}

\def\rfoot{\@ifnextchar[{\@xrfoot}{\@yrfoot}}
\def\@xrfoot[#1]#2{\def\@rfoot{#1}\def\run@rfoot{#2}}
\def\@yrfoot#1{\def\run@rfoot{#1}\def\@rfoot{#1}}


%                    Initialize head and foot:

\pagestyle{headandfoot}

\lhead{}
\chead{}
\rhead{}
\lfoot{}
\cfoot[]{Page \thepage}
\rfoot{}

%--------------------------------------------------------------------
%                    Coverpage headers and footers
%
% \coverlhead[#1]{#2} sets the first cover page left head to #1, and the
%   running cover left head to #2
%
% \coverlhead{#1} sets both the first cover page left head and the running
%   cover left head to #1
%
% \coverchead, \coverrhead, \coverlfoot, \covercfoot, and \coverrfoot
% work similarly.
%
%
% \cov@lhead is the left head for Page 1
% \covrun@lhead is the running left head
% (i.e., for all pages other than the first)
%
% \cov@chead is the center head for Page 1
% \covrun@chead is the running center head
% (i.e., for all pages other than the first)
%
% etc.
%
% Alternative commands are:
% \coverfirstpageheader{LEFT}{CENTER}{RIGHT}
% \coverrunningheader{LEFT}{CENTER}{RIGHT}
% or
% \coverheader{LEFT}{CENTER}{RIGHT}
% which is equivalent to the two commands
%          \coverfirstpageheader{LEFT}{CENTER}{RIGHT}
%          \coverrunningheader{LEFT}{CENTER}{RIGHT}
%
% Alternative commands are:
% \coverfirstpagefooter{LEFT}{CENTER}{RIGHT}
% \coverrunningfoother{LEFT}{CENTER}{RIGHT}
% or
% \coverfooter{LEFT}{CENTER}{RIGHT}
% which is equivalent to the two commands
%          \coverfirstpagefooter{LEFT}{CENTER}{RIGHT}
%          \coverrunningfoother{LEFT}{CENTER}{RIGHT}

\def\coverfirstpageheader#1#2#3{%
  \def\cov@lhead{#1}%
  \def\cov@chead{#2}%
  \def\cov@rhead{#3}%
}

\def\coverrunningheader#1#2#3{%
  \def\covrun@lhead{#1}%
  \def\covrun@chead{#2}%
  \def\covrun@rhead{#3}%
}

\def\coverheader#1#2#3{%
  \coverfirstpageheader{#1}{#2}{#3}%
  \coverrunningheader{#1}{#2}{#3}%
}

\def\coverfirstpagefooter#1#2#3{%
  \def\cov@lfoot{#1}%
  \def\cov@cfoot{#2}%
  \def\cov@rfoot{#3}%
}

\def\coverrunningfooter#1#2#3{%
  \def\covrun@lfoot{#1}%
  \def\covrun@cfoot{#2}%
  \def\covrun@rfoot{#3}%
}

\def\coverfooter#1#2#3{%
  \coverfirstpagefooter{#1}{#2}{#3}%
  \coverrunningfooter{#1}{#2}{#3}%
}

\def\coverlhead{\@ifnextchar[{\cov@xlhead}{\cov@ylhead}}
\def\cov@xlhead[#1]#2{\def\cov@lhead{#1}\def\covrun@lhead{#2}}
\def\cov@ylhead#1{\def\covrun@lhead{#1}\def\cov@lhead{#1}}

\def\coverchead{\@ifnextchar[{\cov@xchead}{\cov@ychead}}
\def\cov@xchead[#1]#2{\def\cov@chead{#1}\def\covrun@chead{#2}}
\def\cov@ychead#1{\def\covrun@chead{#1}\def\cov@chead{#1}}

\def\coverrhead{\@ifnextchar[{\cov@xrhead}{\cov@yrhead}}
\def\cov@xrhead[#1]#2{\def\cov@rhead{#1}\def\covrun@rhead{#2}}
\def\cov@yrhead#1{\def\covrun@rhead{#1}\def\cov@rhead{#1}}

\def\coverlfoot{\@ifnextchar[{\cov@xlfoot}{\cov@ylfoot}}
\def\cov@xlfoot[#1]#2{\def\cov@lfoot{#1}\def\covrun@lfoot{#2}}
\def\cov@ylfoot#1{\def\covrun@lfoot{#1}\def\cov@lfoot{#1}}

\def\covercfoot{\@ifnextchar[{\cov@xcfoot}{\cov@ycfoot}}
\def\cov@xcfoot[#1]#2{\def\cov@cfoot{#1}\def\covrun@cfoot{#2}}
\def\cov@ycfoot#1{\def\covrun@cfoot{#1}\def\cov@cfoot{#1}}

\def\coverrfoot{\@ifnextchar[{\cov@xrfoot}{\cov@yrfoot}}
\def\cov@xrfoot[#1]#2{\def\cov@rfoot{#1}\def\covrun@rfoot{#2}}
\def\cov@yrfoot#1{\def\covrun@rfoot{#1}\def\cov@rfoot{#1}}


%                 Initialize coverpage head and foot:

\coverlhead{}
\coverchead{}
\coverrhead{}
\coverlfoot{}
\covercfoot{}
\coverrfoot{}




%--------------------------------------------------------------------
%--------------------------------------------------------------------

%                      Headrules and footrules:

\newif\if@headrule
\newif\ifrun@headrule

\def\firstpageheadrule{\@headruletrue}
\def\nofirstpageheadrule{\@headrulefalse}

\def\runningheadrule{\run@headruletrue}
\def\norunningheadrule{\run@headrulefalse}

\def\headrule{\@headruletrue\run@headruletrue}
\def\noheadrule{\@headrulefalse\run@headrulefalse}

\newif\if@footrule
\newif\ifrun@footrule

\def\firstpagefootrule{\@footruletrue}
\def\nofirstpagefootrule{\@footrulefalse}

\def\runningfootrule{\run@footruletrue}
\def\norunningfootrule{\run@footrulefalse}

\def\footrule{\@footruletrue\run@footruletrue}
\def\nofootrule{\@footrulefalse\run@footrulefalse}

%                             Initialize:

\noheadrule
\nofootrule

%                 Cover page headrules and footrules:

\newif\ifcov@headrule
\newif\ifcovrun@headrule

\def\coverfirstpageheadrule{\cov@headruletrue}
\def\nocoverfirstpageheadrule{\cov@headrulefalse}

\def\coverrunningheadrule{\covrun@headruletrue}
\def\nocoverrunningheadrule{\covrun@headrulefalse}

\def\coverheadrule{\cov@headruletrue\covrun@headruletrue}
\def\nocoverheadrule{\cov@headrulefalse\covrun@headrulefalse}

\newif\ifcov@footrule
\newif\ifcovrun@footrule

\def\coverfirstpagefootrule{\cov@footruletrue}
\def\nocoverfirstpagefootrule{\cov@footrulefalse}

\def\coverrunningfootrule{\covrun@footruletrue}
\def\nocoverrunningfootrule{\covrun@footrulefalse}

\def\coverfootrule{\cov@footruletrue\covrun@footruletrue}
\def\nocoverfootrule{\cov@footrulefalse\covrun@footrulefalse}

%                             Initialize:

\nocoverheadrule
\nocoverfootrule

%--------------------------------------------------------------------
%---------------------------------------------------------------------
%
%                    ***************************
%                    ** QUESTION ENVIRONMENTS **
%                    ***************************
%
%
%

% We define the command \part only inside of a parts environment, so
% that we don't interfere with the meaning of the standard article
% documentclass command \part if that is used inside of a questions
% environment.  The commands \question, \subpart, and \subsubpart are
% defined everywhere inside of a questions environment.  If the user
% accidentally gives a \subpart command outside of a subparts
% environment, then an error will be created.




% We use the counter name `partno' for the parts environment so that
% we will not interfere with the counter `part' used by the article
% document class.

\newcounter{choice}

%--------------------------------------------------------------------
%         choices (for multiple choice) and checkboxes


\renewcommand\thechoice{\alph{choice}}
\newcommand\choicelabel{\thechoice)}

% We will have \@correctchoicetrue when we're printing solutions
% and we're printing the correct choice of a choices or
% oneparchoices environment.
% We'll say \begingroup before saying \@correctchoicetrue
% and we'll say \endgroup at either the next \choice or \correctchoice
% or the end of the choices or oneparchoices environment.
% Thus, we'll never again need to say \@correctchoicefalse
\newif\if@correctchoice
\@correctchoicefalse

\newcommand\CorrectChoiceEmphasis[1]{%
  \def\CorrectChoice@Emphasis{#1}%
}
\CorrectChoiceEmphasis{\bfseries}
\let\correctchoiceemphasis\CorrectChoiceEmphasis

% Note: \do@choice@pageinfo is used in both the choices and
% the checkboxes environments.
\newtoks\choice@toks
\def\do@choice@pageinfo{%
  \choice@toks={%
%     \questionobject@pluspagecheck
    \choice@toks={}%
  }%
  % Version 2.217-beta changes:
  % Instead of appending stuff to \everypar, we insert
  % \the \pageinfo@commands and \the \point@toks
  % into the box \@labels:
  \global\setbox\@labels\hbox{\unhbox\@labels
    \the \choice@toks}%
  %   \edef\append@everypar{\noexpand\everypar={\the\everypar
  %                         \noexpand\the \noexpand\choice@toks}}%
  %   \append@everypar
}% do@choice@pageinfo



% Added 22 April 2004: Increased the \leftmargin by 2.5em,
% so the choices will be visibly indented.
\newenvironment{choices}%
  {\list{\choicelabel}%
     {\usecounter{choice}\def\makelabel##1{\hss\llap{##1}}%
       \settowidth{\leftmargin}{W. \hskip\labelsep}% \hskip 2.5em
       \def\choice{%
         \if@correctchoice
           \endgroup
         \fi
         \item
         \do@choice@pageinfo
       } % choice
       \def\CorrectChoice{%
         \if@correctchoice
           \endgroup
         \fi
         \ifissolution
           % We can't say \choice here, because that would
           % insert an \endgroup:
           \begingroup \@correctchoicetrue
           \CorrectChoice@Emphasis
         \fi
         \item
         \do@choice@pageinfo
       } % CorrectChoice
       \let\correctchoice\CorrectChoice
       \labelwidth\leftmargin\advance\labelwidth-\labelsep
       \topsep=0pt
       \partopsep=0pt
     }%
  }%
  {\if@correctchoice \endgroup \fi \endlist}
%%%%%%% End exam class code %%%%%%%%%%%%


%% PGC Stuff
%%
%%
%%
%%
%%
%%
%%
%%
%% PGC stuff
\setlength{\fboxsep}{2px}

\newenvironment{qcms}{
    \section*{QCM}
    \begin{enumerate}[\bf{Q}-1]
}{
    \end{enumerate}
}

\newenvironment{exos}{
    \section*{Exercices}
    \begin{enumerate}[\bf{E}-1]
}{
    \end{enumerate}
}

% Hide or show solution/exercise environments
% RequirePackage verbatim for \comment command
\newenvironment{exercise}%
        {%
            \if@exerciseoutput%
                    {}%
            \else%
                    \expandafter\comment%
            \fi%
         }
         {%
            \if@exerciseoutput%
                    {}%
            \else%
                    \expandafter\endcomment%
            \fi%
          }

\newenvironment{solution}%
        {%
            \if@exerciseoutput%
                    \expandafter\comment%
            \else%
                {}%
            \fi%
         }
         {%
            \if@exerciseoutput%
                    \expandafter\endcomment%
            \else%
                {}%
            \fi%
          }

\newcommand{\qcm}[1] {%
    \setcounter{equation}{0}%
    \renewcommand{\theequation}{\arabic{enumi}--\arabic{equation}}%
    \item \input{#1}%
    }
\newcommand{\exo}[1] {%
    \setcounter{equation}{0}%
    \renewcommand{\theequation}{\arabic{enumi}--\arabic{equation}}%
    \item \input{#1}%
    }

\newcommand{\pgcannees}{ANNEE}
\newcommand{\pgcserie}{NUMERO}
\newcommand{\pgcchapitres}{CHAPITRES}
\newcommand{\pgcdistribution}{DATE MOIS}
\newcommand{\pgccorrection}{DATE MOIS}
\newcommand{\pgcsujet}{SUJET}

\newcommand{\pgcserieheader}{%
    \if@exerciseoutput%
        Série%
    \else%
        Corrigé série%
    \fi%
}

\newcommand{\pgcpages}{
\pagestyle{headandfoot}%
\firstpageheader{{\bfseries\large Physique Générale C \pgcannees}\\%
Hecht chapitre(s) \pgcchapitres}{}{Distribution \pgcdistribution\\%
Corrections \pgccorrection}%
\runningheader{}{}{{\bfseries\large Physique Générale C \pgcannees}}%
\footer{\pgcserieheader{} \pgcserie}{}{\thepage}%
\footrule%
\extrafootheight{-.5cm}
}

\pgcpages

\newcommand{\pgctitle}{
  \begin{center}%
    \hrule height .2pt%
    \medskip{\Large\bfseries{\pgcserieheader{} \pgcserie :
\pgcsujet}\par}\medskip%
    \hrule height .2pt%
  \end{center}%
%   \bigskip%
\normalsize%
}

% boîte analyse dimensionnelle
\newcommand{\bad}[1] {\hfill\fbox{#1}\hspace{3em}\\}

% Change label for sublist, i.e exercise parts
\renewcommand{\labelenumii}{\alph{enumii})}

\AtBeginDocument{%
    \pgctitle%
}

%--------------------------------------------------------------------
%--------------------------------------------------------------------

\endinput
%---------------------------------------------------------------------
%---------------------------------------------------------------------
%---------------------------------------------------------------------
%---------------------------------------------------------------------
%---------------------------------------------------------------------
