@echo off
cd /d "%~dp0"
::����˵��
title MFWL
echo [36m****** MINECRAFT FOR WINDOWS MINECRAFT FOR WINDOWS PLAN B LAUNCHER
echo �ýű����Զ��� Minecraft for Windows10 ������ RuntimeBroker.exe ���� 
echo ��ȷ�����Ѿ���װ�� Minecraft for Windows�����������ð棩
echo ���ȷ��ϵͳ���Ǿ����Ż�����ϵͳ�汾���ڵ��� Windows10 1909��19H2/KB5004926/18362.446��
echo ��ط���ԭ���������磬���ű��� jiecs_23 ����
::��⻷��
echo.
echo [0m��ǰ����·����%CD%
echo [0m��� Minecraft for Windows ״̬...
tasklist |find /i "Minecraft.Windows.exe"
if ERRORLEVEL 1 goto mcOK
echo [36m******����Minecraft for Windows10 �������У�����ͬʱ���ж��ʵ��
echo ��1��ǿ�ƹر� Minecraft for Windows10 ������
echo ��2���������״̬������
choice /c 12 /n /m "����Ҫִ�еĲ�����"
if ERRORLEVEL 2 goto Unlock
if ERRORLEVEL 1 (
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
if ERRORLEVEL 2 goto Loop
if ERRORLEVEL 1 (
	call Minecraft.lnk
	timeout /nobreak /t 3
	echo [0m
	goto Loop
)

::ѭ������ RuntimeBroker.exe ����
:Loop
tasklist|find "Minecraft.Windows.exe" >nul || exit
for /f "tokens=3" %%i in ('tasklist /nh /apps /fi "IMAGENAME eq RuntimeBroker.exe"^|find "Microsoft.MinecraftUWP"') do @taskkill /pid %%i /f
goto Loop