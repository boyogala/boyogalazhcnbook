# font/ —— zhbook 模板字体目录

zhbook 模板的全部字体都从本目录**直接读取字体文件**（见 `zhbooksetting.tex` 第一节「字体设置」），
编译时不依赖系统安装的字体，任何电脑上的排版效果一致。

## 子目录一览

| 目录 | 内容 | 模板编译用途 |
| --- | --- | --- |
| `fandolfonts/` | Fandol 中文宋体/黑体/楷体/仿宋（8 个 otf） | **必需**：正文宋体、标题黑体、楷体、仿宋 |
| `enfonts/` | STIX Two Text 四体（ttf） | **必需**：西文正文 |
| `math/` | STIX Two Math（常规）+ XITS Math Bold（粗体） | **必需**：数学公式 |
| `englishfonts/` | JetBrains Mono（32 个 ttf）、思源黑体/思源宋体（CN/SC，21 个 otf）、Times New Roman（4 个 ttf） | 部分必需：思源黑体常规/粗、JetBrains Mono 常规/粗/斜/粗斜 |
| `mathfonts/` | 数学字体资料库（26 个字族，网页字体包，多为 woff2） | 不需要（字体选型资料；`math/`、`enfonts/` 即由其转换而来） |

## 模板实际使用的字体文件（共 18 个）

对照 `zhbooksetting.tex`：

- 中文（`fandolfonts/`）：`FandolSong-Regular/Bold.otf`、`FandolHei-Regular/Bold.otf`、
  `FandolKai-Regular.otf`、`FandolFang-Regular.otf`
- 西文正文（`enfonts/`）：`STIXTwoText-Regular/Bold/Italic/BoldItalic.ttf`
- 数学（`math/`）：`STIXTwoMath-Regular.ttf`（常规）+ `XITSMath-Bold.otf`（粗体数学）
- 西文无衬线（`englishfonts/`）：`SourceHanSansCN-Regular/Bold.otf`
- 等宽与代码（`englishfonts/`）：`JetBrainsMono-Regular/Bold/Italic/BoldItalic.ttf`

## 来源与许可

| 字体 | 版本 / 来源 | 许可 |
| --- | --- | --- |
| Fandol | CTeX 项目（与 TeX Live 自带版本相同） | GPL v3 |
| STIX Two Text / STIX Two Math | v2.13 | SIL OFL 1.1 |
| XITS Math | v1.302 | SIL OFL 1.1 |
| 思源黑体 / 思源宋体 | Adobe Source Han Sans / Serif | SIL OFL 1.1 |
| JetBrains Mono | JetBrains | SIL OFL 1.1 |

- `enfonts/`、`math/` 中的字体由 `mathfonts/STIXTwo`、`mathfonts/XITS` 的 woff2 网页字体包
  经 [woff2](https://github.com/google/woff2) 的 `woff2_decompress` **无损转换**得到；
- STIX Two Math 无粗体数学字形，粗体数学（`\boldsymbol`）借用同源的 XITS Math Bold；
- 许可原文：`math/OFL-STIXTwo.txt`、`math/OFL-XITS.txt`、`enfonts/OFL-STIXTwo.txt`、
  `fandolfonts/COPYING`（GPL v3）、`englishfonts/OFL-SourceHanSans.txt`、`englishfonts/OFL-JetBrainsMono.txt`。

## 公开分发注意

- 模板实际用到的字体（Fandol、STIX Two、XITS、思源、JetBrains Mono）均为自由字体，
  可随模板公开分发（Fandol 为 GPL，分发时建议附上其许可说明）；
- `englishfonts/TimesNewRoman*.ttf` 为商业字体，仅作本地备用，**请勿公开分发**；
- 若只需保证模板能编译，保留「模板实际使用的字体文件」一节的 18 个文件即可，
  其余为选型资料与备用字重。
