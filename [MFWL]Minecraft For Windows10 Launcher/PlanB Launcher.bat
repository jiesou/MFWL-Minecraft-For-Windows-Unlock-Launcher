@echo off
cd /d "%~dp0"
::Æô¶¯ËµÃ÷
title MFWL
echo [36m****** MINECRAFT FOR WINDOWS UNLOCK
echo ¸Ã½Å±¾½«×Ô¶¯´ò¿ª Minecraft for Windows10 ²¢½áÊø RuntimeBroker.exe ½ø³Ì 
echo ÇëÈ·±£ÄúÒÑ¾­°²×°ÁË Minecraft for Windows£¨¿ÉÒÔÊÇÊÔÓÃ°æ£©
echo ×îºÃÈ·±£ÏµÍ³²»ÊÇ¾«¼òÓÅ»¯°æÇÒÏµÍ³°æ±¾´óÓÚµÈÓÚ Windows10 1909£¨19H2/KB5004926/18362.446£©
echo Ïà¹Ø·½·¨Ô­ÀíÀ´×ÔÍøÂç£¬±¾½Å±¾ÓÉ jiecs_23 ÖÆ×÷
::¼ì²â»·¾³
echo.
echo [0mµ±Ç°ÔËĞĞÂ·¾¶£º%CD%
echo [0m¼ì²é¹ÜÀíÔ±È¨ÏŞ...
if exist "%SystemRoot%\SysWOW64" path %path%;%windir%\SysNative;%SystemRoot%\SysWOW64;%~dp0
bcdedit >nul
if not ERRORLEVEL 1 goto uacOK
echo [31m### Î´»ñÈ¡µ½¹ÜÀíÔ±È¨ÏŞ
echo [36m### ÇëÊÚÓè¹ÜÀíÔ±È¨ÏŞ£¨UAC£©[0m
%1 start "" mshta vbscript:createobject("shell.application").shellexecute("""%~0""","::",,"runas",1)(window.close)&exit
exit /B
:uacOK
echo [0m¼ì²é Minecraft for Windows ×´Ì¬...
tasklist |find /i "Minecraft.Windows.exe"
if ERRORLEVEL 1 goto mcOK
echo [36m******´íÎó£¡Minecraft for Windows10 ÕıÔÚÔËĞĞ£¬²»ÄÜÍ¬Ê±ÔËĞĞ¶à¸öÊµÀı
echo ¡¾1¡¿Ç¿ÖÆ¹Ø±Õ Minecraft for Windows10 ²¢¼ÌĞø
echo ¡¾2¡¿Ìø¹ı¼ì²â×´Ì¬²¢¼ÌĞø
choice /c 12 /n /m "ÄãÏëÒªÖ´ĞĞµÄ²Ù×÷£º"
if %errorlevel%==2 goto Unlock
if %errorlevel%==1 (
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
echo ¡¾1¡¿ÖØĞÂ³¢ÊÔÆô¶¯ Minecraft for Windows10 ²¢²»ÔÙ¼ì²âÆä×´Ì¬
echo ¡¾2¡¿Ìø¹ı¼ì²â×´Ì¬²¢¼ÌĞø
choice /c 12 /n /m "ÄãÏëÒªÖ´ĞĞµÄ²Ù×÷£º"
if %errorlevel%==2 goto Loop
if %errorlevel%==1 (
	call Minecraft.lnk
	timeout /nobreak /t 3
	echo [0m
	goto Loop
)

::³õÊ¼½áÊø6´Î RuntimeBroker.exe ½ø³Ì
:Loop
taskkill /im RuntimeBroker.exe /f
if not ERRORLEVEL 1 (
	echo ÒÑ½áÊøµÚ%num%´Î RuntimeBroker.exe ½ø³Ì...
	if %num% GEQ 5 goto Ok
	set /a num+=1
)
goto Loop

:Ok
echo ### ËùÓĞ RuntimeBroker.exe ½ø³ÌÒÑ½áÊø
timeout /t 3
exit