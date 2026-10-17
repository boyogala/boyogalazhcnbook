%%
%% boyogalazhcnbook.cls —— 中文书籍 LaTeX 文类
%% 由 Liutao Tian 的 zhbook 项目 (MIT 许可, https://github.com/andy123t/zhbook) 重构发展而来;
%% 版权 (c) 2022 Liutao Tian, (c) 2026 boyogala (博优旮旯); 许可与声明见根目录 LICENSE.
%% 联系: boyogala@qq.com
%%

%---------- 定义的新的Class ----------
\ProvidesClass{boyogalazhcnbook}[2026/10/17 v1.2]
\NeedsTeXFormat{LaTeX2e}

%---------- 定义的新的Options ----------
\RequirePackage{etoolbox}  % 补丁工具 (提前载入: 下面解析类选项需要其中的 \ifdefstring 等命令)

\newif\ifprint
\DeclareOption{print}{\printtrue}                                    % 打印模式: 封面等处生成空白页并隐藏链接颜色
\DeclareOption{openany}{\PassOptionsToClass{openany}{ctexbook}}      % 每章从任意页开始
\DeclareOption{openright}{\PassOptionsToClass{openright}{ctexbook}}  % 每章从奇数页开始
\DeclareOption{twoside}{\PassOptionsToClass{twoside}{ctexbook}}      % 双面排版

%--- 自定义"键=值"类选项 (未匹配的选项原样透传给 ctexbook) ---
%    bindingoffset=1cm   装订线宽度 (默认: 0pt, 不预留)
% 说明: 模板字体 (含数学字体) 全部取自项目自带 font/ 目录, 由 boyogalazhcnbooksetting.tex
%       统一配置, 不提供也不依赖任何第三方字体选项.
\def\boyogalazhcnbook@bindingoffset{0pt}  % 装订线宽度
\DeclareOption*{%
    % 在选项后追加哨兵"==", 按第一个"="拆分 (无"="的选项也能安全解析):
    % 匹配到自定义选项则记录, 其余选项原样透传给 ctexbook
    \expandafter\boyogalazhcnbook@parsekv\CurrentOption==\@nil
}
% 拆分"键=值": #1=键, #2="值==" (末尾多两个哨兵"=", 再用 \boyogalazhcnbook@stripval 去掉)
\def\boyogalazhcnbook@parsekv#1=#2\@nil{%
    \def\boyogalazhcnbook@tempkey{#1}%
    \boyogalazhcnbook@stripval#2\@nil
    \ifdefstring{\boyogalazhcnbook@tempkey}{bindingoffset}{%
        \let\boyogalazhcnbook@bindingoffset\boyogalazhcnbook@tempval
    }{%
        \PassOptionsToClass{\CurrentOption}{ctexbook}% 其他选项透传
    }%
}
% 去掉值末尾的哨兵"==" (无值选项的 #2 恰为"==", 去掉后为空)
\def\boyogalazhcnbook@stripval#1==\@nil{\def\boyogalazhcnbook@tempval{#1}}
\ProcessOptions\relax

%---------- 字体宏包选项 ----------
% 必须在载入 ctexbook 之前设置: ctexbook 内部会经 xeCJK 载入 fontspec
\PassOptionsToPackage{no-math}{fontspec}

%---------- 静默无碍排版的信息性警告 ----------
% 1) 朱雀仿宋的字表未登记 OpenType 脚本 "CJK" (xeCJK 默认对所有中文字体请求该脚本,
%    fontspec 将其映射为 hani 并按 XeTeX 枚举的字体脚本表核对); fontspec 遂给出
%    "does not contain requested Script" 警告, 并自动回退为默认脚本, 不影响排版与字形
%    (其余中文字体均含该脚本, 不触发此警告).
% 2) mathtools 与 unicode-math 并用: unicode-math 载入后会给出两条提示 — 冒号类命令
%    (如 \coloneqq) 改用 unicode-math 版本, 上下花括号命令沿用 mathtools 版本 — 均为
%    宏包官方设计中的正常行为, 不影响排版.
% 以上警告按消息名静默, 使编译日志保持干净; 如需恢复提示, 将 none 改为 warning.
\RequirePackage{expl3}
\ExplSyntaxOn
\msg_redirect_name:nnn {fontspec} {no-script} {none}
\msg_redirect_name:nnn {unicode-math} {mathtools-overbracket} {none}
\msg_redirect_name:nnn {unicode-math} {mathtools-colon} {none}
\ExplSyntaxOff

%---------- 载入Class ----------
% fontset=none: 不使用 ctex 预置的字体集, 中文字体全部由 boyogalazhcnbooksetting.tex
% 指定 (取自本仓库 font/ 目录); 字体族名与之互不冲突, 编译日志无重定义警告
\LoadClass[UTF8,a4paper,fontset=none]{ctexbook}
\@ifclasslater{ctexbook}{2017/01/01}{}{%
    \ClassError{boyogalazhcnbook}{ctex >= 2017/01/01 is required ...}{}%
}

%---------- 定义页边距 ----------
\RequirePackage{geometry}
\geometry{left=3.0cm,right=3.0cm,top=3.0cm,bottom=2.8cm}  % 上下左右边距
\ifx\boyogalazhcnbook@bindingoffset\@empty\def\boyogalazhcnbook@bindingoffset{0pt}\fi  % 空值保护
\geometry{bindingoffset=\boyogalazhcnbook@bindingoffset}  % 装订线: 双面打印时在页面内侧额外预留 (默认 0pt)
%\geometry{centering,body={16cm,22cm}}                    % 备选: 固定版心尺寸
%\geometry{left=2.5cm,right=2.5cm,top=2.8cm,bottom=2.6cm} % 备选: 较窄的边距
\setlength{\headheight}{18pt}  % 页眉高度
\setlength{\headsep}{18pt}     % 页眉到正文的距离
\setlength{\footskip}{28pt}    % 正文到页码的距离
\setlength{\emergencystretch}{3em}  % 行溢出保护: 仅在个别行会超出边界时, 允许额外的行内拉伸

%---------- 常用宏包 ----------
\RequirePackage{amsmath,amsthm}  % 数学公式与定理
\RequirePackage{mathtools}       % amsmath 增强 (dcases、cases*、\coloneqq、\DeclarePairedDelimiter 等)
% 基础数学符号宏包; 正式数学字体由 boyogalazhcnbooksetting.tex 经 unicode-math
% 从项目自带 font/ 目录配置 (会接替此处符号宏包的字体设定)
\RequirePackage{amssymb}  % AMS 数学符号 (花体字母 \mathscr 由 unicode-math 的数学字体提供)
\RequirePackage{graphicx}                % 插图
\RequirePackage{tabularx}                % 宽度自适应的表格
\RequirePackage{booktabs}                % 三线表
\RequirePackage{float}                   % 浮动体 [H] 选项
\RequirePackage{longtable}               % 跨页长表格
\RequirePackage{multirow}                % 合并行
\RequirePackage{multicol}                % 多栏排版
\RequirePackage{makecell}                % 单元格内换行
\RequirePackage{xcolor}                  % 颜色
\RequirePackage{fancyhdr}                % 页眉页脚
\RequirePackage{titletoc}                % 目录条目格式
\RequirePackage{pdfpages}                % 插入外部 PDF

%---------- 定义文档属性格式 ----------
\global\let\@title\@empty                         % 书名(封面主标题)
\global\let\@author\@empty                        % 作者
\global\let\@date\@empty                          % 日期
\newcommand\subtitle{\gdef\@subtitle}             % 副标题
\newcommand\version{\gdef\@version}               % 版本
\newcommand\extrainfo{\gdef\@extrainfo}           % 封面底部附加信息
\newcommand\bioinfo[2]{\gdef\@bioinfo{{#1}：#2}}  % 作者的其他信息(键：值)
\newcommand\coverimage{\gdef\@coverimage}         % 封面图片 (可选)
\newcommand\motto{\gdef\@motto}                   % 封面座右铭 (可选, 支持 \\ 换行)
\providecommand\coverfont{\sffamily}              % 封面字体 (默认无衬线; 可在 boyogalazhcnbooksetting.tex 中改)

%---------- 空白页处理 ----------
% 主要分隔处换页: print/openright 模式必要时补空白页 (沿用标准 \cleardoublepage, 空白页
% 自动使用 empty 页样式, 无页眉页码), 其余模式仅换页
\newcommand{\boyogalazhcnbook@nextpage}{%
    \ifprint
        \cleardoublepage
    \else
        \if@openright
            \cleardoublepage
        \else
            \clearpage
        \fi
    \fi
}

%---------- 设置超链接 ----------
% hyperref 推迟到导言末尾载入: 保证它在 natbib 等宏包之后载入, 避免相互冲突
\AtEndPreamble{
    \RequirePackage{hyperref}
    \RequirePackage[numbered]{bookmark}  % PDF 书签(带编号), 须在 hyperref 之后载入
    \hypersetup{
        colorlinks=true,  % 用颜色标记链接(而非方框)
        linkcolor=black,  % 内部链接颜色
        citecolor=blue,   % 文献引用颜色
        filecolor=blue,   % 文件链接颜色
        urlcolor=blue     % 网址颜色
    }
    \ifprint
        \hypersetup{hidelinks}  % 打印模式: 隐藏链接颜色和方框
    \fi
    % 设置 \autoref 引用的中文前缀 (这些命令由 hyperref 定义)
    \renewcommand{\figureautorefname}{图}      % \autoref 引用图时的前缀
    \renewcommand{\tableautorefname}{表}       % \autoref 引用表时的前缀
    \renewcommand{\equationautorefname}{公式}  % \autoref 引用公式时的前缀
}

%---------- 设置正文前页码为小写罗马数字 ----------
\renewcommand\frontmatter{%
    \boyogalazhcnbook@nextpage  % print/openright 模式: 此处补空白页
    \@mainmatterfalse
    \pagenumbering{roman}%
}

%---------- 设置正文页码为阿拉伯数字 ----------
\renewcommand\mainmatter{%
    \boyogalazhcnbook@nextpage
    \pagenumbering{arabic}%
    \@mainmattertrue
}

%---------- 设置后附部分 (不参与章节编号) ----------
\renewcommand\backmatter{%
    \boyogalazhcnbook@nextpage
    \@mainmatterfalse
}

%---------- 设置图片的路径 ----------
\graphicspath{{./figures/}}  % 图片统一放在 figures/ 目录, 引用时可省略路径

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
\RequirePackage{algorithm,algpseudocode}  % 算法浮动体 + 伪代码排版 (algpseudocode 内含 algorithmicx 内核)
\floatname{algorithm}{算法}              % 算法标题名称
\algrenewcommand\algorithmicrequire{\textbf{输入:}}  % Require 显示为"输入"
\algrenewcommand\algorithmicensure{\textbf{输出:}}   % Ensure 显示为"输出"

%---------- 代码排版 (listings 宏包) ----------
% 注: 配合 ctex/xeCJK 使用时, 代码中的中文 (如注释) 可正常排版, 无需额外设置.
\RequirePackage{listings}
\lstset{
    basicstyle   = \ttfamily\zihao{5},      % 代码字体: 等宽, 5 号字
    keywordstyle = \color{blue!80!black},   % 关键字颜色
    commentstyle = \color{green!45!black},  % 注释颜色
    stringstyle  = \color{red!70!black},    % 字符串颜色
    numbers      = left,                    % 行号显示在左侧
    numberstyle  = \tiny\color{gray},       % 行号样式
    numbersep    = 8pt,                     % 行号与代码的距离
    frame        = single,                  % 单线边框
    rulecolor    = \color{gray!60},         % 边框颜色
    breaklines   = true,                    % 长行自动折行
    columns      = flexible,                % 字符间距弹性, 避免行溢出
    keepspaces   = true,                    % 保留空格
    tabsize      = 4,                       % Tab 宽度
    showstringspaces = false,               % 字符串中的空格不加特殊标记
    aboveskip    = 8pt,                     % 代码块与上方正文的间距
    belowskip    = 8pt,                     % 代码块与下方正文的间距
    %escapeinside = {(*@}{@*)},             % 备选: 代码中用 (*@...@*) 嵌入 LaTeX 命令
}

%---------- 定义页眉页脚 (fancyhdr 宏包) ----------

%---------- 设置页眉样式 ----------
\newcommand{\headstyle}{
    \fancyhead[RO,LE]{\fangsong\zihao{5} $\cdot$\:\thepage\:$\cdot$} % 奇数页右侧/偶数页左侧: 页码
    \fancyhead[LO,RE]{\fangsong\zihao{5} \nouppercase{\leftmark}}    % 奇数页左侧/偶数页右侧: 章标题
}

%---------- 设置页脚样式 ----------
\newcommand{\footstyle}{
    \fancyfoot[C]{\zihao{5} \thepage}
}

%---------- 重定义plain样式 (章首页: 不含页眉, 底部居中显示页码) ----------
\fancypagestyle{plain}{%
    \fancyhf{}
    \footstyle  % 章首页页码
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
% 段落策略: 每个自然段 (包括节标题后的首段) 首行缩进 2 个汉字宽, 段间加约 4pt 弹性间距, 行距 1.35 倍.
\setlength{\parindent}{2\ccwd}                % 段首缩进 2 个汉字 (\ccwd 随字号自动变化)
\setlength{\parskip}{4pt plus 1pt minus 1pt}  % 段落间距
\linespread{1.35}  % 行距 1.35 倍
%---------- 引文环境 (quote/quotation) ----------
% 在默认"两侧缩进"的基础上, 使内部每个自然段首行缩进 2 个汉字 (与正文段落体例一致):
% \itemindent 控制第一段首行, \listparindent 控制其后各段.
\renewenvironment{quote}{%
    \list{}{\rightmargin\leftmargin\listparindent=2\ccwd\itemindent\listparindent}%
    \item\relax
}{\endlist}
\renewenvironment{quotation}{%
    \list{}{\listparindent=2\ccwd\itemindent\listparindent\rightmargin\leftmargin\parsep\z@\@plus\p@}%
    \item\relax
}{\endlist}

%---------- 浮动对象设置 ----------
% 浮动对象的缺省值稍微宽松一点, 允许页面上放置更多的浮动体
\renewcommand{\textfraction}{0.15}       % 一页中最少的正文比例
\renewcommand{\topfraction}{0.85}        % 页顶浮动体占比上限
\renewcommand{\bottomfraction}{0.65}     % 页底浮动体占比上限
\renewcommand{\floatpagefraction}{0.60}  % 浮动页中浮动体的占比下限

%---------- 设置图表格式 ----------
\numberwithin{figure}{chapter}    % 图按章编号(如图 2.1)
\numberwithin{equation}{chapter}  % 公式按章编号(如式 2.1)

%--------- 定制图形和表格标题的样式 ----------
\RequirePackage{caption}
\captionsetup{font={small,singlespacing},labelformat={default},labelsep=quad,justification=centering}  % 标题小字号、单倍行距、居中 (中文书刊惯例)
\captionsetup[figure]{position=bottom,skip={6pt},name={图}}   % 图题在图的下方
\captionsetup[table]{position=top,skip={3pt},name={表}}       % 表题在表的上方
\setlength{\textfloatsep}{12pt plus 2pt minus 2pt}  % 页顶/页底浮动体与正文的距离
\setlength{\floatsep}{10pt plus 2pt minus 2pt}      % 相邻浮动体之间的距离
\setlength{\intextsep}{10pt plus 2pt minus 2pt}     % 文中浮动体与正文的距离

%---------- 使用tabularx库并定义新的左右中格式 ----------
\newcolumntype{L}{X}                                     % 宽度自适应, 左对齐
\newcolumntype{C}{>{\centering \arraybackslash}X}        % 宽度自适应, 居中
\newcolumntype{R}{>{\raggedleft \arraybackslash}X}       % 宽度自适应, 右对齐
\newcolumntype{P}[1]{>{\centering \arraybackslash}p{#1}} % 指定宽度且居中

%---------- 数学定理设置 ----------
% 定理样式: {上方间距}{下方间距}{正文格式}{正文缩进}{标题格式}{标题后标点}{标题与正文间距}{标题后内容}
\newtheoremstyle{boyogalazhcnbook}
{0.5\topsep}{0.5\topsep}
{\itshape}{}{\bfseries}
{.}{5pt plus 1pt minus 1pt}{}
\theoremstyle{boyogalazhcnbook}
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
% 证毕符号默认 □; boyogalazhcnbooksetting.tex 中已改为数学字体的 \mdlgwhtsquare
% (如要换成实心 ∎, 建议统一在 boyogalazhcnbooksetting.tex 中改为 \mdlgblksquare)
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
}

%---------- 定义列表项的样式 ----------
\RequirePackage{enumitem}  % 列表间距控制
\setlist{nolistsep}                  % 列表项之间不留额外间距
% 列表项内新起段落首行缩进 2 个汉字 (与正文一致); 仅限常规列表, 避免影响算法等 \list 环境
\setlist[itemize,enumerate,description]{listparindent=2\ccwd}

%---------- 定义新的标题页面 (封面) ----------
% 现代三栏式布局: 上层=书名/副标题, 中层=作者/封面图片, 下层=座右铭(设置后优先于日期版本), 页脚=附加信息
\definecolor{boyogalagreen}{HTML}{0B8C2F}  % 封面点缀色: 品牌绿 (可自行修改)
\renewcommand{\maketitle}{
    \clearpage
    \phantomsection
    \pdfbookmark[0]{封~~面}{cover}  % 在 PDF 书签中添加"封面"
    \begin{titlepage}
        \centering
        \setlength{\parskip}{0pt}    % 封面内清零段间距与首行缩进 (模板正文有, 封面不需要)
        \setlength{\parindent}{0pt}

        \vspace*{0.10\textheight}  % 顶部留白

        %===== 上层: 书名 / 副标题 =====
        {\sffamily\coverfont\bfseries\fontsize{32pt}{42pt}\selectfont \@title \par}
        \ifx\@subtitle\undefined\else
            \vspace*{0.9\baselineskip}
            {\sffamily\coverfont\fontsize{16pt}{21pt}\selectfont\color{boyogalagreen}%
             \@subtitle \par}
        \fi

        \vspace*{\fill}

        %===== 中层: 作者 / 封面图片 (图片在作者之下) =====
        {\sffamily\coverfont\fontsize{17pt}{23pt}\selectfont \@author \par}
        \ifx\@bioinfo\undefined\else
            \vspace*{0.4\baselineskip}
            {\kaishu\small\color{black!55} \@bioinfo \par}
        \fi
        \ifx\@coverimage\undefined\else
            \vspace*{0.9\baselineskip}
            {\includegraphics[width=0.34\textwidth]{\@coverimage}\par}
        \fi

        \vspace*{\fill}

        %===== 下层: 座右铭 (一行; 设置后日期与版本不再显示) =====
        \ifx\@motto\undefined
            \ifx\@date\@empty
                \ifx\@version\undefined\else
                    {\color{boyogalagreen}\rule{1.2cm}{1.6pt}\par}
                    \vspace*{1\baselineskip}
                    {\sffamily\coverfont\small\color{black!60} 版本 \@version \par}
                \fi
            \else
                {\color{boyogalagreen}\rule{1.2cm}{1.6pt}\par}
                \vspace*{1\baselineskip}
                {\sffamily\coverfont\small\color{black!60} \@date
                 \ifx\@version\undefined\else ~·~版本 \@version\fi \par}
            \fi
        \else
            {\color{boyogalagreen}\rule{1.2cm}{1.6pt}\par}
            \vspace*{1\baselineskip}
            {\kaishu\fontsize{13pt}{20pt}\selectfont \color{black!70} \@motto \par}
        \fi

        \vspace*{1.4cm}

        {\normalsize \ifx\@extrainfo\undefined{}\else \@extrainfo \fi} % 封面底部附加信息

        \vspace*{0.1\baselineskip}
    \end{titlepage}
    \boyogalazhcnbook@nextpage  % print/openright 模式: 封面后补空白页
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
    \boyogalazhcnbook@nextpage
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
    \boyogalazhcnbook@nextpage
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

% End of file `boyogalazhcnbook.cls'.
