@echo off
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
tasklist |find /i "Minecraft.Windows.exe"
if ERRORLEVEL 1 goto mcOK
echo [36m******����Minecraft for Windows10 �������У��������������в���
echo ��1��ǿ�ƹر� Minecraft for Windows10 ������
echo ��2���������״̬������
echo ��3��������Ϣ���������
choice /c 123 /n /m "����Ҫִ�еĲ�����"
if %errorlevel%==3 goto Help
if %errorlevel%==2 goto Started
if %errorlevel%==1 (
	echo [0m
	taskkill /im Minecraft.Windows.exe /f
	timeout /nobreak /t 3
	goto Started
)
:mcOK

::��ȡ�û�����
:Started
echo [0m
sc query |find /i "ClipSVC" 
if ERRORLEVEL 1 (echo [36m### ClipSVC ������ֹͣ�����ܴ��ڷ��� B ���ѽ���״̬��) else (echo ClipSVC ����������)
if %PROCESSOR_ARCHITECTURE:~-2%==64 (
	if exist %windir%\System32\Windows.ApplicationModel.Store.dll.backup if exist %windir%\SysWOW64\Windows.ApplicationModel.Store.dll.backup echo [36m### ���� A �����ļ�ȫ�����ڣ����ܴ��ڷ��� A ���ѽ���״̬��
) else (
	if exist %windir%\System32\Windows.ApplicationModel.Store.dll.backup echo [36m### ���� A �����ļ�ȫ�����ڣ����ܴ��ڷ��� A ���ѽ���״̬��
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
	echo ����ļ�ռ��״̬...
	taskkill /im RuntimeBroker.exe /f
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
	echo ����ļ�ռ��״̬...
	taskkill /im RuntimeBroker.exe /f
	echo ����ԭ DLL...
	rename %windir%\System32\Windows.ApplicationModel.Store.dll Windows.ApplicationModel.Store.dll.backup
	echo �滻�� DLL...
	copy /y .\aRes\x86\System32\Windows.ApplicationModel.Store.dll %windir%\System32\Windows.ApplicationModel.Store.dll
	echo �ָ��ļ� DACL ״̬...
	icacls %windir%\System32 /restore %windir%\System32\Windows.ApplicationModel.Store.dll.temp && del /f %windir%\System32\Windows.ApplicationModel.Store.dll.temp
)
echo [32m### �ɹ���Minecraft for Windows10 �ѽ���
goto Started

::��������B - ���ע���ֹͣ����
:bOn
echo [0m���ע�����...
regedit /s .\bRes\Minecraft_ON.reg
echo ֹͣ ClipSVC ����...
net	stop ClipSVC
if %errorlevel%==2 (echo [31m### ClipSVC ����ֹͣʧ�ܣ�level2 ��������Ϊ Minecraft for Windows �����ѽ�����) else if ERRORLEVEL 1 (echo [31m### ClipSVC ����ֹͣʧ�ܣ�level%errorlevel%��)
echo [32m### �ɹ���Minecraft for Windows10 �ѽ���
goto Started


::�����ʺϵ�ȡ����������
:analyticsOff
echo [0m### ��ʼ�����ʺϵ�ȡ����������
set score=0
for /f "tokens=4-7 delims=[.] " %%i in ('ver') do @(if %%i==Version (set ver=%%j.%%k.%%l) else (set ver=%%i.%%j.%%k))
echo ��ǰϵͳ�汾��%ver%
if %ver% GEQ 10.0.18362.446 (set /a score+=1) else (set /a score-=1)
sc query |find /i "ClipSVC" 
if ERRORLEVEL 1 (
	set /a score-=1
	echo ClipSVC ������ֹͣ
) else (
	set /a score+=1
	echo ClipSVC ����������
)
set bit=%PROCESSOR_ARCHITECTURE:~-2%
echo [0m��ǰϵͳ�ܹ���x%bit%
if %bit%==64 (
	if exist %windir%\System32\Windows.ApplicationModel.Store.dll.backup (
		if exist %windir%\SysWOW64\Windows.ApplicationModel.Store.dll.backup (
			set /a score+=1
			set hasBackup=1
			echo ���� A �����ļ�ȫ������
		) else (
			set /a score-=1
			set hasBackup=0
		)
	) else (
		set /a score-=1
		set hasBackup=0
	)
) else (
	if exist %windir%\System32\Windows.ApplicationModel.Store.dll.backup (
		set /a score+=1
		set hasBackup=1
		echo ���� A �����ļ�ȫ������
	) else (
		set /a score-=1
		set hasBackup=0
	)
)
echo.
if %hasBackup%==1 (
	echo [36m### ����ʱ�÷��� A ȡ������Ҳ�����÷��� A������ʱ�÷��� B ȡ������Ҳ�����÷��� B������ᵼ��ϵͳ�ļ��𻵣�
	echo ### ʹ�÷��� A ����ʱ��Ҫ��ʱ�ر�ȫ�� Xbox��Microsoft Store ��ز��ֽ��̣���ע�ⲻҪ��ʧ��������
	if %score% GTR 0 (echo ### ��ǰϵͳ��������ʹ�÷��� A��������%score%��) else (echo ### ��ǰϵͳ��������ʹ�÷��� B��������%score%��)
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
) else (
	echo [36m### δ��⵽�����ķ��� A �����ļ�
	echo ### ��ǰϵͳ��������ʹ�÷��� B
	echo ��b��ʹ�÷��� B ȡ�����������÷���
	choice /c b /n /m "����Ҫִ�еĲ�����"
	if ERRORLEVEL 1 (
		echo [0m### ��ʼȡ������ Minecraft for Windows������B��
		goto bOff
	)
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
	echo ����ļ�ռ��״̬...
	taskkill /im RuntimeBroker.exe /f
	echo ɾ���滻�� DLL...
	del /f %windir%\System32\Windows.ApplicationModel.Store.dll
	echo �ָ����� DLL...
	rename %windir%\System32\Windows.ApplicationModel.Store.dll.backup Windows.ApplicationModel.Store.dll
	echo �ָ��ļ� DACL ״̬...
	icacls %windir%\System32 /restore %windir%\System32\Windows.ApplicationModel.Store.dll.temp && del /f %windir%\System32\Windows.ApplicationModel.Store.dll.temp
	echo ��ʼ���� SysWOW64 DLL
	echo ��¼�ļ� DACL ״̬...
	icacls %windir%\SysWOW64\Windows.ApplicationModel.Store.dll /save %windir%\SysWOW64\Windows.ApplicationModel.Store.dll.temp
	echo ��ȡ�ļ�������...
	takeown /a /f %windir%\SysWOW64\Windows.ApplicationModel.Store.dll
	echo ��ȡ�ļ�Ȩ��...
	icacls %windir%\SysWOW64\Windows.ApplicationModel.Store.dll /grant Administrators:F
	echo ɾ���滻�� DLL...
	del /f %windir%\SysWOW64\Windows.ApplicationModel.Store.dll
	echo �ָ����� DLL...
	rename %windir%\SysWOW64\Windows.ApplicationModel.Store.dll.backup Windows.ApplicationModel.Store.dll
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
	echo ����ļ�ռ��״̬...
	taskkill /im RuntimeBroker.exe /f
	echo ɾ���滻�� DLL...
	del /f %windir%\System32\Windows.ApplicationModel.Store.dll
	echo �ָ����� DLL...
	rename %windir%\System32\Windows.ApplicationModel.Store.dll.backup Windows.ApplicationModel.Store.dll
	echo �ָ��ļ� DACL ״̬...
	icacls %windir%\System32 /restore %windir%\System32\Windows.ApplicationModel.Store.dll.temp && del /f %windir%\System32\Windows.ApplicationModel.Store.dll.temp
)
echo [32m### �ɹ���Minecraft for Windows ��ȡ���������ָ�ԭ����
goto Started

::ȡ����������B - ���ע�����������
:bOff
echo ���ע�����...
regedit /s .\bRes\Minecraft_OFF.reg
echo ���� ClipSVC ����...
net	start ClipSVC
if %errorlevel%==2 (echo [31m### ClipSVC ��������ʧ�ܣ�level2 ��������Ϊ Minecraft for Windows ����δ������) else if ERRORLEVEL 1 (echo [31m### ClipSVC ��������ʧ�ܣ�level%serviceError%��)
echo [32m### �ɹ���Minecraft for Windows ��ȡ���������ָ�ԭ����
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