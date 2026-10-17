# font/ —— boyogalazhcnbook 模板字体目录

boyogalazhcnbook 模板的全部字体都从本目录**直接读取字体文件**（见 `boyogalazhcnbooksetting.tex` 第一节「字体设置」），
编译时不依赖系统安装的字体，任何电脑上的排版效果一致。
本目录仅存放模板所需的字体文件与许可文件；更换字体时把新文件放入本目录并修改
`boyogalazhcnbooksetting.tex` 即可。

## 文件清单（18 个字体文件）

| 文件 | 用途 | 许可 |
| --- | --- | --- |
| `FandolSong-Regular.otf`、`FandolSong-Bold.otf` | 中文正文：宋体（常规 / 粗体） | GPL v3 |
| `FandolHei-Regular.otf`、`FandolHei-Bold.otf` | 中文标题：黑体（常规 / 粗体） | GPL v3 |
| `FandolKai-Regular.otf` | 中文斜体 / 引用：楷体 | GPL v3 |
| `FandolFang-Regular.otf` | 中文等宽：仿宋 | GPL v3 |
| `STIXTwoText-{Regular,Bold,Italic,BoldItalic}.ttf` | 西文正文：衬线体 | SIL OFL 1.1 |
| `STIXTwoMath-Regular.ttf` | 数学公式（常规） | SIL OFL 1.1 |
| `XITSMath-Bold.otf` | 数学公式（粗体，供 `\boldsymbol` 等） | SIL OFL 1.1 |
| `SourceHanSansCN-Regular.otf`、`SourceHanSansCN-Bold.otf` | 西文无衬线（拉丁部分为 Source Sans） | SIL OFL 1.1 |
| `JetBrainsMono-{Regular,Bold,Italic,BoldItalic}.ttf` | 代码与等宽 | SIL OFL 1.1 |

## 来源

| 字体 | 版本 / 来源 |
| --- | --- |
| Fandol | CTeX 项目（与 TeX Live 自带版本相同） |
| STIX Two Text / STIX Two Math | v2.13（STI Pub；自官方 woff2 网页字体包无损转换） |
| XITS Math | v1.302（自 woff2 网页字体包无损转换） |
| 思源黑体 Source Han Sans CN | Adobe |
| JetBrains Mono | JetBrains |

- STIX Two Math 无粗体数学字形，粗体数学（`\boldsymbol`）借用同源的 XITS Math Bold；
- woff2 → ttf/otf 采用 [woff2](https://github.com/google/woff2) 的 `woff2_decompress` 无损转换。

## 许可文件

`OFL-STIXTwo.txt`、`OFL-XITS.txt`、`OFL-SourceHanSans.txt`、`OFL-JetBrainsMono.txt`（SIL OFL 1.1）、
`GPLv3-Fandol.txt`（GPL v3）。

全部字体均为自由字体，可随模板公开分发。
