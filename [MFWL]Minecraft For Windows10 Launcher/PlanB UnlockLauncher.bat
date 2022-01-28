@echo off
cd /d "%~dp0"
::Æô¶¯ËµÃ÷
title MFWL
echo [36m****** MINECRAFT FOR WINDOWS UNLOCK
echo ¸Ã½Å±¾½«×Ô¶¯½âËø¡¢´ò¿ª Minecraft for Windows£¨UWP£©
echo ÇëÈ·±£ÄúÒÑ¾­°²×°ÁË Minecraft for Windows£¨¿ÉÒÔÊÇÊÔÓÃ°æ£©
echo Çë²»ÒªÔÚÓÎÏ·ÔËĞĞ¹ı³ÌÖĞ¹Ø±Õ±¾½Å±¾£¬ÓÎÏ·¹Ø±Õºó±¾½Å±¾½«×Ô¶¯È¡Ïû½âËø²¢ÍË³ö
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

::½âËø
:Unlock
echo.
echo [0m### ¿ªÊ¼½âËø Minecraft for Windows
echo Ìí¼Ó×¢²á±íÏî...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ClipSVC\Parameters" /v ServiceDll /t REG_EXPAND_SZ /d "%SystemRoot%\System32\ClipSVC.dlla" /f
echo Í£Ö¹ ClipSVC ·şÎñ...
net	stop ClipSVC
if %errorlevel%==2 (echo [31m### ClipSVC ·şÎñÍ£Ö¹Ê§°Ü£¨level2 ¿ÉÄÜÊÇÒòÎª Minecraft for Windows ±¾¾ÍÒÑ½âËø£©) else if ERRORLEVEL 1 (echo [31m### ClipSVC ·şÎñÍ£Ö¹Ê§°Ü£¨level%errorlevel%£©)
echo [32m### ³É¹¦£¡Minecraft for Windows10 ÒÑ½âËø[0m
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

::³õÊ¼½áÊø7´Î RuntimeBroker.exe ½ø³Ì
:Loop
for /f "tokens=3" %%i in ('tasklist /nh /apps /fi "IMAGENAME eq RuntimeBroker.exe" ^| find "Microsoft.MinecraftUWP"') do @taskkill /pid %%i /f
if not ERRORLEVEL 1 (
	echo ÒÑ½áÊøµÚ%num%´Î RuntimeBroker.exe ½ø³Ì...
	if %num% GEQ 6 goto Scan
	set /a num+=1
)
goto Loop

::Ã¿10Ãë¼ì²âÒ»´ÎMinecraft½ø³Ì²¢½áÊø RuntimeBroker.exe ½ø³Ì
:Scan
timeout /nobreak /t 10
tasklist|find /i "Minecraft.Windows.exe"
if ERRORLEVEL 1 goto Off
::taskkill /im RuntimeBroker.exe /f && echo ### ÒÑ½áÊø RuntimeBroker.exe ½ø³Ì
echo ### Minecraft for Windows10 ÔËĞĞÖĞ
goto Scan

:Off
echo ### Minecraft for Windows10 ÒÑÍË³ö
echo ### ÕıÔÚÈ¡Ïû½âËø Minecraft for Windows£¨»Ö¸´Ô­Ñù£©
echo Ìí¼Ó×¢²á±íÏî...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ClipSVC\Parameters" /v ServiceDll /t REG_EXPAND_SZ /d "%SystemRoot%\System32\ClipSVC.dll" /f
echo Æô¶¯ ClipSVC ·şÎñ...
net	start ClipSVC
if %errorlevel%==2 (echo [31m### ClipSVC ·şÎñÆô¶¯Ê§°Ü£¨level2 ¿ÉÄÜÊÇÒòÎª Minecraft for Windows ±¾¾ÍÎ´½âËø£©) else if ERRORLEVEL 1 (echo [31m### ClipSVC ·şÎñÆô¶¯Ê§°Ü£¨level%serviceError%£©)
echo [32m### ³É¹¦£¡Minecraft for Windows ÒÑÈ¡Ïû½âËø£¨»Ö¸´Ô­Ñù£©[0m
timeout /t 3
exit