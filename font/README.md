# font/ —— boyogalazhcnbook 模板字体目录

boyogalazhcnbook 模板的全部字体都从本目录**直接读取字体文件**（见 `boyogalazhcnbooksetting.tex` 第一节「字体设置」），
编译时不依赖系统安装的字体，任何电脑上的排版效果一致。
本目录仅存放模板所需的字体文件与许可文件；更换字体时把新文件放入本目录并修改
`boyogalazhcnbooksetting.tex` 即可。

## 文件清单（18 个字体文件）

| 文件 | 用途 | 字族 / 命令 |
| --- | --- | --- |
| `FandolSong-Regular.otf`、`FandolSong-Bold.otf` | 中文正文：宋体（常规 / 粗体） | `cnsong` / `\songti` |
| `FandolHei-Regular.otf`、`FandolHei-Bold.otf` | 中文标题：黑体（常规 / 粗体） | `cnhei` / `\heiti` |
| `FandolKai-Regular.otf` | 中文斜体 / 引用：楷体 | `cnkai` / `\kaishu` |
| `FandolFang-Regular.otf` | 中文等宽：仿宋 | `cnfs` / `\fangsong` |
| `SourceHanSansCN-Regular.otf`、`SourceHanSansCN-Bold.otf` | 封面 / 西文无衬线：思源黑体 | `cncover` / `\coverfont` |
| `STIXTwoText-{Regular,Bold,Italic,BoldItalic}.ttf` | 西文正文：衬线体 | 随正文自动 |
| `STIXTwoMath-Regular.ttf` | 数学公式（常规） | 随数学环境自动 |
| `XITSMath-Bold.otf` | 数学公式（粗体，供 `\boldsymbol` 等） | 随数学环境自动 |
| `JetBrainsMono-{Regular,Bold,Italic,BoldItalic}.ttf` | 代码与等宽 | 随 `\texttt` / 代码环境自动 |

## 版权与许可

| 字体 | 版权人（字体内嵌声明） | 版本 | 许可 |
| --- | --- | --- | --- |
| Fandol（宋 / 黑 / 楷 / 仿） | Copyright © 2012–2013, the Fandol team（设计：Clerk Ma、Jie Su） | 1.300 | GPL v3 + 字体嵌入例外 |
| STIX Two Text / STIX Two Math | Copyright 2001–2021 The STIX Fonts Project Authors | 2.13 | SIL OFL 1.1 |
| XITS Math | STI Pub 等（含 MicroPress、Elsevier、(URW)++、Khaled Hosny 等，详见许可文本） | 1.302 | SIL OFL 1.1 |
| 思源黑体 Source Han Sans CN | © 2014–2021 Adobe, with Reserved Font Name 'Source' | 2.004 | SIL OFL 1.1 |
| JetBrains Mono | Copyright 2020 The JetBrains Mono Project Authors | 2.304 | SIL OFL 1.1 |

- 许可全文随附于本目录：`GPLv3-Fandol.txt`（GPL v3 全文）、`OFL-*.txt`（四份 SIL OFL 1.1 全文，与各字体官方发布一致）；
- **Fandol** 按上游说明发布（TeX Live 的 fandol 包 README 原文：“These fonts's licensing is GPL + GPL font exception.”）：
  字体本身为 GPL v3，**附加字体嵌入例外**——在文档中正常使用并嵌入这些字体，不会使文档受 GPL 约束；
- `font/` 中的 Fandol 字体文件与上游（TeX Live / CTAN）逐字节一致，本项目未作任何修改；
- 其余字体为 SIL OFL 1.1：可自由使用、研究、修改与再分发（须保留版权与许可声明；分发修改版本时不得使用其保留字体名）；
- 用本模板排版的文档不受字体许可限制：正文字稿与 PDF 输出归作者所有。

## 来源

| 字体 | 来源 |
| --- | --- |
| Fandol | CTAN `fandol` 包 / TeX Live（<https://ctan.org/pkg/fandol>） |
| STIX Two Text / STIX Two Math | v2.13，STIX Fonts 项目（<https://github.com/stipub/stixfonts>；自 woff2 网页字体包无损转换） |
| XITS Math | v1.302，XITS 项目（自 woff2 网页字体包无损转换） |
| 思源黑体 Source Han Sans CN | Adobe（<https://github.com/adobe-fonts/source-han-sans>） |
| JetBrains Mono | JetBrains（<https://github.com/JetBrains/JetBrainsMono>） |

- STIX Two Math 无粗体数学字形，粗体数学（`\boldsymbol`）借用同源的 XITS Math Bold；
- woff2 → ttf/otf 采用 [woff2](https://github.com/google/woff2) 的 `woff2_decompress` 无损转换（字形与名称未改动）。

全部字体均为自由字体，可随模板公开分发。
