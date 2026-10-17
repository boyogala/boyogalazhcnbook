# font/ —— boyogalazhcnbook 模板字体目录

boyogalazhcnbook 模板的全部字体都从本目录**直接读取字体文件**（见 `boyogalazhcnbooksetting.tex` 第一节「字体设置」），
编译时不依赖系统安装的字体，任何电脑上的排版效果一致。
本目录仅存放模板所需的字体文件与许可文件；更换字体时把新文件放入本目录并修改
`boyogalazhcnbooksetting.tex` 即可。

## 文件清单（20 个字体文件）

| 文件 | 用途 | 字族 / 命令 |
| --- | --- | --- |
| `NotoSerifCJKsc-Regular.otf`、`NotoSerifCJKsc-Bold.otf` | 中文正文：宋体（思源宋体，常规 / 粗体） | `cnsong` / `\songti` |
| `LXGWWenKai-Regular.ttf` | 中文斜体 / 引用：楷体（霞鹜文楷） | `cnkai` / `\kaishu` |
| `SourceHanSansCN-Regular.otf`、`SourceHanSansCN-Bold.otf` | 中文标题：黑体（思源黑体，常规 / 粗体）；兼封面字体 | `cnhei` / `\heiti`、`cncover` / `\coverfont` |
| `ZhuqueFangsong-Regular.ttf` | 中文等宽：仿宋（朱雀仿宋，技术预览版） | `cnfs` / `\fangsong` |
| `SourceSans3-{Regular,Bold,It,BoldIt}.otf` | 西文无衬线 | 随 `\textsf` 自动 |
| `STIXTwoText-{Regular,Bold,Italic,BoldItalic}.ttf` | 西文正文：衬线体 | 随正文自动 |
| `STIXTwoMath-Regular.ttf` | 数学公式（常规） | 随数学环境自动 |
| `XITSMath-Bold.otf` | 数学公式（粗体，供 `\boldsymbol` 等） | 随数学环境自动 |
| `JetBrainsMono-{Regular,Bold,Italic,BoldItalic}.ttf` | 代码与等宽 | 随 `\texttt` / 代码环境自动 |

- 中文斜体映射：正文的 `\emph` / `\textit` 自动使用楷体（霞鹜文楷），与中文书籍以楷体代斜体的惯例一致；
- 朱雀仿宋为官方「技术预览版」（v0.212，13,805 字形），备字量少于正式字库，模板已配置
  **缺字自动回退到思源宋体**（回退字体同样取自本目录，仍不依赖系统字体）；待官方发布
  正式版后，把本目录中的同名文件替换为新版即可（无需修改设置）。

## 版权与许可

| 字体 | 版权人（字体内嵌声明） | 版本 | 许可 |
| --- | --- | --- | --- |
| 思源宋体 Noto Serif CJK SC | © 2017–2024 Adobe (http://www.adobe.com/)（Noto 为 Google 商标） | 2.003 | SIL OFL 1.1 |
| 思源黑体 Source Han Sans CN | © 2014–2021 Adobe, with Reserved Font Name 'Source' | 2.004 | SIL OFL 1.1 |
| 霞鹜文楷 LXGW WenKai | Copyright 2021–2026 LXGW, with Reserved Font Name '霞鹜' 等（另含 Klee Project 字体版权，见许可全文） | 1.530 | SIL OFL 1.1 |
| 朱雀仿宋 Zhuque Fangsong | Copyright 2023, Zhejiang JadeFoci Technology Co. LTD (https://www.jadefoci.com/) | 0.212 | SIL OFL 1.1 |
| Source Sans 3 | © 2023 Adobe, with Reserved Font Name 'Source' | 3.052 | SIL OFL 1.1 |
| STIX Two Text / STIX Two Math | Copyright 2001–2021 The STIX Fonts Project Authors | 2.13 | SIL OFL 1.1 |
| XITS Math | STI Pub 等（含 MicroPress、Elsevier、(URW)++、Khaled Hosny 等，详见许可文本） | 1.302 | SIL OFL 1.1 |
| JetBrains Mono | Copyright 2020 The JetBrains Mono Project Authors | 2.304 | SIL OFL 1.1 |

- 许可全文随附于本目录：`OFL-*.txt`（八份 SIL OFL 1.1 全文，覆盖本目录全部字体）；
- 本目录中的字体文件与上游发布逐字节一致，本项目未作任何修改；
- SIL OFL 1.1 允许自由使用、研究、修改与再分发（须保留版权与许可声明；分发修改版本时不得使用其保留字体名）；
- 用本模板排版的文档不受字体许可限制：书稿与 PDF 输出归作者所有。

## 来源

| 字体 | 来源 |
| --- | --- |
| 思源宋体 | v2.003，Noto CJK 官方发布（<https://github.com/notofonts/noto-cjk>；与 Adobe 思源宋体 Source Han Serif 同源同版） |
| 思源黑体 | v2.004，Adobe 官方发布（<https://github.com/adobe-fonts/source-han-sans>） |
| 霞鹜文楷 | v1.530，官方发布（<https://github.com/lxgw/LxgwWenKai>） |
| 朱雀仿宋 | v0.212（技术预览），官方发布（<https://github.com/TrionesType/zhuque>） |
| Source Sans 3 | v3.052，Adobe 官方发布（<https://github.com/adobe-fonts/source-sans>） |
| STIX Two Text / STIX Two Math | v2.13，STIX Fonts 项目（<https://github.com/stipub/stixfonts>；自 woff2 网页字体包无损转换） |
| XITS Math | v1.302，XITS 项目（自 woff2 网页字体包无损转换） |
| JetBrains Mono | JetBrains（<https://github.com/JetBrains/JetBrainsMono>） |

- STIX Two Math 无粗体数学字形，粗体数学（`\boldsymbol`）借用同源的 XITS Math Bold；
- woff2 → ttf/otf 采用 [woff2](https://github.com/google/woff2) 的 `woff2_decompress` 无损转换（字形与名称未改动）。

全部字体均为自由字体（全部 SIL OFL 1.1），可随模板公开分发。
