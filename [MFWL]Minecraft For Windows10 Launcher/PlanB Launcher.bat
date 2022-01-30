@echo off
cd /d "%~dp0"
::Æô¶¯ËµÃ÷
title MFWL
echo [36m****** MINECRAFT FOR WINDOWS MINECRAFT FOR WINDOWS PLAN B LAUNCHER
echo ¸Ã½Å±¾½«×Ô¶¯´ò¿ª Minecraft for Windows10 ²¢½áÊø RuntimeBroker.exe ½ø³Ì 
echo ÇëÈ·±£ÄúÒÑ¾­°²×°ÁË Minecraft for Windows£¨¿ÉÒÔÊÇÊÔÓÃ°æ£©
echo ×îºÃÈ·±£ÏµÍ³²»ÊÇ¾«¼òÓÅ»¯°æÇÒÏµÍ³°æ±¾´óÓÚµÈÓÚ Windows10 1909£¨19H2/KB5004926/18362.446£©
echo Ïà¹Ø·½·¨Ô­ÀíÀ´×ÔÍøÂç£¬±¾½Å±¾ÓÉ jiecs_23 ÖÆ×÷
::¼ì²â»·¾³
echo.
echo [0mµ±Ç°ÔËÐÐÂ·¾¶£º%CD%
echo [0m¼ì²é Minecraft for Windows ×´Ì¬...
tasklist |find /i "Minecraft.Windows.exe"
if ERRORLEVEL 1 goto mcOK
echo [36m******´íÎó£¡Minecraft for Windows10 ÕýÔÚÔËÐÐ£¬²»ÄÜÍ¬Ê±ÔËÐÐ¶à¸öÊµÀý
echo ¡¾1¡¿Ç¿ÖÆ¹Ø±Õ Minecraft for Windows10 ²¢¼ÌÐø
echo ¡¾2¡¿Ìø¹ý¼ì²â×´Ì¬²¢¼ÌÐø
choice /c 12 /n /m "ÄãÏëÒªÖ´ÐÐµÄ²Ù×÷£º"
if ERRORLEVEL 2 goto Unlock
if ERRORLEVEL 1 (
	echo [0m
	taskkill /im Minecraft.Windows.exe /f
	timeout /nobreak /t 3
	goto Unlock
)
:mcOK

::Æô¶¯Minecraft
echo ### ³¢ÊÔÆô¶¯ Minecraft for Windows
start Minecraft:
timeout /nobreak /t 3
set num=1
tasklist|find /i "Minecraft.Windows.exe"
if not ERRORLEVEL 1 (
	echo [32m### Minecraft for Windows10 ÒÑ³É¹¦Æô¶¯[0m
	goto Loop
)
echo [36m******´íÎó£¡Minecraft for Windows10 Ó¦µ±Æô¶¯£¬µ«ÒòÎ´ÖªÔ­ÒòÎ´Æô¶¯
echo ÇëÈ·±£ÄúÒÑ¾­°²×°ÁË Minecraft for Windows£¨¿ÉÒÔÊÇÊÔÓÃ°æ£©
echo ¡¾1¡¿ÖØÐÂ³¢ÊÔÆô¶¯ Minecraft for Windows10 ²¢²»ÔÙ¼ì²âÆä×´Ì¬
echo ¡¾2¡¿Ìø¹ý¼ì²â×´Ì¬²¢¼ÌÐø
choice /c 12 /n /m "ÄãÏëÒªÖ´ÐÐµÄ²Ù×÷£º"
if ERRORLEVEL 2 goto Loop
if ERRORLEVEL 1 (
	call Minecraft.lnk
	timeout /nobreak /t 3
	echo [0m
	goto Loop
)

::Ñ­»·½áÊø RuntimeBroker.exe ½ø³Ì
:Loop
tasklist|find "Minecraft.Windows.exe" >nul || exit
for /f "tokens=3" %%i in ('tasklist /nh /apps /fi "IMAGENAME eq RuntimeBroker.exe"^|find "Microsoft.MinecraftUWP"') do @taskkill /pid %%i /f
goto Loop