@echo off
cd /d "%~dp0"
::����˵��
title MFWL
echo [36m****** MINECRAFT FOR WINDOWS UNLOCK
echo �ýű����Զ��� Minecraft for Windows10 ������ RuntimeBroker.exe ���� 
echo ��ȷ�����Ѿ���װ�� Minecraft for Windows�����������ð棩
echo ���ȷ��ϵͳ���Ǿ����Ż�����ϵͳ�汾���ڵ��� Windows10 1909��19H2/KB5004926/18362.446��
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
echo [36m******����Minecraft for Windows10 �������У�����ͬʱ���ж��ʵ��
echo ��1��ǿ�ƹر� Minecraft for Windows10 ������
echo ��2���������״̬������
choice /c 12 /n /m "����Ҫִ�еĲ�����"
if %errorlevel%==2 goto Unlock
if %errorlevel%==1 (
	echo [0m
	taskkill /im Minecraft.Windows.exe /f
	timeout /nobreak /t 3
	goto Unlock
)
:mcOK

::����Minecraft
echo ### �������� Minecraft for Windows
start Minecraft:
timeout /nobreak /t 3
set num=1
tasklist|find /i "Minecraft.Windows.exe"
if not ERRORLEVEL 1 (
	echo [32m### Minecraft for Windows10 �ѳɹ�����[0m
	goto Loop
)
echo [36m******����Minecraft for Windows10 Ӧ������������δ֪ԭ��δ����
echo ��ȷ�����Ѿ���װ�� Minecraft for Windows�����������ð棩
echo ��1�����³������� Minecraft for Windows10 �����ټ����״̬
echo ��2���������״̬������
choice /c 12 /n /m "����Ҫִ�еĲ�����"
if %errorlevel%==2 goto Loop
if %errorlevel%==1 (
	call Minecraft.lnk
	timeout /nobreak /t 3
	echo [0m
	goto Loop
)

::��ʼ����6�� RuntimeBroker.exe ����
:Loop
taskkill /im RuntimeBroker.exe /f
if not ERRORLEVEL 1 (
	echo �ѽ�����%num%�� RuntimeBroker.exe ����...
	if %num% GEQ 5 goto Ok
	set /a num+=1
)
goto Loop

:Ok
echo ### ���� RuntimeBroker.exe �����ѽ���
timeout /t 3
exit