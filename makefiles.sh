#!/usr/bin/env bash
#
# boyogalazhcnbook 编译脚本 (基于 latexmk)
#
# 用法:
#   ./makefiles.sh            编译 main.tex (自动处理 bibtex/makeindex 与多遍编译)
#   ./makefiles.sh clean      清理中间文件
#   ./makefiles.sh cleanall   清理中间文件与 main.pdf
#
set -euo pipefail
cd "$(dirname "$0")"

if ! command -v latexmk >/dev/null 2>&1; then
    echo "未找到 latexmk, 请先安装 TeX Live 或 MiKTeX (自带 latexmk)。" >&2
    echo "也可手动编译: xelatex main.tex && bibtex main && xelatex main.tex && xelatex main.tex" >&2
    exit 1
fi

case "${1:-build}" in
    clean)
        latexmk -c
        ;;
    cleanall)
        latexmk -C
        ;;
    *)
        latexmk
        echo "编译完成: main.pdf"
        ;;
esac
