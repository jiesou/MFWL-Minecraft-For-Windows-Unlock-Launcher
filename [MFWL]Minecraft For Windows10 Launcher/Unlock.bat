@echo off
setlocal DisableDelayedExpansion
cd /d "%~dp0"
::启动说明
title MFWL
echo [36m****** MINECRAFT FOR WINDOWS UNLOCK
echo 该脚本可以自动选择方案并解锁 Minecraft for Windows（UWP）
echo 请确保您已经安装了 Minecraft for Windows（可以是试用版）
echo 最好确保系统不是精简优化版且系统版本大于等于 Windows10 1909
echo 解锁时用方案 A 取消解锁也必须用方案 A；解锁时用方案 B 取消解锁也必须用方案 B。方案 A 和 B 只需使用一个，不可同时使用。否则会导致系统文件损坏！
echo 相关方法原理来自网络，本脚本由 jiecs_23 制作
::检测环境
echo.
echo [0m当前运行路径：%CD%
echo [0m检查管理员权限...
if exist "%SystemRoot%\SysWOW64" path %path%;%windir%\SysNative;%SystemRoot%\SysWOW64;%~dp0
bcdedit >nul
if not ERRORLEVEL 1 goto uacOK
echo [31m### 未获取到管理员权限
echo [36m### 请授予管理员权限（UAC）[0m
%1 start "" mshta vbscript:createobject("shell.application").shellexecute("""%~0""","::",,"runas",1)(window.close)&exit
exit /B
:uacOK
echo [0m检查 Minecraft for Windows 状态...
tasklist|find "Minecraft.Windows.exe" || goto mcOK
echo [36m******错误！Minecraft for Windows10 正在运行，不能在其运行中操作
echo 【1】强制关闭 Minecraft for Windows10 并继续
echo 【2】跳过检测状态并继续
echo 【3】帮助信息与相关链接
choice /c 123 /n /m "你想要执行的操作："
if ERRORLEVEL 3 goto Help
if ERRORLEVEL 2 goto Started
if ERRORLEVEL 1 (
	echo [0m
	taskkill /im Minecraft.Windows.exe /f
	timeout /nobreak /t 3
	goto Started
)
:mcOK

::获取用户操作
:Started
echo.
::64位系统需要两个文件都解锁，n初始值为0；32位系统只需要一个文件解锁，n初始值为1
if %PROCESSOR_ARCHITECTURE:~-2%==64 (set n=0) else (set n=1)
	::之前我两个文件的 hash 弄错了，弄成原 DLL 的 hash 了（而不是替换后的）。虽然在我的设备上的结果没有问题，但在其他设备上可能是错的 --jiesou
for  /f %%i in ('certutil -hashfile %windir%\System32\Windows.ApplicationModel.Store.dll') do (
	if %%i==8e92ff0b8ff2d1b0c2fbe59bcbb1705febadcbfd set /a n+=1
)
for  /f %%i in ('certutil -hashfile %windir%\SysWOW64\Windows.ApplicationModel.Store.dll') do (
	if %%i==92f46f5e11d1635ad48fee5c3d1b1632fcb5f549 set /a n+=1
)
echo [36m### 解锁时用方案 A 取消解锁也必须用方案 A；解锁时用方案 B 取消解锁也必须用方案 B。否则会导致系统文件损坏！
::n小于2则表示方案A解锁不完整
if %n%==2 echo [36m### 处于方案 A 的已解锁状态
for /f "tokens=3" %%i in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ClipSVC\Parameters" /v "ServiceDll"') do (
	if not %%i==%SystemRoot%\System32\ClipSVC.dll echo [36m### 处于方案 B 的已解锁状态
)
echo [36m******执行操作
echo 【1】选择方案解锁 Minecraft for Windows
echo 【2】选择方案取消解锁 Minecraft for Windows（恢复原样）
echo 【3】帮助信息与相关链接
choice /c 123 /n /m "你想要执行的操作："
if ERRORLEVEL 3 goto Help
if ERRORLEVEL 2 goto analyticsOff
if ERRORLEVEL 1 goto analyticsOn


::分析适合的解锁方案
:analyticsOn
echo.
echo [0m### 开始分析适合的解锁方案
for /f "tokens=4-7 delims=[.] " %%i in ('ver') do @(if %%i==Version (set ver=%%j.%%k.%%l) else (set ver=%%i.%%j.%%k))
echo 当前系统版本：%ver%
echo [36m### 解锁时用方案 A 取消解锁也必须用方案 A；解锁时用方案 B 取消解锁也必须用方案 B。方案 A 和 B 只需使用一个，不可同时使用。否则会导致系统文件损坏！
echo ### 使用方案 A 请最好确保您的系统版本大于等于 Windows10 1909
echo ### 使用方案 B 请最好确保您的系统不是精简优化版，否则可能会导致系统蓝屏等故障
echo ### 使用方案 B 会导致 Microsoft Store 无法下载应用，请参考帮助信息与相关链接
echo ### 使用方案 B 启动 Minecraft 需要手动结束 RuntimeBroker.exe 进程，或使用 PlanB Launcher.bat 启动
echo ### 可以使用 PlanB UnlockLauncher.bat 启动 Minecraft，自动使用方案 B 解锁并处理相关问题
::https://support.microsoft.com/en-us/topic/january-12-2021-kb4598229-os-build-18363-1316-expired-2dcf5a0d-7e15-8e9e-7576-8abf3d810998
if %ver% GEQ 10.0.18363.1316 (
	echo *** 当前系统环境建议使用方案 A 解锁
) else (
	echo ### 系统版本低于 Windows10 1909
	echo *** 当前系统环境建议使用方案 B 解锁
)
echo 【a】使用方案 A 解锁（替换 DLL）
echo 【b】使用方案 B 解锁（禁用服务）
choice /c ab /n /m "你想要执行的操作："
if ERRORLEVEL 2 (
	echo [0m### 开始解锁 Minecraft for Windows（方案B）
	goto bOn
)
if ERRORLEVEL 1 (
	echo [0m### 开始解锁 Minecraft for Windows（方案A）
	goto aOn
)

::解锁方案A - 替换 DLL
:aOn
set bit=%PROCESSOR_ARCHITECTURE:~-2%
echo 当前系统架构：x%bit%
if %bit%==64 (
	echo 开始处理 System32 DLL
	echo 记录文件 DACL 状态...
	icacls %windir%\System32\Windows.ApplicationModel.Store.dll /save %windir%\System32\Windows.ApplicationModel.Store.dll.temp
	echo 夺取文件所有者...
	takeown /a /f %windir%\System32\Windows.ApplicationModel.Store.dll
	echo 获取文件权限...
	icacls %windir%\System32\Windows.ApplicationModel.Store.dll /c /grant Administrators:F
	echo 备份原 DLL...
	rename %windir%\System32\Windows.ApplicationModel.Store.dll Windows.ApplicationModel.Store.dll.backup
	if ERRORLEVEL 1 (
		echo [31m### 文件操作失败，可能是因为文件被其它程序占用（level%errorlevel%）[0m
	) else (
		echo 替换新 DLL...
		copy /y .\aRes\x64\System32\Windows.ApplicationModel.Store.dll %windir%\System32\Windows.ApplicationModel.Store.dll
	)
	echo 恢复文件 DACL 状态...
	icacls %windir%\System32 /restore %windir%\System32\Windows.ApplicationModel.Store.dll.temp && del /f %windir%\System32\Windows.ApplicationModel.Store.dll.temp
	echo.
	echo.
	echo 开始处理 SysWOW64 DLL
	echo 记录文件 DACL 状态...
	icacls %windir%\SysWOW64\Windows.ApplicationModel.Store.dll /save %windir%\SysWOW64\Windows.ApplicationModel.Store.dll.temp
	echo 夺取文件所有者...
	takeown /a /f %windir%\SysWOW64\Windows.ApplicationModel.Store.dll
	echo 获取文件权限...
	icacls %windir%\SysWOW64\Windows.ApplicationModel.Store.dll /c /grant Administrators:F
	echo 备份原 DLL...
	rename %windir%\SysWOW64\Windows.ApplicationModel.Store.dll Windows.ApplicationModel.Store.dll.backup
	if ERRORLEVEL 1 (
		echo [31m### 文件操作失败，可能是因为文件被其它程序占用（level%errorlevel%）[0m
	) else (
		echo 替换新 DLL...
		copy /y .\aRes\x64\SysWOW64\Windows.ApplicationModel.Store.dll %windir%\SysWOW64\Windows.ApplicationModel.Store.dll
	)
	echo 恢复文件 DACL 状态...
	icacls %windir%\SysWOW64 /restore %windir%\SysWOW64\Windows.ApplicationModel.Store.dll.temp && del /f %windir%\SysWOW64\Windows.ApplicationModel.Store.dll.temp
) else (
	echo 开始处理 System32 DLL
	echo 记录文件 DACL 状态...
	icacls %windir%\System32\Windows.ApplicationModel.Store.dll /save %windir%\System32\Windows.ApplicationModel.Store.dll.temp
	echo 夺取文件所有者...
	takeown /a /f %windir%\System32\Windows.ApplicationModel.Store.dll
	echo 获取文件权限...
	icacls %windir%\System32\Windows.ApplicationModel.Store.dll /c /grant Administrators:F
	echo 备份原 DLL...
	rename %windir%\System32\Windows.ApplicationModel.Store.dll Windows.ApplicationModel.Store.dll.backup
	if ERRORLEVEL 1 (
		echo [31m### 文件操作失败，可能是因为文件被其它程序占用（level%errorlevel%）[0m
	) else (
		echo 替换新 DLL...
		copy /y .\aRes\x86\System32\Windows.ApplicationModel.Store.dll %windir%\System32\Windows.ApplicationModel.Store.dll
	)
	echo 恢复文件 DACL 状态...
	icacls %windir%\System32 /restore %windir%\System32\Windows.ApplicationModel.Store.dll.temp && del /f %windir%\System32\Windows.ApplicationModel.Store.dll.temp
)
echo [32m### Minecraft for Windows10 解锁步骤全部完成
goto Started

::解锁方案B - 添加注册表并停止服务
:bOn
echo [0m添加注册表项...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ClipSVC\Parameters" /v ServiceDll /t REG_EXPAND_SZ /d "%SystemRoot%\System32\ClipSVC.dlla" /f
echo 停止 ClipSVC 服务...
net	stop ClipSVC
if %errorlevel%==2 (echo [31m### ClipSVC 服务停止失败（level2 可能是因为服务本就未启动）) else if ERRORLEVEL 1 (echo [31m### ClipSVC 服务停止失败（level%errorlevel%）)
echo [32m### Minecraft for Windows10 解锁步骤全部完成
goto Started


::分析适合的取消解锁方案
:analyticsOff
echo.
echo [0m### 开始分析适合的取消解锁方案
	::现在有了稳定的方法来判断解锁状态，不再需要之前那复杂的通过分数建议方案的机制了 --jiesou
if %PROCESSOR_ARCHITECTURE:~-2%==64 (set n=0) else (set n=1)
for  /f %%i in ('certutil -hashfile %windir%\System32\Windows.ApplicationModel.Store.dll') do (
	if %%i==8e92ff0b8ff2d1b0c2fbe59bcbb1705febadcbfd set /a n+=1
)
for  /f %%i in ('certutil -hashfile %windir%\SysWOW64\Windows.ApplicationModel.Store.dll') do (
	if %%i==92f46f5e11d1635ad48fee5c3d1b1632fcb5f549 set /a n+=1
)
echo [36m### 解锁时用方案 A 取消解锁也必须用方案 A；解锁时用方案 B 取消解锁也必须用方案 B。否则会导致系统文件损坏！
if %n%==2 echo *** 当前系统环境建议取消解锁方案 A
for /f "tokens=3" %%i in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ClipSVC\Parameters" /v "ServiceDll"') do (
	if not %%i==C:\WINDOWS\System32\ClipSVC.dll echo *** 当前系统环境建议取消解锁方案 B
)
echo 【a】取消解锁方案 A（替换 DLL）
echo 【b】取消解锁方案 B（禁用服务）
choice /c ab /n /m "你想要执行的操作："
if ERRORLEVEL 2 (
	echo [0m### 开始取消解锁 Minecraft for Windows（方案B）
	goto bOff
)
if ERRORLEVEL 1 (
	echo [0m### 开始取消解锁 Minecraft for Windows（方案A）
	goto aOff
)

::取消解锁方案A - 恢复备份的 DLL
:aOff
set bit=%PROCESSOR_ARCHITECTURE:~-2%
echo [0m当前系统架构：x%bit%
if %bit%==64 (
	echo 开始处理 System32 DLL
	echo 记录文件 DACL 状态...
	icacls %windir%\System32\Windows.ApplicationModel.Store.dll /save %windir%\System32\Windows.ApplicationModel.Store.dll.temp
	echo 夺取文件所有者...
	takeown /a /f %windir%\System32\Windows.ApplicationModel.Store.dll
	echo 获取文件权限...
	icacls %windir%\System32\Windows.ApplicationModel.Store.dll /grant Administrators:F
	if exist %windir%\System32\Windows.ApplicationModel.Store.dll.backup (
		echo 删除替换的 DLL...
		del /f %windir%\System32\Windows.ApplicationModel.Store.dll
		echo 恢复备份 DLL...
		rename %windir%\System32\Windows.ApplicationModel.Store.dll.backup Windows.ApplicationModel.Store.dll
	) else (
		echo [31m### System32 DLL 备份不存在（可能是因为本就没有使用方案 A 解锁或解锁失败）[0m
		echo 尝试使用 Windows SFC 工具修复 DLL 文件...
		sfc /scanfile=%windir%\System32\Windows.ApplicationModel.Store.dll
	)
	echo 恢复文件 DACL 状态...
	icacls %windir%\System32 /restore %windir%\System32\Windows.ApplicationModel.Store.dll.temp && del /f %windir%\System32\Windows.ApplicationModel.Store.dll.temp
	echo.
	echo.
	echo 开始处理 SysWOW64 DLL
	echo 记录文件 DACL 状态...
	icacls %windir%\SysWOW64\Windows.ApplicationModel.Store.dll /save %windir%\SysWOW64\Windows.ApplicationModel.Store.dll.temp
	echo 夺取文件所有者...
	takeown /a /f %windir%\SysWOW64\Windows.ApplicationModel.Store.dll
	echo 获取文件权限...
	icacls %windir%\SysWOW64\Windows.ApplicationModel.Store.dll /grant Administrators:F
	if exist %windir%\SysWOW64\Windows.ApplicationModel.Store.dll.backup (
		echo 删除替换的 DLL...
		del /f %windir%\SysWOW64\Windows.ApplicationModel.Store.dll
		echo 恢复备份 DLL...
		rename %windir%\SysWOW64\Windows.ApplicationModel.Store.dll.backup Windows.ApplicationModel.Store.dll
	) else (
		echo [31m### SysWOW64 DLL 备份不存在（可能是因为本就没有使用方案 A 解锁或解锁失败）[0m
		echo 尝试使用 Windows SFC 工具修复 DLL 文件...
		sfc /scanfile=%windir%\SysWOW64\Windows.ApplicationModel.Store.dll
	)
	echo 恢复文件 DACL 状态...
	icacls %windir%\SysWOW64 /restore %windir%\SysWOW64\Windows.ApplicationModel.Store.dll.temp && del /f %windir%\SysWOW64\Windows.ApplicationModel.Store.dll.temp
) else (
	echo 开始处理 System32 DLL
	echo 记录文件 DACL 状态...
	icacls %windir%\System32\Windows.ApplicationModel.Store.dll /save %windir%\System32\Windows.ApplicationModel.Store.dll.temp
	echo 夺取文件所有者...
	takeown /a /f %windir%\System32\Windows.ApplicationModel.Store.dll
	echo 获取文件权限...
	icacls %windir%\System32\Windows.ApplicationModel.Store.dll /grant Administrators:F
	if exist %windir%\System32\Windows.ApplicationModel.Store.dll.backup (
		echo 删除替换的 DLL...
		del /f %windir%\System32\Windows.ApplicationModel.Store.dll
		echo 恢复备份 DLL...
		rename %windir%\System32\Windows.ApplicationModel.Store.dll.backup Windows.ApplicationModel.Store.dll
	) else (
		echo [31m### System32 DLL 备份不存在（可能是因为本就没有使用方案 A 解锁或解锁失败）[0m
		echo 尝试使用 Windows SFC 工具修复 DLL 文件...
		sfc /scanfile=%windir%\System32\Windows.ApplicationModel.Store.dll
	)
	echo 恢复文件 DACL 状态...
	icacls %windir%\System32 /restore %windir%\System32\Windows.ApplicationModel.Store.dll.temp && del /f %windir%\System32\Windows.ApplicationModel.Store.dll.temp
)
echo [32m### Minecraft for Windows 取消解锁（恢复原样）步骤全部完成
goto Started

::取消解锁方案B - 添加注册表并启动服务
:bOff
echo 添加注册表项...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ClipSVC\Parameters" /v ServiceDll /t REG_EXPAND_SZ /d "%SystemRoot%\System32\ClipSVC.dll" /f
echo 启动 ClipSVC 服务...
net	start ClipSVC
if %errorlevel%==2 (echo [31m### ClipSVC 服务启动失败（level2 可能是因为服务本就已启动）) else if ERRORLEVEL 1 (echo [31m### ClipSVC 服务启动失败（level%serviceError%）)
echo [32m### Minecraft for Windows 取消解锁（恢复原样）步骤全部完成
goto Started

:Help
echo.
echo [36m******帮助信息与相关链接
echo bat 脚本制作：杰出兽 jiecs_23 Jiecs
echo 帮助信息与相关链接：https://www.jiecs.top/archives/764
echo 【1】返回主页面
echo 【2】用浏览器打开帮助文档链接
choice /c 12 /n /m "你想要执行的操作："
if ERRORLEVEL 2 start https://www.jiecs.top/archives/764
goto Started