# .latexmkrc — zhbook 中文书籍模板构建配置
#
# 常用命令:
#   latexmk           编译 (自动 xelatex/bibtex/makeindex, 自动决定编译遍数)
#   latexmk -pvc      持续编译 (源文件保存后自动重编, 适合边写边看)
#   latexmk -c        清理中间文件
#   latexmk -C        清理中间文件与 main.pdf
#
# 本配置默认编译主文件 main.tex;
# 若更换主文件名, 只需修改下面的 @default_files 或在命令行给出文件名。

$pdf_mode = 5;                  # 5 = 使用 xelatex 生成 PDF
@default_files = ('main.tex');  # 主文件
$bibtex_use = 2;                # 需要时自动运行 bibtex

# -synctex=1: 生成压缩版 synctex.gz, 供编辑器正反向定位;
# 不需要时可在命令行覆盖: latexmk -synctex=0
$xelatex = 'xelatex -synctex=1 %O %S';
