# whatwedid.md —— boyogalazhcnbook 项目处理与交接说明

> 本文件记录本项目从原始模板到当前版本的完整处理过程、关键设计、验证方法与版权处理，
> 供项目维护与发布交接使用。

## 1. 项目概况

- **项目**：boyogalazhcnbook —— 中文书籍 LaTeX 模板（基于 ctexbook 文类，XeLaTeX 编译）；
- **仓库**：<https://github.com/boyogala/boyogalazhcnbook>；
- **版本**：v1.1（文类日期 2026/10/16）；示例书 28 页，完整编译 0 错误、无宏包警告（仅 3 处既有 Underfull 提示）；
- **字体**：完全自足——全部 18 个字体文件（约 54 MB）随仓库分发，编译不依赖系统字体与任何第三方字体集；
- **许可**：模板代码 MIT；字体为 GPL v3（附字体嵌入例外）或 SIL OFL 1.1；参考文献样式 LPPL 1.3c+（详见第 6 节）。

## 2. 来源与更名

- 原始项目：Liutao Tian 的 **zhbook**（<https://github.com/andy123t/zhbook>，MIT 许可）；
- 本项目在 zhbook 基础上经过多轮迭代与重构，更名为 **boyogalazhcnbook** 并独立发布；
- 依 MIT 许可要求保留原始版权声明：`LICENSE` 中同时列有原项目作者与 boyogala（博优旮旯）的版权；
- `README.md`「致谢」、`boyogalazhcnbook.cls` 与 `boyogalazhcnbooksetting.tex` 文件头部均注明来源与原作者。

## 3. 处理过程（19 次提交，按时间顺序）

| 提交 | 日期 | 主要工作 |
| --- | --- | --- |
| `d497345` | 2026-10-16 | 初始状态：zhbook 模板还原点 |
| `2d7013c` | 2026-10-16 | 迭代 A：工程基座与热修 |
| `af25ab1` | 2026-10-16 | 参考文献样式更新至 GB/T 7714—2025 |
| `0d78f66` | 2026-10-16 | 清理自定义命令并完善代码注释 |
| `fdb1b46` | 2026-10-16 | 迭代 B：类文件与示例的 11 项改进 |
| `cede60f` | 2026-10-16 | 迭代 C：增量编译与构建提速 |
| `0168a43` | 2026-10-16 | 迭代 D：数学字体/装订线选项、段落体例、代码样式与 README 改版 |
| `1b5ab41` | 2026-10-16 | 迭代 E：全局设置迁入独立设置文件、字体全方案与 README 更新 |
| `95d2ca0` | 2026-10-16 | 字体入库：18 个字体文件与自由许可文件收入 `font/` |
| `3c1cafc` | 2026-10-16 | 字体精简：全部字体文件统一移至 `font/` 根目录 |
| `c395090` | 2026-10-16 | 目录改名 part → chapters 并同步全部引用 |
| `f27a3d8` | 2026-10-16 | 封面重做为现代三栏式；前言加入公众号二维码页 |
| `0a9421a` | 2026-10-16 | 行溢出保护（emergencystretch） |
| `526e0a8` | 2026-10-16 | 封面 logo 与座右铭调整 |
| `bc697bc` | 2026-10-17 | 静默 Fandol 字体的 fontspec 无害脚本警告 |
| `a9dc4da` | 2026-10-17 | 清理项目：删除陈旧文件与冗余代码，补充 tikz/mathtools 与示例 |
| `f58c2b3` | 2026-10-17 | 项目独立化：更名 boyogalazhcnbook（v1.1）、追加版权与致谢 |
| `e54a725` | 2026-10-17 | 字体族更名 cnsong/cnhei/cnfs/cnkai 并独立定义，消除 xeCJK 重定义警告 |
| `285c1e3` | 2026-10-17 | 字体体系完全自足：删除 mathfont 备用选项，字体命令与字族全部项目自定 |

随后一次「文档与版权完善」提交完成本文件、README 详细化与字体版权说明；项目作者新增的章节内容与 `main.pdf` 已另行提交（`863946a`）。

## 4. 字体体系设计（核心）

- 文类以 `fontset=none` 载入 ctexbook：**不使用任何 ctex 字体集**，中文字体完全由项目自行定义；
- 字体族命名 `cnsong` / `cnhei` / `cnfs` / `cnkai` / `cncover`，避免与 ctex 预置名冲突（消除字体重定义警告）；
- 中文命令 `\songti`、`\heiti`、`\fangsong`、`\kaishu`、`\coverfont` 全部由本项目定义，只指向 `font/` 中的字体文件；
- 西文（STIX Two Text / 思源黑体 / JetBrains Mono）与数学（STIX Two Math，粗体用 XITS Math Bold）同样取自 `font/`；
- 已删除 `mathfont` 备用类选项（原会调用 TeX Live 字体）——项目不引用、也不依赖 `font/` 之外的任何字体。

## 5. 验证方法（可复现）

1. 清空重编译：`latexmk -C && latexmk`；
2. 检查日志：0 处 `!` 错误、无宏包警告、仅 3 处既有 Underfull；共 28 页；
3. 保真验证：与重构前基线逐页像素对比（96 dpi，ImageMagick `compare -metric AE`）为 **0 差异**，
   `pdftotext` 文本层完全一致——全部重构未改变任何排版结果。

## 6. 版权与许可处理

- **模板代码**：MIT 许可（`LICENSE`），保留 zhbook 原作者 Liutao Tian 的版权声明，并加入 boyogala 的版权；
- **字体**：全部为自由字体，可随模板公开分发；版权人、版本与来源明细见 [`font/README.md`](font/README.md)：
  - Fandol：GPL v3，**附加字体嵌入例外**（上游说明原文：“These fonts's licensing is GPL + GPL font exception.”）——在文档中使用并嵌入这些字体不会使书稿受 GPL 约束；字体文件与 TeX Live / CTAN 上游逐字节一致，未作修改；
  - STIX Two、XITS Math、思源黑体、JetBrains Mono：SIL OFL 1.1（字形与名称未改动）；
  - 许可全文随附于 `font/`：`GPLv3-Fandol.txt`、`OFL-*.txt`（四份）；
- **参考文献样式**：`gbt7714-2025-*.bst` 来自 Zeping Lee 的 [gbt7714-bibtex-style](https://github.com/zepinglee/gbt7714-bibtex-style) v3.1.1（LPPL 1.3c+，版权归原作者，文件头声明完整，未做修改）；
- **素材**：示例插图 `figures/image1,2` 沿用自原项目（MIT 许可）；封面 logo 与前言二维码为项目作者素材；`docs/images/` 为模板输出截图；
- **使用者提示**：用本模板排版的书稿，其版权完全归作者所有，不受上述任何许可约束。

## 7. 当前状态与后续步骤

- 分支 `main`；远程仓库 <https://github.com/boyogala/boyogalazhcnbook> 已配置并完成推送，本地与远程 `main` 同步于 `863946a`（含项目作者最新正文与示例输出 `main.pdf`）；
- 日常更新：编辑后用 `git add -A && git commit -m "..." && git push` 推送即可；
- 仓库设置：描述已设置；Topics 与 v1.1 Release 待发布（通过 GitHub 网页或授权后的接口完成）。

## 8. 关键文件速览

| 文件 | 说明 |
| --- | --- |
| `boyogalazhcnbook.cls` | 文类：版式主体（封面、章节样式、页眉页脚、定理环境、算法/代码样式等） |
| `boyogalazhcnbooksetting.tex` | 全局设置：字体（第一节）、宏包、参考文献/引用/索引（第三节）等 |
| `main.tex` | 主文件：封面信息与章节组织 |
| `chapters/` | 各章源文件（示例即教程：第 2、4、5 章演示环境、插图与表格） |
| `reference.bib`、`gbt7714-2025-*.bst` | 参考文献库与 GB/T 7714—2025 样式 |
| `font/` | 18 个字体文件 + 5 份许可文本 + 版权清单（`font/README.md`） |
| `README.md` | 项目介绍与完整使用说明（含字体设置详解） |
| `LICENSE` | MIT 许可（双版权声明） |
| `whatwedid.md` | 本文件：处理与交接说明 |
