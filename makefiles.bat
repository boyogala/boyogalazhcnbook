@echo off
@rem ------------------------------------------------
@rem  boyogalazhcnbook 编译脚本 (基于 latexmk)
@rem
@rem  用法:
@rem    makefiles.bat            编译 main.tex
@rem    makefiles.bat clean      清理中间文件
@rem    makefiles.bat cleanall   清理中间文件与 main.pdf
@rem ------------------------------------------------
setlocal
cd /d "%~dp0"

set MODE=%1
if "%MODE%"=="" set MODE=build

if /i "%MODE%"=="clean" (
    latexmk -c
    goto :end
)
if /i "%MODE%"=="cleanall" (
    latexmk -C
    goto :end
)

latexmk
if errorlevel 1 (
    echo [错误] 编译失败, 详情请查看 main.log
    exit /b 1
)
echo [完成] 已生成 main.pdf

:end
endlocal
