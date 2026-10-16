%%
%% This is file `zhbook.cls',
%% 中文书籍 LaTeX 文档类 (基于 ctexbook)
%%
%% @author andy123t
%% @date 2024/01/11
%% @version v2.4
%% @address https://github.com/andy123t/zhbook
%%

%---------- 定义的新的Class ----------
\ProvidesClass{zhbook}[2024/01/11 v2.4]
\NeedsTeXFormat{LaTeX2e}

%---------- 定义的新的Options ----------
\newif\ifprint
\DeclareOption{print}{\printtrue}                                    % 打印模式: 封面等处生成空白页并隐藏链接颜色
\DeclareOption{openany}{\PassOptionsToClass{openany}{ctexbook}}      % 每章从任意页开始
\DeclareOption{openright}{\PassOptionsToClass{openright}{ctexbook}}  % 每章从奇数页开始
\DeclareOption{twoside}{\PassOptionsToClass{twoside}{ctexbook}}      % 双面排版
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}       % 其余选项透传给 ctexbook
\ProcessOptions\relax

%---------- 字体宏包选项 ----------
% 必须在载入 ctexbook 之前设置: ctexbook 内部会经 xeCJK 载入 fontspec
\PassOptionsToPackage{no-math}{fontspec}

%---------- 载入Class ----------
\LoadClass[UTF8,a4paper]{ctexbook}
\@ifclasslater{ctexbook}{2017/01/01}{}{%
    \ClassError{zhbook}{ctex >= 2017/01/01 is required ...}{}%
}

%---------- 定义页边距 ----------
\RequirePackage{geometry}
\geometry{left=3.0cm,right=3.0cm,top=3.0cm,bottom=2.8cm}  % 上下左右边距
%\geometry{centering,body={16cm,22cm}}                    % 备选: 固定版心尺寸
%\geometry{left=2.5cm,right=2.5cm,top=2.8cm,bottom=2.6cm} % 备选: 较窄的边距
\setlength{\headheight}{18pt}  % 页眉高度
\setlength{\headsep}{18pt}     % 页眉到正文的距离
\setlength{\footskip}{28pt}    % 正文到页码的距离

%---------- 常用宏包 ----------
\RequirePackage{amsmath,amssymb,amsthm}  % 数学公式、符号与定理
\RequirePackage{mathrsfs}                % 花体数学符号
\RequirePackage{graphicx}                % 插图
\RequirePackage{tabularx}                % 宽度自适应的表格
\RequirePackage{booktabs}                % 三线表
\RequirePackage{float}                   % 浮动体 [H] 选项
\RequirePackage{longtable}               % 跨页长表格
\RequirePackage{multirow}                % 合并行
\RequirePackage{multicol}                % 多栏排版
\RequirePackage{makecell}                % 单元格内换行
\RequirePackage{color,xcolor}            % 颜色
\RequirePackage{fancyhdr}                % 页眉页脚
\RequirePackage{etoolbox}                % 补丁工具
\RequirePackage{anyfontsize}             % 任意字号
\RequirePackage{titletoc}                % 目录条目格式
\RequirePackage{pdfpages}                % 插入外部 PDF
\RequirePackage[numbered]{bookmark}      % PDF 书签

%---------- 定义文档属性格式 ----------
\global\let\@title\@empty                         % 书名(封面主标题)
\global\let\@author\@empty                        % 作者
\global\let\@date\@empty                          % 日期
\newcommand\subtitle{\gdef\@subtitle}             % 副标题
%\newcommand\institute{\gdef\@institute}          % 机构(可选)
\newcommand\version{\gdef\@version}               % 版本
\newcommand\extrainfo{\gdef\@extrainfo}           % 封面底部附加信息
\newcommand\bioinfo[2]{\gdef\@bioinfo{{#1}：#2}}  % 作者的其他信息(键：值)

%---------- 重新定义 cleardoublepage ----------
% 双面排版时保证新的一页从奇数页开始, 必要时插入空白页
\renewcommand{\cleardoublepage}{\clearpage
    \clearpage\if@twoside\ifodd\c@page\else%
    \thispagestyle{empty}%
    \hbox{}\newpage\if@twocolumn\hbox{}\newpage\fi\fi\fi%
}

%---------- 设置超链接 ----------
\RequirePackage{hyperref}
\hypersetup{
    colorlinks=true,  % 用颜色标记链接(而非方框)
    linkcolor=black,  % 内部链接颜色
    citecolor=blue,   % 文献引用颜色
    filecolor=blue,   % 文件链接颜色
    urlcolor=blue     % 网址颜色
}

\ifprint
    \hypersetup{hidelinks} % 打印模式: 隐藏链接颜色和方框
\fi

%---------- 设置正文前页码为小写罗马数字 ----------
\renewcommand\frontmatter{%
    \ifprint\cleardoublepage\else\clearpage\fi  % 打印模式在此插入空白页
    \@mainmatterfalse
    \pagenumbering{roman}%
}

%---------- 设置正文页码为阿拉伯数字 ----------
\renewcommand\mainmatter{%
    \ifprint\cleardoublepage\else\clearpage\fi
    \pagenumbering{arabic}%
    \@mainmattertrue
}

%---------- 设置图片的路径 ----------
\graphicspath{{./figure/}{./figures/}{./image/}{./images/}}  % 这些目录中的图片可直接写文件名引用

%---------- 设置章节目录的深度 ----------
\setcounter{secnumdepth}{3}  % 章节编号到 subsubsection
\setcounter{tocdepth}{3}     % 目录收录到 subsubsection

%---------- 设置章节字号 ----------
\newcommand{\chapfont}{\fontsize{20bp}{28bp}\selectfont}  % 章标题字号

%---------- 定义章节标题格式 ----------
% 说明: format=标题字体; number=编号形式; aftername=编号与标题的间距; beforeskip/afterskip=标题前后间距
%--- chapter (章标题: 黑体居中) ---
\ctexset{
    chapter = {
        format = \linespread{1.0}\sffamily\heiti\chapfont\centering,
        nameformat = {},
        titleformat = {},
        number = \arabic{chapter},  % 章编号用阿拉伯数字
        numberformat = {},
        aftername = \quad,
        beforeskip = {6pt},
        afterskip = {24pt},
        %pagestyle = main,
    }
}
%--- section (节标题: 黑体小3号, 左对齐) ---
\ctexset{
    section = {
        format = \linespread{1.0}\sffamily\heiti\zihao{-3}\raggedright,
        numberformat = {},
        aftername = \quad,
        beforeskip = {18pt},
        afterskip = {6pt},
    }
}
%--- subsection (小节标题: 黑体4号, 左对齐) ---
\ctexset{
    subsection = {
        format = \linespread{1.0}\sffamily\heiti\zihao{4}\raggedright,
        numberformat = {},
        aftername = \quad,
        beforeskip = {12pt},
        afterskip = {6pt},
    }
}
%--- subsubsection (子小节标题: 黑体小4号, 左对齐) ---
\ctexset{
    subsubsection = {
        format = \linespread{1.0}\sffamily\heiti\zihao{-4}\raggedright,
        numberformat = {},
        aftername = \quad,
        beforeskip = {12pt},
        afterskip = {6pt},
    }
}
%--- appendix (附录编号: A, B, C, ...) ---
\ctexset{
    appendix = {
        numbering = true,
        number = \Alph{chapter},
    }
}

%---------- 算法宏包及设置 ----------
\RequirePackage{algorithm,algorithmicx}  % 算法浮动体环境
\RequirePackage{algpseudocode}           % 伪代码排版
\floatname{algorithm}{算法}              % 算法标题名称
\algrenewcommand\algorithmicrequire{\textbf{输入:}}  % Require 显示为"输入"
\algrenewcommand\algorithmicensure{\textbf{输出:}}   % Ensure 显示为"输出"

%------------- 设置附录 -----------
%\renewcommand{\appendixname}{附录}

%---------- 定义页眉页脚 (fancyhdr 宏包) ----------

%---------- 设置页眉样式 ----------
\newcommand{\headstyle}{
    %\fancyhead[C]{\fangsong\zihao{5} \@title}                       % 备选: 页眉居中显示书名
    \fancyhead[RO,LE]{\fangsong\zihao{5} $\cdot$\:\thepage\:$\cdot$} % 奇数页右侧/偶数页左侧: 页码
    \fancyhead[LO,RE]{\fangsong\zihao{5} \nouppercase{\leftmark}}    % 奇数页左侧/偶数页右侧: 章标题
}

%---------- 设置页脚样式 ----------
\newcommand{\footstyle}{
    \fancyfoot[C]{\zihao{5} \thepage}
    %\fancyfoot[LE]{\zihao{5} \thepage}
    %\fancyfoot[RO]{\zihao{5} \thepage}
}

%---------- 重定义plain样式 (章首页: 无页眉页脚) ----------
\fancypagestyle{plain}{%
    \fancyhf{}
    %\footstyle  % 如需章首页显示页码, 可取消本行注释
    \renewcommand{\headrulewidth}{0pt}
    \renewcommand{\footrulewidth}{0pt}
}

%---------- 定义main样式 (正文默认页眉页脚) ----------
\fancypagestyle{main}{%
    \fancyhf{}
    \headstyle
    \renewcommand{\headrulewidth}{0.5pt}  % 页眉线宽
    \renewcommand{\footrulewidth}{0pt}    % 页脚线宽
}

\pagestyle{main}

%---------- 中文段落缩进和行距 ----------
\setlength{\parindent}{2em}                   % 段首缩进 2 个汉字
\setlength{\parskip}{4pt plus 1pt minus 1pt}  % 段落间距
\linespread{1.35}  % 行距 1.35 倍
%\renewcommand{\baselinestretch}{1.35}
%\topskip=15pt   % 书写区域顶部空白
%\setlength{\baselineskip}{24pt}

%---------- 浮动对象设置 ----------
% 浮动对象的缺省值稍微宽松一点, 允许页面上放置更多的浮动体
\renewcommand{\textfraction}{0.15}       % 一页中最少的正文比例
\renewcommand{\topfraction}{0.85}        % 页顶浮动体占比上限
\renewcommand{\bottomfraction}{0.65}     % 页底浮动体占比上限
\renewcommand{\floatpagefraction}{0.60}  % 浮动页中浮动体的占比下限

%---------- 设置图表格式 ----------
\numberwithin{figure}{chapter}    % 图按章编号(如图 2.1)
\numberwithin{equation}{chapter}  % 公式按章编号(如式 2.1)
%\renewcommand{\thetable}{\thechapter.\arabic{table}}
%\renewcommand{\thefigure}{\thechapter.\arabic{figure}}

%--------- 定制图形和表格标题的样式 ----------
\RequirePackage{caption}
\captionsetup{font={small,singlespacing},labelformat={default},labelsep=quad}  % 标题用小字号, 单倍行距
\captionsetup[figure]{position=bottom,skip={6pt},name={图}}   % 图题在图的下方
\captionsetup[table]{position=top,skip={3pt},name={表}}       % 表题在表的上方
\setlength{\textfloatsep}{12pt plus 2pt minus 2pt}  % 页顶/页底浮动体与正文的距离
\setlength{\floatsep}{10pt plus 2pt minus 2pt}      % 相邻浮动体之间的距离
\setlength{\intextsep}{10pt plus 2pt minus 2pt}     % 文中浮动体与正文的距离
%\setlength{\abovecaptionskip}{2pt plus 1pt minus 1pt}
%\setlength{\belowcaptionskip}{3pt plus 1pt minus 2pt}

%---------- 重新设置图表autoref ----------
\renewcommand{\figureautorefname}{图}  % \autoref 引用图时的前缀
\renewcommand{\tableautorefname}{表}   % \autoref 引用表时的前缀

%---------- 使用tabularx库并定义新的左右中格式 ----------
\newcolumntype{L}{X}                                     % 宽度自适应, 左对齐
\newcolumntype{C}{>{\centering \arraybackslash}X}        % 宽度自适应, 居中
\newcolumntype{R}{>{\raggedleft \arraybackslash}X}       % 宽度自适应, 右对齐
\newcolumntype{P}[1]{>{\centering \arraybackslash}p{#1}} % 指定宽度且居中

%---------- 设置三线表格式 ----------
% \setlength{\heavyrulewidth}{1.5pt}
% \setlength{\lightrulewidth}{0.5pt}
% \setlength{\cmidrulewidth}{0.5pt}
% \setlength{\aboverulesep}{0pt}
% \setlength{\belowrulesep}{0pt}
% \setlength{\abovetopsep}{0pt}
% \setlength{\belowbottomsep}{0pt}

%---------- 数学定理设置 ----------
% 定理样式: {上方间距}{下方间距}{正文格式}{正文缩进}{标题格式}{标题后标点}{标题与正文间距}{标题后内容}
\newtheoremstyle{zhbook}
{0.5\topsep}{0.5\topsep}
{\itshape}{}{\bfseries}
{.}{5pt plus 1pt minus 1pt}{}
%\theoremstyle{plain}
\theoremstyle{zhbook}
% 定义各定理类环境, 均按章编号
\newtheorem{definition}{定义}[chapter]
\newtheorem{proposition}{命题}[chapter]
\newtheorem{lemma}{引理}[chapter]
\newtheorem{theorem}{定理}[chapter]
\newtheorem{example}{例}[chapter]
\newtheorem{corollary}{推论}[chapter]
\newtheorem{remark}{注}[chapter]
\newtheorem{exercise}{练习}[chapter]
\newtheorem{assumption}{假设}[chapter]
\newtheorem{axiom}{公理}[chapter]
\newtheorem{property}{性质}[chapter]
\newtheorem{conjecture}{猜想}[chapter]
%\renewcommand{\qedsymbol}{$\blacksquare$}  % 证毕符号(可自行更换)
\renewcommand{\proofname}{证明}  % 证明环境标题
\renewenvironment{proof}[1][\proofname]{\par  % 重定义证明环境: 标题加粗, 结尾加证毕符号
    \pushQED{\qed}%
    %\normalfont \topsep6\p@\@plus6\p@\relax
    \normalfont \topsep3\p@\@plus3\p@\relax
    \trivlist\item[\hskip\labelsep
    \bfseries #1\@addpunct{\,:\,}]\ignorespaces
}{%
    \popQED\endtrivlist\@endpefalse
}

%---------- 数学公式设置 ----------
\allowdisplaybreaks[4]  % 允许公式跨页断行

%---------- 设置公式间距 ----------
\AtBeginDocument{
    \setlength{\abovedisplayskip}{6pt plus 2pt minus 2pt}       % 长公式上方间距
    \setlength{\belowdisplayskip}{6pt plus 2pt minus 2pt}       % 长公式下方间距
    \setlength{\abovedisplayshortskip}{3pt plus 1pt minus 1pt}  % 短公式上方间距
    \setlength{\belowdisplayshortskip}{3pt plus 1pt minus 1pt}  % 短公式下方间距
    %\setlength{\arraycolsep}{2pt}
}

%------- 公式编号带章节 ----------
% 已在本文件"设置图表格式"一节统一设置 \numberwithin{equation}{chapter}
%\renewcommand{\theequation}{\arabic{chapter}.\arabic{equation}}

% 重新设置公式autoref
\renewcommand{\equationautorefname}{公式}  % \autoref 引用公式时的前缀

%---------- 定义列表项的样式 ----------
\RequirePackage{enumitem}  % 列表间距控制
\setlist{nolistsep}        % 列表项之间不留额外间距

%---------- 定义新的标题页面 (封面) ----------
\renewcommand{\maketitle}[1][15em]{  % 参数 #1 为预留接口, 暂未使用
    \clearpage
    \phantomsection
    \pdfbookmark[0]{封~~面}{cover}  % 在 PDF 书签中添加"封面"
    \begin{titlepage}
        \centering
        \scshape  % 小体大写字母

        \vspace*{3.0\baselineskip}

        \rule{\textwidth}{1.6pt}\vspace*{-\baselineskip}\vspace*{2pt}  % 标题框上粗线
        \rule{\textwidth}{0.5pt}   % 标题框上细线

        \vspace*{0.75\baselineskip} % 标题上方留白

        \parbox[t]{15cm}{\centering \zihao{1}\sffamily\heiti \@title  % 书名: 1号黑体
        \ifx\@subtitle\undefined{}
        \else
        \par
        \vspace*{0.25\baselineskip}
        \zihao{2}\sffamily\heiti \@subtitle  % 副标题: 2号黑体
        \fi
        }

        \vspace*{0.75\baselineskip} % 标题下方留白

        \rule{\textwidth}{0.5pt}\vspace*{-\baselineskip}\vspace{3.2pt} % 标题框下细线
        \rule{\textwidth}{1.6pt}   % 标题框下粗线

        \vspace*{1\baselineskip}  % 标题区域后留白

        {\large\kaishu \renewcommand{\arraystretch}{1.2}  % 作者等信息: 楷体, 行高 1.2
        \begin{tabular}{c}
        \ifx\@author\empty{}\else 作者：\@author \\ \fi
        %\ifx\@institute\undefined{}\else 机构：\@institute \\ \fi
        \ifx\@date\empty{}\else 日期：\@date \\ \fi
        \ifx\@version\undefined{}\else 版本：\@version \\ \fi
        \ifx\@bioinfo\undefined{}\else \@bioinfo \\ \fi
        \end{tabular}}

        \vspace*{\fill}

        {\large \ifx\@extrainfo\undefined{}\else \@extrainfo \fi} % 封面底部附加信息

        \vspace*{0.1\baselineskip}
    \end{titlepage}
    \ifprint
        \cleardoublepage  % 打印模式: 封面后加空白页
        \hypersetup{hidelinks} % 隐藏链接颜色和方框
    \else
        \clearpage
    \fi
    \if@openright
        \cleardoublepage  % openright 模式: 保证正文从奇数页开始
    \fi
}

%---------- 定义中英文关键词 ----------
%--- 中文关键词 (用法: \cnkeywords{关键词1；关键词2})
\newcommand{\cnkeywords}[1]{%
    \vspace*{0.8\baselineskip}\par
    \noindent {\bfseries 关键词:~} #1}
%--- 英文关键词
\newcommand{\enkeywords}[1]{%
    \vspace*{0.8\baselineskip}\par
    \noindent {\bfseries Key Words:~} #1}

%---------- 中文摘要环境 (自动加入目录) ----------
\newenvironment{cnabstract}{
    \clearpage
    \pagestyle{main}
    \phantomsection
    \addcontentsline{toc}{chapter}{摘~~要}  % 添加目录条目
    \chapter*{摘~~要}                      % 不编号的章标题
    \chaptermark{摘~~要}                   % 页眉中显示的标题
}{
    \clearpage
}

%---------- 英文摘要环境 (自动加入目录) ----------
\newenvironment{enabstract}{
    \clearpage
    \pagestyle{main}
    \phantomsection
    \addcontentsline{toc}{chapter}{Abstract}
    \chapter*{Abstract}
    \chaptermark{Abstract}
}{
    \clearpage
}

%---------- 前言环境 (自动加入目录) ----------
\newenvironment{preface}[1][前~~言]{
    \clearpage
    \pagestyle{main}
    \phantomsection
    \addcontentsline{toc}{chapter}{#1}
    \chapter*{#1}
    \chaptermark{#1}
}{
    \clearpage
    \if@openright
        \cleardoublepage
    \fi
}

%---------- 定义新的目录页面 ----------
\RequirePackage{tocloft}  % 定制目录格式
\renewcommand{\cfttoctitlefont}{\hfill \heiti \chapfont}  % 目录标题: 黑体居中
\renewcommand{\cftaftertoctitle}{\hfill}
\renewcommand{\cftloftitlefont}{\hfill \heiti \chapfont}  % 插图清单标题: 黑体居中
\renewcommand{\cftafterloftitle}{\hfill}
\renewcommand{\cftlottitlefont}{\hfill \heiti \chapfont}  % 表格清单标题: 黑体居中
\renewcommand{\cftafterlottitle}{\hfill}
\renewcommand{\contentsname}{目~~录}
\renewcommand{\listfigurename}{插图清单}
\renewcommand{\listtablename}{表格清单}
\setlength{\cftbeforetoctitleskip}{8pt}    % 目录标题上间距
\setlength{\cftaftertoctitleskip}{20pt}    % 目录标题下间距
\setlength{\cftbeforechapskip}{12pt}       % 章条目前间距
\setlength{\cftbeforesecskip}{3pt}         % 节条目前间距
\setlength{\cftbeforesubsecskip}{3pt}      % 小节条目前间距
\renewcommand{\cftdot}{$\cdot$}            % 引导点用"·"
\renewcommand{\cftdotsep}{3}               % 引导点间距
\renewcommand{\cftchapfont}{\sffamily\heiti}  % 章条目字体
\renewcommand{\cftchapdotsep}{\cftdotsep}
\renewcommand\cftchapleader{\cftdotfill{\cftchapdotsep}}
\renewcommand{\cftsecdotsep}{\cftdotsep}

%---------- 设置新的生成目录命令 ----------
\newcommand{\maketoc}{  % 生成目录, 并加入 PDF 书签和目录条目
    \clearpage
    \pagestyle{main}
    \phantomsection
    \addcontentsline{toc}{chapter}{\contentsname}
    \tableofcontents
    \clearpage
}

%---------- 设置插图清单和表格清单格式 ----------
% 条目格式: {编号}{标题}{引导点}{页码}
\titlecontents{figure}[0pt]{}{
\figureautorefname\hspace*{0.3em}\thecontentslabel\quad}{}{
\titlerule*[8pt]{$\cdot$}\contentspage}
\titlecontents{table}[0pt]{}{
\tableautorefname\hspace*{0.3em}\thecontentslabel\quad}{}{
\titlerule*[8pt]{$\cdot$}\contentspage}

%---------- 定义插图清单命令 ----------
\newcommand\makelof{
    \clearpage
    \phantomsection
    \addcontentsline{toc}{chapter}{\listfigurename}
    \chapter*{\listfigurename}
    \chaptermark{\listfigurename}
    \@starttoc{lof}
    \clearpage
}

%---------- 定义表格清单命令 ----------
\newcommand\makelot{
    \clearpage
    \phantomsection
    \addcontentsline{toc}{chapter}{\listtablename}
    \chapter*{\listtablename}
    \chaptermark{\listtablename}
    \@starttoc{lot}
    \clearpage
}

%---------- 定义主要符号表环境 (自动加入目录) ----------
\newenvironment{denotation}{
    \clearpage
    \phantomsection
    \addcontentsline{toc}{chapter}{主要符号表}
    \chapter*{主要符号表}
    \chaptermark{主要符号表}
}{
    \clearpage
    \if@openright
        \cleardoublepage
    \fi
}

%---------- 重新定义附录命令 ----------
% \let \oldappendix \appendix
% \renewcommand{\appendix}[1]{
%     \clearpage
%     \renewcommand{\theequation}{\Alph{chapter}\arabic{equation}}
%     \renewcommand{\thefigure}{\Alph{chapter}\arabic{figure}}
%     \renewcommand{\thetable}{\Alph{chapter}\arabic{table}}
%     \oldappendix{#1}
% }

%---------- 重新定义参考文献页 ----------
\renewcommand{\bibname}{参考文献}  % 参考文献标题名称
%--- 设置新的参考文献命令 (自动加入目录) ---
\let \oldbibliography \bibliography
\renewcommand{\bibliography}[1]{
    \clearpage
    \phantomsection
    \addcontentsline{toc}{chapter}{\bibname}
    \oldbibliography{#1}
}

% End of file `zhbook.cls'.
