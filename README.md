# zhbook

中文书籍 LaTeX 模板

**注意：** 本模板推荐安装 **texlive** 发行版，并且需要 **XeLaTeX** 编译运行！

```tex
\documentclass[openany,twoside,zihao=-4]{zhbook}
```

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

## 参考文献

参考文献样式默认为 `gbt7714-2025-numeric`（顺序编码制），也可选用 `gbt7714-2025-authoryear`（著者-出版年制），
两者均符合国家标准 **GB/T 7714—2025**《信息与文献 参考文献著录规则》。
旧的 `thuthesis-numeric` / `thuthesis-author-year`（GB/T 7714—2015）仍保留在模板中，供兼容使用。

本模板为中文书籍 LaTeX 模板，主文件 **main.tex** 给出使用的指南和要求，也展示了论文排版中常用的例子，包括公式、定理、表格、插图、参考文献等。

在线 LaTeX 编辑，设置字体 (`fontset=windows`) ，XeLaTeX 编译运行，推荐使用。
