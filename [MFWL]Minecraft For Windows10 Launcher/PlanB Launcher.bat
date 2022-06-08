@echo off
cd /d "%~dp0"
::启动说明
title MFWL
echo [36m****** MINECRAFT FOR WINDOWS MINECRAFT FOR WINDOWS PLAN B LAUNCHER
echo 该脚本将自动打开 Minecraft for Windows10 并结束 RuntimeBroker.exe 进程 
echo 请确保您已经安装了 Minecraft for Windows（可以是试用版）
echo 最好确保系统不是精简优化版且系统版本大于等于 Windows10 1909
echo 相关方法原理来自网络，本脚本由 jiecs_23 制作
::检测环境
echo.
echo [0m当前运行路径：%CD%
echo [0m检查 Minecraft for Windows 状态...
tasklist |find /i "Minecraft.Windows.exe"
if ERRORLEVEL 1 goto mcOK
echo [36m******错误！Minecraft for Windows10 正在运行，不能同时运行多个实例
echo 【1】强制关闭 Minecraft for Windows10 并继续
echo 【2】跳过检测状态并继续
choice /c 12 /n /m "你想要执行的操作："
if ERRORLEVEL 2 goto Unlock
if ERRORLEVEL 1 (
	echo [0m
	taskkill /im Minecraft.Windows.exe /f
	timeout /nobreak /t 3
	goto Unlock
)
:mcOK

::启动Minecraft
echo ### 尝试启动 Minecraft for Windows
start Minecraft:
timeout /nobreak /t 3
set num=1
tasklist|find /i "Minecraft.Windows.exe"
if not ERRORLEVEL 1 (
	echo [32m### Minecraft for Windows10 已成功启动[0m
	goto Loop
)
echo [36m******错误！Minecraft for Windows10 应当启动，但因未知原因未启动
echo 请确保您已经安装了 Minecraft for Windows（可以是试用版）
echo 【1】重新尝试启动 Minecraft for Windows10 并不再检测其状态
echo 【2】跳过检测状态并继续
choice /c 12 /n /m "你想要执行的操作："
if ERRORLEVEL 2 goto Loop
if ERRORLEVEL 1 (
	start Minecraft:
	timeout /nobreak /t 3
	echo [0m
	goto Loop
)

::循环结束 RuntimeBroker.exe 进程
:Loop
tasklist|find "Minecraft.Windows.exe" >nul || exit
for /f "tokens=3" %%i in ('tasklist /nh /apps /fi "IMAGENAME eq RuntimeBroker.exe"^|find "Microsoft.MinecraftUWP"') do @taskkill /pid %%i /f
goto Loop
