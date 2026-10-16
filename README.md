# zhbook

**中文书籍 LaTeX 模板**（基于 ctexbook 文类，使用 XeLaTeX 编译）

<p align="center"><img src="docs/images/cover.png" width="42%"></p>

## 目录

- [特性](#特性)
- [快速开始](#快速开始)
- [类选项](#类选项)
- [编译方法](#编译方法)
- [参考文献](#参考文献)
- [排版细节](#排版细节)
- [目录结构](#目录结构)
- [效果预览](#效果预览)
- [常见问题](#常见问题)
- [许可协议](#许可协议)

## 特性

- 书籍结构齐全：封面、前言、目录、插图清单、表格清单、主要符号表、章节、附录、参考文献、索引、后记；
- 数学环境丰富：定理、引理、定义、例、推论、注、练习、假设、公理、性质、猜想等 12 种，附证明环境；
- 常用排版：算法（algorithm + algorithmic）、代码（listings，中文注释可正常排版）、子图与并排图（subcaption、minipage）、三线表（booktabs）、索引（imakeidx）；
- 参考文献符合国家标准 GB/T 7714—2025，顺序编码制与著者-出版年制均可（BibTeX，样式文件随附）；
- 中文排版细节：段首缩进 2 字（含列表项与引文内段落）、段间距与行距、章首页页码、页眉等；
- 可选类选项：`mathfont` 数学字体（lmodern/xits/termes/stix2/pagella）、`bindingoffset` 装订线、`print` 打印模式、`openright` 奇数页起章等；
- 基于 XeLaTeX + latexmk 一键编译；各章用 `\include` 组织，支持 `\includeonly` 只编译修改的章节；
- 英文字体自动回退：系统未装 Times New Roman / Arial 时自动使用 TeX Live 自带的 TeX Gyre 复刻字体。

## 快速开始

**注意：推荐安装 TeX Live 发行版（或 MiKTeX），并且需要使用 XeLaTeX 编译！**

```tex
\documentclass[openany,twoside,zihao=-4]{zhbook}  % 本模板推荐的默认选项
```

将本仓库作为起点使用即可：`zhbook.cls`（文类，全部版式设置都在其中）、`main.tex`（主文件，书籍信息与章节组织）、`part/`（各章节源文件）、`reference.bib`（参考文献库）与两个 `gbt7714-2025-*.bst` 样式文件放在同一目录，修改封面信息与内容后用 latexmk 编译（见下一节）。

## 类选项

| 选项 | 取值 | 说明 |
| --- | --- | --- |
| `print` | — | 打印模式：封面、前言等处自动补空白页，并隐藏链接颜色 |
| `openany` / `openright` | — | 各章从任意页（默认）/ 奇数页开始 |
| `twoside` / `oneside` | — | 双面（默认）/ 单面排版 |
| `zihao` | `-4`、`5` 等 | 正文字号，默认小四号（`zihao=-4`） |
| `fontset` | `windows`、`mac`、`fandol` 等 | 中文字体集（默认自动检测当前系统） |
| `mathfont` | `lmodern`、`xits`、`termes`、`stix2`、`pagella` | 数学字体（基于 unicode-math）；不设置则沿用 LaTeX 默认数学字体 |
| `bindingoffset` | 长度，如 `1cm` | 装订线：双面打印时在页面内侧额外预留的宽度 |

- 英文字体为 Times 风格时，`mathfont=xits` 或 `mathfont=termes` 与正文风格最协调（XITS 自带粗体数学字形，其余字体粗体数学自动回退为常规字形）；
- 装订线建议配合 `openright` 或 `print` 模式使用，此时前置页从奇数页开始，装订边与物理页一致；
- ctexbook 文类的其他选项（如 `fontset`、`heading` 等）均可直接传给本模板。

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

- 修改某一章时可只编译该章：在导言区加入 `\includeonly{part/chap03}`（换成相应章节文件），
  latexmk 只重排该章，显著加快预览；第一次使用前需完整编译一次，定稿前注释掉该行再完整编译一次即可。
- 正文各章使用 `\include` 组织（`part/chap01.tex` … `part/chap05.tex`、`part/appendix.tex`），
  上述增量编译即依赖于此。
- latexmk 会自动用 `xelatex -no-pdf` 完成中间各遍、最后用 `xdvipdfmx` 输出 PDF，多遍编译更快（无需设置）。
- 不需要编辑器的正反向定位时可加 `-synctex=0`：`latexmk -synctex=0`。

## 参考文献

文献信息写在 `reference.bib` 中。默认样式 `gbt7714-2025-numeric` 对应顺序编码制，引用格式可选
`numbers` 或 `super`（上标）；也可切换为 `gbt7714-2025-authoryear`（著者-出版年制，对应引用格式
`authoryear`）。著录规则符合国家标准 GB/T 7714—2025《信息与文献 参考文献著录规则》。
引用与样式切换方法见 `main.tex` 中相应注释。

## 排版细节

- 段落策略：每个自然段（包括节标题后的首段、列表项内与引文环境内新起的段落）首行缩进 2 个汉字
  （按 `\ccwd` 计算，随字号自动变化）；段间距约 4pt，行距 1.35 倍。
- 图题、表题居中排版（多行同样居中）；章首页页码居中置于页脚。
- 列表项之间不留额外间距；代码块带行号、单线边框与配色（关键字蓝、注释绿、字符串红），
  中文注释可正常排版。
- 脚注采用中文惯例：注文第一行随注码顶格，转行顶格。

## 目录结构

```text
zhbook.cls                    文类文件 (全部版式设置)
main.tex                      主文件 (书籍信息、导言区、章节组织)
part/                         各章节源文件
├── preface.tex               前言
├── chap01.tex … chap05.tex   第 1–5 章
├── appendix.tex              附录 A、B
├── denotation.tex            主要符号表
└── epilogue.tex              后记
reference.bib                 参考文献库
gbt7714-2025-numeric.bst      GB/T 7714—2025 顺序编码制样式
gbt7714-2025-authoryear.bst   GB/T 7714—2025 著者-出版年制样式
figures/                      示例插图 (EPS)
docs/images/                  README 预览图
makefiles.sh / makefiles.bat  编译/清理脚本
.latexmkrc                    latexmk 配置
```

## 效果预览

<table>
<tr>
<td><img src="docs/images/toc.png" width="100%"></td>
<td><img src="docs/images/math.png" width="100%"></td>
</tr>
<tr>
<td align="center">目录</td>
<td align="center">数学公式与定理</td>
</tr>
<tr>
<td><img src="docs/images/listings.png" width="100%"></td>
<td><img src="docs/images/figure.png" width="100%"></td>
</tr>
<tr>
<td align="center">代码排版 (listings)</td>
<td align="center">图片与六子图并排</td>
</tr>
<tr>
<td><img src="docs/images/bibliography.png" width="100%"></td>
<td></td>
</tr>
<tr>
<td align="center">参考文献 (GB/T 7714—2025)</td>
<td></td>
</tr>
</table>

## 常见问题

**编译时报找不到字体？**
模板默认自动检测系统字体；Linux/macOS 未装 Times New Roman/Arial 时会自动回退为 TeX Live
自带的 TeX Gyre 复刻字体，通常无需处理。Windows 用户可显式指定 `fontset=windows`。

**索引是空的？**
索引由 `imakeidx` 在编译时自动调用 `makeindex`（需要允许 shell 执行，TeX Live 默认允许）；
若编译时禁用了 shell 执行，请手动运行 `makeindex main.idx` 后重新编译。

**要打印装订成书？**
使用 `print` 模式并设置装订线，例如：
`\documentclass[print,openright,zihao=-4,bindingoffset=1cm]{zhbook}`。

## 许可协议

本项目基于 MIT 许可协议发布，详情见 [LICENSE](LICENSE)。
