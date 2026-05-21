@echo off
chcp 65001 >nul 2>&1
title 知产管家 IP Keeper

cd /d "%~dp0"

:: 检查必要文件
if not exist "server.py" (
    echo [错误] 未找到 server.py
    echo 请确保所有文件在同一目录下
    pause
    exit /b 1
)
if not exist "static\index.html" (
    echo [错误] 未找到 static\index.html
    echo 请确保所有文件在同一目录下
    pause
    exit /b 1
)

:: 检查 Python
where python >nul 2>&1
if %errorlevel% neq 0 (
    where python3 >nul 2>&1
    if %errorlevel% neq 0 (
        echo [错误] 未找到 Python，请先安装 Python 3
        echo 下载地址: https://www.python.org/downloads/
        pause
        exit /b 1
    )
    set PYTHON=python3
) else (
    set PYTHON=python
)

:: 安装依赖
echo 正在检查依赖...
%PYTHON% -m pip install -r requirements.txt --quiet 2>nul

:: 启动服务
echo.
echo ████████████████████████████████████████
echo   知产管家 IP Keeper 启动中...
echo   启动后请访问 http://localhost:5678
echo   按 Ctrl+C 可停止服务
echo ████████████████████████████████████████
echo.

:: 等待服务就绪后打开浏览器
start "" cmd /c "timeout /t 3 /nobreak >nul & start http://localhost:5678"

:: 启动服务器（前台运行）
%PYTHON% server.py
pause
