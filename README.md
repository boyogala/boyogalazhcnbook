# boyogalazhcnbook

**中文书籍 LaTeX 模板**（基于 ctexbook 文类，使用 XeLaTeX 编译）.

## 微信公众号：博優旮旯-BOYOGALA

本项目的作者有同名公众号，欢迎扫码关注作者的微信公众号：

<p align="center"><img src="docs/images/qr-boyogala.png" width="42%"></p>

一起走进优化求解器与数值计算的科普分享.

---

本项目是一个开箱即用的中文书籍 LaTeX 模板：面向正式出版物的完整结构（封面、前言、目录、插图/表格清单、主要符号表、章节、附录、参考文献、索引、后记），自带全套字体与符合 GB/T 7714—2025 的参考文献样式，获取后无需安装任何字体、无需联网即可用 XeLaTeX 直接编译成书；示例书本身即使用教程。

## 目录

- [特性](#特性)
- [快速开始](#快速开始)
- [封面信息](#封面信息)
- [类选项](#类选项)
- [字体](#字体)
- [编译方法](#编译方法)
- [参考文献](#参考文献)
- [写作与组织](#写作与组织)
- [排版细节](#排版细节)
- [目录结构](#目录结构)
- [效果预览](#效果预览)
- [常见问题](#常见问题)
- [致谢](#致谢)
- [许可协议](#许可协议)

## 特性

- 书籍结构齐全：封面、前言、目录、插图清单、表格清单、主要符号表、章节、附录、参考文献、索引、后记；
- 示例即教程：示例书第 2 章演示常用环境（定理、算法、代码等）、第 4、5 章演示插图与表格排版，均可直接照用；
- 数学环境丰富：定理、引理、定义、例、推论、注、练习、假设、公理、性质、猜想等 12 种，附证明环境；数学工具齐全（amsmath、amsthm、mathtools、unicode-math）；
- 常用排版：算法与伪代码（algorithm、algpseudocode）、代码（listings，中文注释可正常排版）、子图与并排图（subcaption、minipage）、绘图与流程图（tikz）、多栏排版（multicol）、三线表（booktabs）、索引（imakeidx）；
- 参考文献符合国家标准 GB/T 7714—2025，顺序编码制与著者-出版年制均可（BibTeX，样式文件随附）；
- 中文排版细节：段首缩进 2 字（含列表项与引文内段落）、段间距与行距、章首页页码、页眉等；
- 设置分离：版式集中于 `boyogalazhcnbook.cls`，字体、宏包、参考文献等全局设置集中于 `boyogalazhcnbooksetting.tex`，便于按需调整；
- 可选类选项：`bindingoffset` 装订线、`print` 打印模式、`openright` 奇数页起章等；
- 基于 XeLaTeX + latexmk 一键编译；各章用 `\include` 组织，支持 `\includeonly` 只编译修改的章节；
- 自带字体方案：中文、西文、数学与代码字体全部取自仓库 `font/` 目录中的字体文件，自带完整中文字体命令，不依赖系统字体与第三方字体集，换电脑编译无需安装任何字体（详见[字体](#字体)一节）。

## 快速开始

**环境要求：** 安装 TeX Live（推荐 2023 或更新版本）或 MiKTeX，并且**必须使用 XeLaTeX 编译**。模板自带全部字体，无需在系统中安装任何字体，也无需联网。

上手只需三步：

1. 获取本仓库全部文件（`git clone` 或下载 ZIP 解压），保持目录结构完整——尤其不要遗漏 `font/` 目录；
2. 在 `main.tex` 顶部填写书名、作者等封面信息（见[封面信息](#封面信息)），在 `chapters/` 中撰写内容（见[写作与组织](#写作与组织)）；
3. 在项目根目录运行 `latexmk` 完成编译（见[编译方法](#编译方法)）。

推荐的文档类选项（`main.tex` 已按此设置）：

```tex
\documentclass[openany,twoside,zihao=-4]{boyogalazhcnbook}  % 本模板推荐的默认选项
```

文件分工：`boyogalazhcnbook.cls` 为文类（版式主体）；`boyogalazhcnbooksetting.tex` 为全局设置（字体、宏包、参考文献与索引）；`main.tex` 为主文件（封面信息与章节组织）；`chapters/` 存放各章源文件；`font/` 存放模板所用的全部字体；`reference.bib` 与两个 `gbt7714-2025-*.bst` 为参考文献库与样式文件。

## 封面信息

书名、副标题、作者等封面内容都在 `main.tex` 顶部设置：

| 命令 | 说明 |
| --- | --- |
| `\title{...}` | 书名（封面主标题，最大字号） |
| `\subtitle{...}` | 副标题（可选，不需要可删除） |
| `\author{...}` | 作者 |
| `\coverimage{...}` | 封面图片（可选，如 `figures/boyogala.png`） |
| `\motto{...}` | 封面座右铭（可选，可用 `\\` 分行） |
| `\date{...}` / `\version{...}` | 日期与版本（显示在封面下方） |
| `\bioinfo{键}{值}` | 作者的其他信息（可选，显示为「键：值」） |
| `\extrainfo{...}` | 封面底部附加信息，如出版社标志与名称（可选） |

封面采用现代三栏式布局：上层为书名与副标题，中层为作者与封面图片，下层为座右铭；同时设置 `\motto` 与 `\date` 时，封面优先显示座右铭（日期与版本不再出现）。点缀色与封面字体可分别在 `boyogalazhcnbook.cls`（`boyogalagreen`）与 `boyogalazhcnbooksetting.tex`（`cncover` 字族）中修改。

## 类选项

| 选项 | 取值 | 说明 |
| --- | --- | --- |
| `print` | — | 打印模式：封面、前言等处自动补空白页，并隐藏链接颜色 |
| `openany` / `openright` | — | 各章从任意页（默认）/ 奇数页开始 |
| `twoside` / `oneside` | — | 双面（默认）/ 单面排版 |
| `zihao` | `-4`、`5` 等 | 正文字号，默认小四号（`zihao=-4`） |
| `fontset` | — | 固定为 `none`：中文字体全部由 `boyogalazhcnbooksetting.tex` 指定，无需系统字体集 |
| `bindingoffset` | 长度，如 `1cm` | 装订线：双面打印时在页面内侧额外预留的宽度 |

- 装订线建议配合 `openright` 或 `print` 模式使用，此时前置页从奇数页开始，装订边与物理页一致；
- ctexbook 文类的其他选项（如 `heading`、`scheme` 等）均可直接传给本模板。

## 字体

### 字体清单与自足设计

模板的全部字体都直接从仓库 `font/` 目录读取字体文件（不依赖系统安装、不依赖第三方字体集、不联网），在任何电脑上的排版效果一致：

| 用途 | 字体（版本） | 字族 / 命令 | 许可 |
| --- | --- | --- | --- |
| 中文正文（宋体） | 思源宋体 Noto Serif CJK SC（2.003，含粗体，斜体为楷体） | `cnsong` / `\songti` | SIL OFL 1.1 |
| 中文标题（黑体） | 思源黑体 Source Han Sans CN（2.004，含粗体） | `cnhei` / `\heiti` | SIL OFL 1.1 |
| 中文斜体 / 引用（楷体） | 霞鹜文楷 LXGW WenKai（1.530） | `cnkai` / `\kaishu` | SIL OFL 1.1 |
| 中文等宽（仿宋） | 朱雀仿宋 Zhuque Fangsong（0.212，技术预览版） | `cnfs` / `\fangsong` | SIL OFL 1.1 |
| 封面 | 思源黑体（2.004，加粗） | `cncover` / `\coverfont` | SIL OFL 1.1 |
| 西文正文 | STIX Two Text（2.13） | 随正文自动 | SIL OFL 1.1 |
| 西文无衬线 | Source Sans 3（3.052） | 随 `\textsf` 自动 | SIL OFL 1.1 |
| 数学 | STIX Two Math（2.13；粗体数学用 XITS Math Bold 1.302） | 随数学环境自动 | SIL OFL 1.1 |
| 代码 / 命令行 | JetBrains Mono（2.304） | 随 `\texttt`、代码环境自动 | SIL OFL 1.1 |

表中字体全部为 SIL OFL 1.1 自由字体，可随模板公开分发；各字体的版权、版本与来源详见 [`font/README.md`](font/README.md)。

文类以 `fontset=none` 载入 ctexbook，不经过任何 ctex 字体集；上表中的字族与中文命令均由本模板**自行定义**，不依赖任何第三方字体设置。

### 中文命令与字体族

中文切换命令（全部指向 `font/` 中的字体文件）：

```tex
{\songti 宋体}  {\heiti 黑体}  {\kaishu 楷体}  {\fangsong 仿宋}  {\coverfont 封面字体}
```

- 正文默认宋体；`\textbf` 得到宋体粗体（NotoSerifCJKsc-Bold），`\emph` / `\textit` 得到楷体（与中文书籍惯例一致）；
- 黑体带粗体字形；楷体、仿宋仅有常规字重，加粗时保持常规显示；
- 仿宋（朱雀仿宋）为官方技术预览版，个别生僻字缺字时自动回退到思源宋体补齐（回退字体同样取自 `font/`，不依赖系统字体）；
- 字体族 `cnsong` / `cnhei` / `cnkai` / `cnfs` / `cncover` 也可直接使用，如 `{\CJKfamily{cnfs} 仿宋文字}`。

### 西文、数学与封面

- 西文：`\textrm`（STIX Two Text）、`\textsf`（Source Sans 3）、`\texttt`（JetBrains Mono）已与上表一一对应；
- 数学由 unicode-math 统一排版；`\boldsymbol` 等粗体数学使用 XITS Math Bold 补足（STIX Two 暂无粗体数学字形）。不需要粗体数学时，删去 `boyogalazhcnbooksetting.tex` 中的 `BoldFont = XITSMath-Bold.otf` 一项即可；
- 封面使用 `cncover`（思源黑体）与点缀色 `boyogalagreen`，更换方法见下文与「封面信息」一节。

### 更换或新增字体

所有字体设置集中在 `boyogalazhcnbooksetting.tex` 第一节「字体设置」，只需修改这一节：

1. 把新字体文件放入 `font/` 目录（也可另建子目录，并相应修改 `Path` 选项）；
2. 照已有条目的格式修改设置，或按下例新增字体族与命令：

```tex
\setCJKfamilyfont{cnlishu}{MyLishu-Regular.otf}[Path = font/]   % 新增字体族
\newcommand\lishu{\CJKfamily{cnlishu}}                          % 新增切换命令
```

3. 重新编译即可，无需在系统中安装该字体。

### 许可说明

模板所用字体均为自由字体（全部为 SIL OFL 1.1），可随模板自由分发与使用：中文为思源宋体、思源黑体、霞鹜文楷、朱雀仿宋；西文与代码为 Source Sans 3、STIX Two、XITS Math、JetBrains Mono。各字体的版权人、版本、来源与许可全文见 [`font/README.md`](font/README.md) 及 `font/` 中的 `OFL-*.txt` 许可文本。

## 编译方法

推荐使用 **latexmk**（TeX Live 与 MiKTeX 均自带）：

```bash
latexmk            # 自动完成 xelatex/bibtex/makeindex 及多遍编译
latexmk -pvc       # 持续编译, 源文件保存后自动重编
latexmk -c         # 清理中间文件
```

也可以直接运行附带的脚本：Linux/macOS 用 `./makefiles.sh`，Windows 用 `makefiles.bat`，
两者都支持 `clean`（清理中间文件）与 `cleanall`（连 main.pdf 一起清理）。

不使用 latexmk 时，手动编译顺序为：
`xelatex main.tex → bibtex main → xelatex main.tex → xelatex main.tex`。

**提示：** 索引由 `imakeidx` 在编译时自动调用 `makeindex` 生成（TeX Live 默认设置即可）；
如果编译环境完全禁用了 shell 执行（如 `-no-shell-escape`），需手动运行 `makeindex main.idx` 生成索引。

**提速技巧：**

- 修改某一章时可只编译该章：在导言区加入 `\includeonly{chapters/chap03}`（换成相应章节文件），
  latexmk 只重排该章，显著加快预览；第一次使用前需完整编译一次，定稿前注释掉该行再完整编译一次即可。
- 正文各章使用 `\include` 组织（`chapters/chap01.tex` … `chapters/chap05.tex`、`chapters/appendix.tex`），
  上述增量编译即依赖于此。
- latexmk 会自动用 `xelatex -no-pdf` 完成中间各遍、最后用 `xdvipdfmx` 输出 PDF，多遍编译更快（无需设置）。
- 不需要编辑器的正反向定位时可加 `-synctex=0`：`latexmk -synctex=0`。

## 参考文献

- 文献条目写在 `reference.bib` 中（标准 BibTeX 格式），正文用 `\cite{键名}` 引用；`\nocite{*}` 可临时列出全部文献；
- 默认样式 `gbt7714-2025-numeric` 为顺序编码制，引用格式可选 `numbers`（方括号数字）或 `super`（上标）；
- 也可以切换为 `gbt7714-2025-authoryear`（著者-出版年制，配合引用格式 `authoryear`）；两种著录规则均符合国家标准 GB/T 7714—2025《信息与文献 参考文献著录规则》；
- 样式与引用格式的切换方法见 `boyogalazhcnbooksetting.tex` 第三节「参考文献 / 引用 / 索引」中相应注释；
- 样式文件 `gbt7714-2025-numeric.bst`、`gbt7714-2025-authoryear.bst` 来自 Zeping Lee 的 [gbt7714-bibtex-style](https://github.com/zepinglee/gbt7714-bibtex-style) 项目（LPPL 1.3c+，版权归原作者）；
- 也可以不用 BibTeX：注释掉 `main.tex` 中的 `\bibliography{reference}`，改用 `\input{chapters/bibliography}` 以 `thebibliography` 环境手工排版文献。

## 写作与组织

常用写作任务一览；示例书相应章节均附有可直接照用的完整示例：

| 任务 | 做法 |
| --- | --- |
| 撰写章节 | 在 `chapters/` 新建 `chap06.tex`（以 `\chapter{...}` 开头），并在 `main.tex` 对应位置加一行 `\include{chapters/chap06}`（只编译该章的方法见[编译方法](#编译方法)） |
| 前言 / 后记 | 编辑 `chapters/preface.tex`、`chapters/epilogue.tex` |
| 附录 | 编辑 `chapters/appendix.tex`，每篇附录一个 `\chapter{...}`，自动编为附录 A、B… |
| 主要符号表 | 编辑 `chapters/denotation.tex`（符号、描述、单位三列）；不需要时在 `main.tex` 中注释对应 `\input` 行 |
| 定理等数学环境 | 定理、引理、定义、例、推论、注、练习、假设、公理、性质、猜想 12 种环境与 `proof` 证明环境，示例见第 2 章 |
| 插图 | `\includegraphics` 配合 `figure` 环境；并排子图用 `subcaption`，示例见第 4 章 |
| 表格 | 三线表（`booktabs`）、自适应宽表（`tabularx`）、跨页长表（`longtable`）、合并单元格（`multirow`、`makecell`），示例见第 5 章 |
| 算法与伪代码 | `algorithm` + `algpseudocode` 环境，示例见第 2 章 |
| 代码清单 | `lstlisting` 环境（已配置行号、边框、配色，支持中文注释），示例见第 2 章 |
| 绘图 | 直接用 `tikzpicture`（已载入 positioning、arrows.meta、shapes.geometric、calc 库），示例见第 2 章 |
| 引用文献 | 在 `reference.bib` 添加条目，正文 `\cite{键名}`（详见[参考文献](#参考文献)） |
| 索引 | 正文写 `\index{条目}`，编译时自动生成索引 |

## 排版细节

- 段落策略：每个自然段（包括节标题后的首段、列表项内与引文环境内新起的段落）首行缩进 2 个汉字
  （按 `\ccwd` 计算，随字号自动变化）；段间距约 4pt，行距 1.35 倍。
- 图题、表题居中排版（多行同样居中）；章首页页码居中置于页脚。
- 列表项之间不留额外间距；代码块带行号、单线边框与配色（关键字蓝、注释绿、字符串红），
  中文注释可正常排版。
- 脚注采用中文惯例：注文第一行随注码顶格，转行顶格。

## 目录结构

```text
boyogalazhcnbook.cls          文类文件 (版式主体)
boyogalazhcnbooksetting.tex   全局设置 (字体、宏包、参考文献与索引)
main.tex                      主文件 (书籍信息与章节组织)
chapters/                     各章节源文件
├── preface.tex               前言
├── chap01.tex … chap05.tex   第 1–5 章 (示例内容即使用教程)
├── appendix.tex              附录 A、B
├── denotation.tex            主要符号表
├── bibliography.tex          手工排参考文献的备用示例 (与 BibTeX 方式二选一)
└── epilogue.tex              后记
reference.bib                 参考文献库
gbt7714-2025-numeric.bst      GB/T 7714—2025 顺序编码制样式
gbt7714-2025-authoryear.bst   GB/T 7714—2025 著者-出版年制样式
font/                         模板全部字体 (20 个字体文件 + 许可文本)
figures/                      示例插图
docs/images/                  README 预览图
makefiles.sh / makefiles.bat  编译/清理脚本
.latexmkrc                    latexmk 配置
LICENSE                       许可协议 (MIT)
whatwedid.md                  项目处理与交接说明
```

## 效果预览

<table>
<tr>
<td><img src="docs/images/cover.png" width="100%"></td>
<td><img src="docs/images/toc.png" width="100%"></td>
</tr>
<tr>
<td><img src="docs/images/math.png" width="100%"></td>
<td><img src="docs/images/listings.png" width="100%"></td>
</tr>
<tr>
<td><img src="docs/images/figure.png" width="100%"></td>
<td><img src="docs/images/bibliography.png" width="100%"></td>
</tr>
</table>

## 常见问题

**编译时报找不到字体？**
模板的全部字体都在 `font/` 目录中，无需在系统里安装字体；请确认 `font/` 目录完整、并与
`main.tex` 位于同一目录（单独分发/下载时容易遗漏）。若自行改过 `boyogalazhcnbooksetting.tex` 中的
字体文件名，请对照 `font/` 下的实际文件核对。

**索引是空的？**
索引由 `imakeidx` 在编译时自动调用 `makeindex`（需要允许 shell 执行，TeX Live 默认允许）；
若编译时禁用了 shell 执行，请手动运行 `makeindex main.idx` 后重新编译。

**要打印装订成书？**
使用 `print` 模式并设置装订线，例如：
`\documentclass[print,openright,zihao=-4,bindingoffset=1cm]{boyogalazhcnbook}`。

**可以使用自己电脑里已安装的字体吗？**
可以。把 `boyogalazhcnbooksetting.tex` 中相应字体的 `Path = font/` 改为按字体名加载（或写入系统中文字体名、去掉 `Path` 与文件名）即可。不过为保证在任何电脑上编译效果一致，推荐把字体文件放入 `font/` 目录随项目分发；更换字体（尤其商业字体）时，请自行确认其许可是否允许分发。

**模板为什么自带约 102 MB 字体文件？**
为保证零配置、跨平台一致的排版效果，模板携带了全部所需字体与许可文本；字体只需随项目分发一次，编译时直接从 `font/` 读取，无需安装、无需联网。

## 致谢

本模板最初基于 Liutao Tian 的 [zhbook](https://github.com/andy123t/zhbook) 项目开发。在此基础上，
本项目经过系统性的重构与完善——自带全套字体（无需安装）、GB/T 7714—2025 参考文献样式、
更丰富的数学/绘图/多栏排版支持、更细致的排版处理——已发展成为独立的中文书籍模板体系。
谨向原始项目及其作者致以诚挚的谢意。

项目处理过程、设计说明与验证方法详见 [whatwedid.md](whatwedid.md)。

## 许可协议

- **模板代码**：MIT 许可，详情见 [LICENSE](LICENSE)。本项目由 Liutao Tian 的 [zhbook](https://github.com/andy123t/zhbook) 发展而来，`LICENSE` 中保留原项目版权声明；
- **字体**：全部为自由字体（SIL OFL 1.1），可随模板公开分发与使用——
  - 中文：思源宋体、思源黑体、霞鹜文楷、朱雀仿宋；
  - 西文与代码：Source Sans 3、STIX Two、XITS Math、JetBrains Mono；
  - 各字体的版权人、来源与许可文本见 [`font/README.md`](font/README.md) 与 `font/` 中的 `OFL-*.txt`；
- **参考文献样式**：`gbt7714-2025-*.bst` 版权归原作者 Zeping Lee（LPPL 1.3c+），声明见文件头部，本项目未做修改；
- 使用本模板排版的书稿，其版权完全归作者所有，不受上述任何许可约束。
