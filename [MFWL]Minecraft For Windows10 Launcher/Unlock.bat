@echo off
setlocal DisableDelayedExpansion
cd /d "%~dp0"
::����˵��
title MFWL
echo [36m****** MINECRAFT FOR WINDOWS UNLOCK
echo �ýű������Զ�ѡ�񷽰������� Minecraft for Windows��UWP��
echo ��ȷ�����Ѿ���װ�� Minecraft for Windows�����������ð棩
echo ���ȷ��ϵͳ���Ǿ����Ż�����ϵͳ�汾���ڵ��� Windows10 1909��19H2/KB5004926/18362.446��
echo ����ʱ�÷��� A ȡ������Ҳ�����÷��� A������ʱ�÷��� B ȡ������Ҳ�����÷��� B������ A �� B ֻ��ʹ��һ��������ͬʱʹ�á�����ᵼ��ϵͳ�ļ��𻵣�
echo ��ط���ԭ���������磬���ű��� jiecs_23 ����
::��⻷��
echo.
echo [0m��ǰ����·����%CD%
echo [0m������ԱȨ��...
if exist "%SystemRoot%\SysWOW64" path %path%;%windir%\SysNative;%SystemRoot%\SysWOW64;%~dp0
bcdedit >nul
if not ERRORLEVEL 1 goto uacOK
echo [31m### δ��ȡ������ԱȨ��
echo [36m### ���������ԱȨ�ޣ�UAC��[0m
%1 start "" mshta vbscript:createobject("shell.application").shellexecute("""%~0""","::",,"runas",1)(window.close)&exit
exit /B
:uacOK
echo [0m��� Minecraft for Windows ״̬...
tasklist|find "Minecraft.Windows.exe" || goto mcOK
echo [36m******����Minecraft for Windows10 �������У��������������в���
echo ��1��ǿ�ƹر� Minecraft for Windows10 ������
echo ��2���������״̬������
echo ��3��������Ϣ���������
choice /c 123 /n /m "����Ҫִ�еĲ�����"
if ERRORLEVEL 3 goto Help
if ERRORLEVEL 2 goto Started
if ERRORLEVEL 1 (
	echo [0m
	taskkill /im Minecraft.Windows.exe /f
	timeout /nobreak /t 3
	goto Started
)
:mcOK

::��ȡ�û�����
:Started
echo.
::64λϵͳ��Ҫ�����ļ���������n��ʼֵΪ0��32λϵͳֻ��Ҫһ���ļ�������n��ʼֵΪ1
if %PROCESSOR_ARCHITECTURE:~-2%==64 (set n=0) else (set n=1)
	::֮ǰ�������ļ��� hash Ū���ˣ�Ū��ԭ DLL �� hash �ˣ��������滻��ģ�����Ȼ���ҵ��豸�ϵĽ��û�����⣬���������豸�Ͽ����Ǵ�� --jiesou
for  /f %%i in ('certutil -hashfile %windir%\System32\Windows.ApplicationModel.Store.dll') do (
	if %%i==8e92ff0b8ff2d1b0c2fbe59bcbb1705febadcbfd set /a n+=1
)
for  /f %%i in ('certutil -hashfile %windir%\SysWOW64\Windows.ApplicationModel.Store.dll') do (
	if %%i==92f46f5e11d1635ad48fee5c3d1b1632fcb5f549 set /a n+=1
)
echo [36m### ����ʱ�÷��� A ȡ������Ҳ�����÷��� A������ʱ�÷��� B ȡ������Ҳ�����÷��� B������ᵼ��ϵͳ�ļ��𻵣�
::nС��2���ʾ����A����������
if %n%==2 echo [36m### ���ڷ��� A ���ѽ���״̬
for /f "tokens=3" %%i in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ClipSVC\Parameters" /v "ServiceDll"') do (
	if not %%i==C:\WINDOWS\System32\ClipSVC.dll echo [36m### ���ڷ��� B ���ѽ���״̬
)
echo [36m******ִ�в���
echo ��1��ѡ�񷽰����� Minecraft for Windows
echo ��2��ѡ�񷽰�ȡ������ Minecraft for Windows���ָ�ԭ����
echo ��3��������Ϣ���������
choice /c 123 /n /m "����Ҫִ�еĲ�����"
if ERRORLEVEL 3 goto Help
if ERRORLEVEL 2 goto analyticsOff
if ERRORLEVEL 1 goto analyticsOn


::�����ʺϵĽ�������
:analyticsOn
echo.
echo [0m### ��ʼ�����ʺϵĽ�������
for /f "tokens=4-7 delims=[.] " %%i in ('ver') do @(if %%i==Version (set ver=%%j.%%k.%%l) else (set ver=%%i.%%j.%%k))
echo ��ǰϵͳ�汾��%ver%
echo [36m### ����ʱ�÷��� A ȡ������Ҳ�����÷��� A������ʱ�÷��� B ȡ������Ҳ�����÷��� B������ A �� B ֻ��ʹ��һ��������ͬʱʹ�á�����ᵼ��ϵͳ�ļ��𻵣�
echo ### ʹ�÷��� A �����ȷ������ϵͳ�汾���ڵ��� Windows10 1909��19H2/KB5004926/18362.446��
echo ### ʹ�÷��� A ����ʱ��Ҫ��ʱ�ر�ȫ�� Xbox��Microsoft Store ��ز��ֽ��̣���ע�ⲻҪ��ʧ��������
echo ### ʹ�÷��� B �����ȷ������ϵͳ���Ǿ����Ż��棬������ܻᵼ��ϵͳ�����ȹ���
echo ### ʹ�÷��� B �ᵼ�� Microsoft Store �޷�����Ӧ�ã���ο�������Ϣ���������
echo ### ʹ�÷��� B ���� Minecraft ��Ҫ�ֶ����� RuntimeBroker.exe ���̣���ʹ�� PlanB Launcher.bat ����
echo ### ����ʹ�� PlanB UnlockLauncher.bat ���� Minecraft���Զ�ʹ�÷��� B �����������������
if %ver% GEQ 10.0.18362.446 (
	echo ### ��ǰϵͳ��������ʹ�÷��� A
) else (
	echo ### ϵͳ�汾���� Windows10 1909��19H2/KB5004926/18362.446��
	echo ### ��ǰϵͳ��������ʹ�÷��� B
)
echo ��a��ʹ�÷��� A �������滻 DLL��
echo ��b��ʹ�÷��� B ���������÷���
choice /c ab /n /m "����Ҫִ�еĲ�����"
if ERRORLEVEL 2 (
	echo [0m### ��ʼ���� Minecraft for Windows������B��
	goto bOn
)
if ERRORLEVEL 1 (
	echo [0m### ��ʼ���� Minecraft for Windows������A��
	goto aOn
)

::��������A - �滻 DLL
:aOn
set bit=%PROCESSOR_ARCHITECTURE:~-2%
echo ��ǰϵͳ�ܹ���x%bit%
if %bit%==64 (
	echo ��ʼ���� System32 DLL
	echo ��¼�ļ� DACL ״̬...
	icacls %windir%\System32\Windows.ApplicationModel.Store.dll /save %windir%\System32\Windows.ApplicationModel.Store.dll.temp
	echo ��ȡ�ļ�������...
	takeown /a /f %windir%\System32\Windows.ApplicationModel.Store.dll
	echo ��ȡ�ļ�Ȩ��...
	icacls %windir%\System32\Windows.ApplicationModel.Store.dll /c /grant Administrators:F
	echo ����ԭ DLL...
	rename %windir%\System32\Windows.ApplicationModel.Store.dll Windows.ApplicationModel.Store.dll.backup
	echo �滻�� DLL...
	copy /y .\aRes\x64\System32\Windows.ApplicationModel.Store.dll %windir%\System32\Windows.ApplicationModel.Store.dll
	echo �ָ��ļ� DACL ״̬...
	icacls %windir%\System32 /restore %windir%\System32\Windows.ApplicationModel.Store.dll.temp && del /f %windir%\System32\Windows.ApplicationModel.Store.dll.temp
	echo ��ʼ���� SysWOW64 DLL
	echo ��¼�ļ� DACL ״̬...
	icacls %windir%\SysWOW64\Windows.ApplicationModel.Store.dll /save %windir%\SysWOW64\Windows.ApplicationModel.Store.dll.temp
	echo ��ȡ�ļ�������...
	takeown /a /f %windir%\SysWOW64\Windows.ApplicationModel.Store.dll
	echo ��ȡ�ļ�Ȩ��...
	icacls %windir%\SysWOW64\Windows.ApplicationModel.Store.dll /c /grant Administrators:F
	echo ����ԭ DLL...
	rename %windir%\SysWOW64\Windows.ApplicationModel.Store.dll Windows.ApplicationModel.Store.dll.backup
	echo �滻�� DLL...
	copy /y .\aRes\x64\SysWOW64\Windows.ApplicationModel.Store.dll %windir%\SysWOW64\Windows.ApplicationModel.Store.dll
	echo �ָ��ļ� DACL ״̬...
	icacls %windir%\SysWOW64 /restore %windir%\SysWOW64\Windows.ApplicationModel.Store.dll.temp && del /f %windir%\SysWOW64\Windows.ApplicationModel.Store.dll.temp
) else (
	echo ��ʼ���� System32 DLL
	echo ��¼�ļ� DACL ״̬...
	icacls %windir%\System32\Windows.ApplicationModel.Store.dll /save %windir%\System32\Windows.ApplicationModel.Store.dll.temp
	echo ��ȡ�ļ�������...
	takeown /a /f %windir%\System32\Windows.ApplicationModel.Store.dll
	echo ��ȡ�ļ�Ȩ��...
	icacls %windir%\System32\Windows.ApplicationModel.Store.dll /c /grant Administrators:F
	echo ����ԭ DLL...
	rename %windir%\System32\Windows.ApplicationModel.Store.dll Windows.ApplicationModel.Store.dll.backup
	echo �滻�� DLL...
	copy /y .\aRes\x86\System32\Windows.ApplicationModel.Store.dll %windir%\System32\Windows.ApplicationModel.Store.dll
	echo �ָ��ļ� DACL ״̬...
	icacls %windir%\System32 /restore %windir%\System32\Windows.ApplicationModel.Store.dll.temp && del /f %windir%\System32\Windows.ApplicationModel.Store.dll.temp
)
echo [32m### Minecraft for Windows10 �ѽ���
goto Started

::��������B - ���ע���ֹͣ����
:bOn
echo [0m���ע�����...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ClipSVC\Parameters" /v ServiceDll /t REG_EXPAND_SZ /d "%SystemRoot%\System32\ClipSVC.dlla" /f
echo ֹͣ ClipSVC ����...
net	stop ClipSVC
if %errorlevel%==2 (echo [31m### ClipSVC ����ֹͣʧ�ܣ�level2 ��������Ϊ���񱾾�δ������) else if ERRORLEVEL 1 (echo [31m### ClipSVC ����ֹͣʧ�ܣ�level%errorlevel%��)
echo [32m### Minecraft for Windows10 �ѽ���
goto Started


::�����ʺϵ�ȡ����������
:analyticsOff
echo.
echo [0m### ��ʼ�����ʺϵ�ȡ����������
	::���������ȶ��ķ������жϽ���״̬��������Ҫ֮ǰ�Ǹ��ӵ�ͨ���������鷽���Ļ����� --jiesou
if %PROCESSOR_ARCHITECTURE:~-2%==64 (set n=0) else (set n=1)
for  /f %%i in ('certutil -hashfile %windir%\System32\Windows.ApplicationModel.Store.dll') do (
	if %%i==8e92ff0b8ff2d1b0c2fbe59bcbb1705febadcbfd set /a n+=1
)
for  /f %%i in ('certutil -hashfile %windir%\SysWOW64\Windows.ApplicationModel.Store.dll') do (
	if %%i==92f46f5e11d1635ad48fee5c3d1b1632fcb5f549 set /a n+=1
)
echo [36m### ����ʱ�÷��� A ȡ������Ҳ�����÷��� A������ʱ�÷��� B ȡ������Ҳ�����÷��� B������ᵼ��ϵͳ�ļ��𻵣�
if %n%==2 echo ### ��ǰϵͳ��������ʹ�÷��� A
for /f "tokens=3" %%i in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ClipSVC\Parameters" /v "ServiceDll"') do (
	if not %%i==C:\WINDOWS\System32\ClipSVC.dll echo ### ��ǰϵͳ��������ʹ�÷��� B
)
echo ��a��ʹ�÷��� A ȡ���������滻 DLL��
echo ��b��ʹ�÷��� B ȡ�����������÷���
choice /c ab /n /m "����Ҫִ�еĲ�����"
if ERRORLEVEL 2 (
	echo [0m### ��ʼȡ������ Minecraft for Windows������B��
	goto bOff
)
if ERRORLEVEL 1 (
	echo [0m### ��ʼȡ������ Minecraft for Windows������A��
	goto aOff
)

::ȡ����������A - �ָ����ݵ� DLL
:aOff
set bit=%PROCESSOR_ARCHITECTURE:~-2%
echo [0m��ǰϵͳ�ܹ���x%bit%
if %bit%==64 (
	echo ��ʼ���� System32 DLL
	echo ��¼�ļ� DACL ״̬...
	icacls %windir%\System32\Windows.ApplicationModel.Store.dll /save %windir%\System32\Windows.ApplicationModel.Store.dll.temp
	echo ��ȡ�ļ�������...
	takeown /a /f %windir%\System32\Windows.ApplicationModel.Store.dll
	echo ��ȡ�ļ�Ȩ��...
	icacls %windir%\System32\Windows.ApplicationModel.Store.dll /grant Administrators:F
	if exist %windir%\System32\Windows.ApplicationModel.Store.dll.backup (
		echo ɾ���滻�� DLL...
		del /f %windir%\System32\Windows.ApplicationModel.Store.dll
		echo �ָ����� DLL...
		rename %windir%\System32\Windows.ApplicationModel.Store.dll.backup Windows.ApplicationModel.Store.dll
	) else (
		echo [31m### System32 DLL ���ݲ�����[0m
	)
	echo �ָ��ļ� DACL ״̬...
	icacls %windir%\System32 /restore %windir%\System32\Windows.ApplicationModel.Store.dll.temp && del /f %windir%\System32\Windows.ApplicationModel.Store.dll.temp
	echo ��ʼ���� SysWOW64 DLL
	echo ��¼�ļ� DACL ״̬...
	icacls %windir%\SysWOW64\Windows.ApplicationModel.Store.dll /save %windir%\SysWOW64\Windows.ApplicationModel.Store.dll.temp
	echo ��ȡ�ļ�������...
	takeown /a /f %windir%\SysWOW64\Windows.ApplicationModel.Store.dll
	echo ��ȡ�ļ�Ȩ��...
	icacls %windir%\SysWOW64\Windows.ApplicationModel.Store.dll /grant Administrators:F
	if exist %windir%\SysWOW64\Windows.ApplicationModel.Store.dll.backup (
		echo ɾ���滻�� DLL...
		del /f %windir%\SysWOW64\Windows.ApplicationModel.Store.dll
		echo �ָ����� DLL...
		rename %windir%\SysWOW64\Windows.ApplicationModel.Store.dll.backup Windows.ApplicationModel.Store.dll
	) else (
		echo [31m### SysWOW64 DLL ���ݲ�����[0m
	)
	echo �ָ��ļ� DACL ״̬...
	icacls %windir%\SysWOW64 /restore %windir%\SysWOW64\Windows.ApplicationModel.Store.dll.temp && del /f %windir%\SysWOW64\Windows.ApplicationModel.Store.dll.temp
) else (
	echo ��ʼ���� System32 DLL
	echo ��¼�ļ� DACL ״̬...
	icacls %windir%\System32\Windows.ApplicationModel.Store.dll /save %windir%\System32\Windows.ApplicationModel.Store.dll.temp
	echo ��ȡ�ļ�������...
	takeown /a /f %windir%\System32\Windows.ApplicationModel.Store.dll
	echo ��ȡ�ļ�Ȩ��...
	icacls %windir%\System32\Windows.ApplicationModel.Store.dll /grant Administrators:F
	if exist %windir%\System32\Windows.ApplicationModel.Store.dll.backup (
		echo ɾ���滻�� DLL...
		del /f %windir%\System32\Windows.ApplicationModel.Store.dll
		echo �ָ����� DLL...
		rename %windir%\System32\Windows.ApplicationModel.Store.dll.backup Windows.ApplicationModel.Store.dll
	)
	echo �ָ��ļ� DACL ״̬...
	icacls %windir%\System32 /restore %windir%\System32\Windows.ApplicationModel.Store.dll.temp && del /f %windir%\System32\Windows.ApplicationModel.Store.dll.temp
)
echo [32m### Minecraft for Windows ��ȡ���������ָ�ԭ����
goto Started

::ȡ����������B - ���ע�����������
:bOff
echo ���ע�����...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ClipSVC\Parameters" /v ServiceDll /t REG_EXPAND_SZ /d "%SystemRoot%\System32\ClipSVC.dll" /f
echo ���� ClipSVC ����...
net	start ClipSVC
if %errorlevel%==2 (echo [31m### ClipSVC ��������ʧ�ܣ�level2 ��������Ϊ���񱾾���������) else if ERRORLEVEL 1 (echo [31m### ClipSVC ��������ʧ�ܣ�level%serviceError%��)
echo [32m### Minecraft for Windows ��ȡ���������ָ�ԭ����
goto Started

:Help
echo.
echo [36m******������Ϣ���������
echo bat �ű��������ܳ��� jiecs_23 Jiecs
echo ������Ϣ��������ӣ�https://www.jiecs.top/archives/764
echo ��1��������ҳ��
echo ��2����������򿪰����ĵ�����
choice /c 12 /n /m "����Ҫִ�еĲ�����"
if ERRORLEVEL 2 start https://www.jiecs.top/archives/764
goto Started