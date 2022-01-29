@echo off
setlocal DisableDelayedExpansion
cd /d "%~dp0"
::Æô¶¯ËµÃ÷
title MFWL
echo [36m****** MINECRAFT FOR WINDOWS UNLOCK
echo ¸Ã½Å±¾¿ÉÒÔ×Ô¶¯Ñ¡Ôñ·½°¸²¢½âËø Minecraft for Windows£¨UWP£©
echo ÇëÈ·±£ÄúÒÑ¾­°²×°ÁË Minecraft for Windows£¨¿ÉÒÔÊÇÊÔÓÃ°æ£©
echo ×îºÃÈ·±£ÏµÍ³²»ÊÇ¾«¼òÓÅ»¯°æÇÒÏµÍ³°æ±¾´óÓÚµÈÓÚ Windows10 1909£¨19H2/KB5004926/18362.446£©
echo ½âËøÊ±ÓÃ·½°¸ A È¡Ïû½âËøÒ²±ØĞëÓÃ·½°¸ A£»½âËøÊ±ÓÃ·½°¸ B È¡Ïû½âËøÒ²±ØĞëÓÃ·½°¸ B¡£·½°¸ A ºÍ B Ö»ĞèÊ¹ÓÃÒ»¸ö£¬²»¿ÉÍ¬Ê±Ê¹ÓÃ¡£·ñÔò»áµ¼ÖÂÏµÍ³ÎÄ¼şËğ»µ£¡
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
tasklist|find "Minecraft.Windows.exe" || goto mcOK
echo [36m******´íÎó£¡Minecraft for Windows10 ÕıÔÚÔËĞĞ£¬²»ÄÜÔÚÆäÔËĞĞÖĞ²Ù×÷
echo ¡¾1¡¿Ç¿ÖÆ¹Ø±Õ Minecraft for Windows10 ²¢¼ÌĞø
echo ¡¾2¡¿Ìø¹ı¼ì²â×´Ì¬²¢¼ÌĞø
echo ¡¾3¡¿°ïÖúĞÅÏ¢ÓëÏà¹ØÁ´½Ó
choice /c 123 /n /m "ÄãÏëÒªÖ´ĞĞµÄ²Ù×÷£º"
if %errorlevel%==3 goto Help
if %errorlevel%==2 goto Started
if %errorlevel%==1 (
	echo [0m
	taskkill /im Minecraft.Windows.exe /f
	timeout /nobreak /t 3
	goto Started
)
:mcOK

::»ñÈ¡ÓÃ»§²Ù×÷
:Started
echo.
for /f "tokens=3" %%i in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ClipSVC\Parameters" /v "ServiceDll"') do (
	if not %%i==C:\WINDOWS\System32\ClipSVC.dll (echo [36m### ´¦ÓÚ·½°¸ B µÄÒÑ½âËø×´Ì¬[0m)
)
if %PROCESSOR_ARCHITECTURE:~-2%==64 (set n=0) else (set n=1)
for  /f %%i in ('certutil -hashfile %windir%\System32\Windows.ApplicationModel.Store.dll') do (
	if %%i==a54a840771c33f2bf220a7af36d6a2747d6a7955 set /a n+=1
)
for  /f %%i in ('certutil -hashfile %windir%\SysWOW64\Windows.ApplicationModel.Store.dll') do (
	if %%i==1dc4ec7631f20d54dd8c1951df492719234f6f27 set /a n+=1
)
if %n% LSS 2 echo [36m### ´¦ÓÚ·½°¸ A µÄÒÑ½âËø×´Ì¬
echo [36m******Ö´ĞĞ²Ù×÷
echo ¡¾1¡¿Ñ¡Ôñ·½°¸½âËø Minecraft for Windows
echo ¡¾2¡¿Ñ¡Ôñ·½°¸È¡Ïû½âËø Minecraft for Windows£¨»Ö¸´Ô­Ñù£©
echo ¡¾3¡¿°ïÖúĞÅÏ¢ÓëÏà¹ØÁ´½Ó
choice /c 123 /n /m "ÄãÏëÒªÖ´ĞĞµÄ²Ù×÷£º"
if ERRORLEVEL 3 goto Help
if ERRORLEVEL 2 goto analyticsOff
if ERRORLEVEL 1 goto analyticsOn


::·ÖÎöÊÊºÏµÄ½âËø·½°¸
:analyticsOn
echo [0m### ¿ªÊ¼·ÖÎöÊÊºÏµÄ½âËø·½°¸
for /f "tokens=4-7 delims=[.] " %%i in ('ver') do @(if %%i==Version (set ver=%%j.%%k.%%l) else (set ver=%%i.%%j.%%k))
echo µ±Ç°ÏµÍ³°æ±¾£º%ver%
echo [36m### ½âËøÊ±ÓÃ·½°¸ A È¡Ïû½âËøÒ²±ØĞëÓÃ·½°¸ A£»½âËøÊ±ÓÃ·½°¸ B È¡Ïû½âËøÒ²±ØĞëÓÃ·½°¸ B¡£·½°¸ A ºÍ B Ö»ĞèÊ¹ÓÃÒ»¸ö£¬²»¿ÉÍ¬Ê±Ê¹ÓÃ¡£·ñÔò»áµ¼ÖÂÏµÍ³ÎÄ¼şËğ»µ£¡
echo ### Ê¹ÓÃ·½°¸ A Çë×îºÃÈ·±£ÄúµÄÏµÍ³°æ±¾´óÓÚµÈÓÚ Windows10 1909£¨19H2/KB5004926/18362.446£©
echo ### Ê¹ÓÃ·½°¸ A ²Ù×÷Ê±ĞèÒªÔİÊ±¹Ø±ÕÈ«²¿ Xbox¡¢Microsoft Store Ïà¹Ø²¿·Ö½ø³Ì£¬Çë×¢Òâ²»Òª¶ªÊ§¸öÈËÊı¾İ
echo ### Ê¹ÓÃ·½°¸ B Çë×îºÃÈ·±£ÄúµÄÏµÍ³²»ÊÇ¾«¼òÓÅ»¯°æ£¬·ñÔò¿ÉÄÜ»áµ¼ÖÂÏµÍ³À¶ÆÁµÈ¹ÊÕÏ
echo ### Ê¹ÓÃ·½°¸ B »áµ¼ÖÂ Microsoft Store ÎŞ·¨ÏÂÔØÓ¦ÓÃ£¬Çë²Î¿¼°ïÖúĞÅÏ¢ÓëÏà¹ØÁ´½Ó
echo ### Ê¹ÓÃ·½°¸ B Æô¶¯ Minecraft ĞèÒªÊÖ¶¯½áÊø RuntimeBroker.exe ½ø³Ì£¬»òÊ¹ÓÃ PlanB Launcher.bat Æô¶¯
echo ### ¿ÉÒÔÊ¹ÓÃ PlanB UnlockLauncher.bat Æô¶¯ Minecraft£¬×Ô¶¯Ê¹ÓÃ·½°¸ B ½âËø²¢´¦ÀíÏà¹ØÎÊÌâ
if %ver% GEQ 10.0.18362.446 (
	echo ### µ±Ç°ÏµÍ³»·¾³½¨ÒéÊ¹ÓÃ·½°¸ A
) else (
	echo ### ÏµÍ³°æ±¾µÍÓÚ Windows10 1909£¨19H2/KB5004926/18362.446£©
	echo ### µ±Ç°ÏµÍ³»·¾³½¨ÒéÊ¹ÓÃ·½°¸ B
)
echo ¡¾a¡¿Ê¹ÓÃ·½°¸ A ½âËø£¨Ìæ»» DLL£©
echo ¡¾b¡¿Ê¹ÓÃ·½°¸ B ½âËø£¨½ûÓÃ·şÎñ£©
choice /c ab /n /m "ÄãÏëÒªÖ´ĞĞµÄ²Ù×÷£º"
if ERRORLEVEL 2 (
	echo [0m### ¿ªÊ¼½âËø Minecraft for Windows£¨·½°¸B£©
	goto bOn
)
if ERRORLEVEL 1 (
	echo [0m### ¿ªÊ¼½âËø Minecraft for Windows£¨·½°¸A£©
	goto aOn
)

::½âËø·½°¸A - Ìæ»» DLL
:aOn
set bit=%PROCESSOR_ARCHITECTURE:~-2%
echo µ±Ç°ÏµÍ³¼Ü¹¹£ºx%bit%
if %bit%==64 (
	echo ¿ªÊ¼´¦Àí System32 DLL
	echo ¼ÇÂ¼ÎÄ¼ş DACL ×´Ì¬...
	icacls %windir%\System32\Windows.ApplicationModel.Store.dll /save %windir%\System32\Windows.ApplicationModel.Store.dll.temp
	echo ¶áÈ¡ÎÄ¼şËùÓĞÕß...
	takeown /a /f %windir%\System32\Windows.ApplicationModel.Store.dll
	echo »ñÈ¡ÎÄ¼şÈ¨ÏŞ...
	icacls %windir%\System32\Windows.ApplicationModel.Store.dll /c /grant Administrators:F
	echo ±¸·İÔ­ DLL...
	rename %windir%\System32\Windows.ApplicationModel.Store.dll Windows.ApplicationModel.Store.dll.backup
	echo Ìæ»»ĞÂ DLL...
	copy /y .\aRes\x64\System32\Windows.ApplicationModel.Store.dll %windir%\System32\Windows.ApplicationModel.Store.dll
	echo »Ö¸´ÎÄ¼ş DACL ×´Ì¬...
	icacls %windir%\System32 /restore %windir%\System32\Windows.ApplicationModel.Store.dll.temp && del /f %windir%\System32\Windows.ApplicationModel.Store.dll.temp
	echo ¿ªÊ¼´¦Àí SysWOW64 DLL
	echo ¼ÇÂ¼ÎÄ¼ş DACL ×´Ì¬...
	icacls %windir%\SysWOW64\Windows.ApplicationModel.Store.dll /save %windir%\SysWOW64\Windows.ApplicationModel.Store.dll.temp
	echo ¶áÈ¡ÎÄ¼şËùÓĞÕß...
	takeown /a /f %windir%\SysWOW64\Windows.ApplicationModel.Store.dll
	echo »ñÈ¡ÎÄ¼şÈ¨ÏŞ...
	icacls %windir%\SysWOW64\Windows.ApplicationModel.Store.dll /c /grant Administrators:F
	echo ±¸·İÔ­ DLL...
	rename %windir%\SysWOW64\Windows.ApplicationModel.Store.dll Windows.ApplicationModel.Store.dll.backup
	echo Ìæ»»ĞÂ DLL...
	copy /y .\aRes\x64\SysWOW64\Windows.ApplicationModel.Store.dll %windir%\SysWOW64\Windows.ApplicationModel.Store.dll
	echo »Ö¸´ÎÄ¼ş DACL ×´Ì¬...
	icacls %windir%\SysWOW64 /restore %windir%\SysWOW64\Windows.ApplicationModel.Store.dll.temp && del /f %windir%\SysWOW64\Windows.ApplicationModel.Store.dll.temp
) else (
	echo ¿ªÊ¼´¦Àí System32 DLL
	echo ¼ÇÂ¼ÎÄ¼ş DACL ×´Ì¬...
	icacls %windir%\System32\Windows.ApplicationModel.Store.dll /save %windir%\System32\Windows.ApplicationModel.Store.dll.temp
	echo ¶áÈ¡ÎÄ¼şËùÓĞÕß...
	takeown /a /f %windir%\System32\Windows.ApplicationModel.Store.dll
	echo »ñÈ¡ÎÄ¼şÈ¨ÏŞ...
	icacls %windir%\System32\Windows.ApplicationModel.Store.dll /c /grant Administrators:F
	echo ±¸·İÔ­ DLL...
	rename %windir%\System32\Windows.ApplicationModel.Store.dll Windows.ApplicationModel.Store.dll.backup
	echo Ìæ»»ĞÂ DLL...
	copy /y .\aRes\x86\System32\Windows.ApplicationModel.Store.dll %windir%\System32\Windows.ApplicationModel.Store.dll
	echo »Ö¸´ÎÄ¼ş DACL ×´Ì¬...
	icacls %windir%\System32 /restore %windir%\System32\Windows.ApplicationModel.Store.dll.temp && del /f %windir%\System32\Windows.ApplicationModel.Store.dll.temp
)
echo [32m### Minecraft for Windows10 ÒÑ½âËø
goto Started

::½âËø·½°¸B - Ìí¼Ó×¢²á±í²¢Í£Ö¹·şÎñ
:bOn
echo [0mÌí¼Ó×¢²á±íÏî...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ClipSVC\Parameters" /v ServiceDll /t REG_EXPAND_SZ /d "%SystemRoot%\System32\ClipSVC.dlla" /f
echo Í£Ö¹ ClipSVC ·şÎñ...
net	stop ClipSVC
if %errorlevel%==2 (echo [31m### ClipSVC ·şÎñÍ£Ö¹Ê§°Ü£¨level2 ¿ÉÄÜÊÇÒòÎª Minecraft for Windows ±¾¾ÍÒÑ½âËø£©) else if ERRORLEVEL 1 (echo [31m### ClipSVC ·şÎñÍ£Ö¹Ê§°Ü£¨level%errorlevel%£©)
echo [32m### Minecraft for Windows10 ÒÑ½âËø
goto Started


::·ÖÎöÊÊºÏµÄÈ¡Ïû½âËø·½°¸
:analyticsOff
echo [0m### ¿ªÊ¼·ÖÎöÊÊºÏµÄÈ¡Ïû½âËø·½°¸
set score=0
for /f "tokens=4-7 delims=[.] " %%i in ('ver') do @(if %%i==Version (set ver=%%j.%%k.%%l) else (set ver=%%i.%%j.%%k))
echo µ±Ç°ÏµÍ³°æ±¾£º%ver%
if %ver% GEQ 10.0.18362.446 (set /a score+=1) else (set /a score-=1)
for /f "tokens=3" %%i in ('reg query "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ClipSVC\Parameters" /v "ServiceDll"') do (
	if %%i==C:\WINDOWS\System32\ClipSVC.dll (set /a score+=1) else (set /a score-=1)
)
if %PROCESSOR_ARCHITECTURE:~-2%==64 (set n=0) else (set n=1)
for  /f %%i in ('certutil -hashfile %windir%\System32\Windows.ApplicationModel.Store.dll') do (
	if %%i==a54a840771c33f2bf220a7af36d6a2747d6a7955 set /a n+=1
)
for  /f %%i in ('certutil -hashfile %windir%\SysWOW64\Windows.ApplicationModel.Store.dll') do (
	if %%i==641a078702f914c5a8f1df2ae2a323b7 set /a n+=1
)
if %n% LSS 2 (
	set /a score+=1
) else (
	set /a score-=1
)
echo.
echo [36m### ½âËøÊ±ÓÃ·½°¸ A È¡Ïû½âËøÒ²±ØĞëÓÃ·½°¸ A£»½âËøÊ±ÓÃ·½°¸ B È¡Ïû½âËøÒ²±ØĞëÓÃ·½°¸ B¡£·ñÔò»áµ¼ÖÂÏµÍ³ÎÄ¼şËğ»µ£¡
echo ### Ê¹ÓÃ·½°¸ A ²Ù×÷Ê±ĞèÒªÔİÊ±¹Ø±ÕÈ«²¿ Xbox¡¢Microsoft Store Ïà¹Ø²¿·Ö½ø³Ì£¬Çë×¢Òâ²»Òª¶ªÊ§¸öÈËÊı¾İ
if %score% GTR 0 (echo ### µ±Ç°ÏµÍ³»·¾³½¨ÒéÊ¹ÓÃ·½°¸ A£¨ÌØÕ÷·Ö%score%£©) else (echo ### µ±Ç°ÏµÍ³»·¾³½¨ÒéÊ¹ÓÃ·½°¸ B£¨ÌØÕ÷·Ö%score%£©)
echo ¡¾a¡¿Ê¹ÓÃ·½°¸ A È¡Ïû½âËø£¨Ìæ»» DLL£©
echo ¡¾b¡¿Ê¹ÓÃ·½°¸ B È¡Ïû½âËø£¨½ûÓÃ·şÎñ£©
choice /c ab /n /m "ÄãÏëÒªÖ´ĞĞµÄ²Ù×÷£º"
if ERRORLEVEL 2 (
	echo [0m### ¿ªÊ¼È¡Ïû½âËø Minecraft for Windows£¨·½°¸B£©
	goto bOff
)
if ERRORLEVEL 1 (
	echo [0m### ¿ªÊ¼È¡Ïû½âËø Minecraft for Windows£¨·½°¸A£©
	goto aOff
)

::È¡Ïû½âËø·½°¸A - »Ö¸´±¸·İµÄ DLL
:aOff
set bit=%PROCESSOR_ARCHITECTURE:~-2%
echo [0mµ±Ç°ÏµÍ³¼Ü¹¹£ºx%bit%
if %bit%==64 (
	echo ¿ªÊ¼´¦Àí System32 DLL
	echo ¼ÇÂ¼ÎÄ¼ş DACL ×´Ì¬...
	icacls %windir%\System32\Windows.ApplicationModel.Store.dll /save %windir%\System32\Windows.ApplicationModel.Store.dll.temp
	echo ¶áÈ¡ÎÄ¼şËùÓĞÕß...
	takeown /a /f %windir%\System32\Windows.ApplicationModel.Store.dll
	echo »ñÈ¡ÎÄ¼şÈ¨ÏŞ...
	icacls %windir%\System32\Windows.ApplicationModel.Store.dll /grant Administrators:F
	if exist %windir%\System32\Windows.ApplicationModel.Store.dll.backup (
		echo É¾³ıÌæ»»µÄ DLL...
		del /f %windir%\System32\Windows.ApplicationModel.Store.dll
		echo »Ö¸´±¸·İ DLL...
		rename %windir%\System32\Windows.ApplicationModel.Store.dll.backup Windows.ApplicationModel.Store.dll
	) else (
		echo [31m### System32 DLL ±¸·İ²»´æÔÚ[0m
	)
	echo »Ö¸´ÎÄ¼ş DACL ×´Ì¬...
	icacls %windir%\System32 /restore %windir%\System32\Windows.ApplicationModel.Store.dll.temp && del /f %windir%\System32\Windows.ApplicationModel.Store.dll.temp
	echo ¿ªÊ¼´¦Àí SysWOW64 DLL
	echo ¼ÇÂ¼ÎÄ¼ş DACL ×´Ì¬...
	icacls %windir%\SysWOW64\Windows.ApplicationModel.Store.dll /save %windir%\SysWOW64\Windows.ApplicationModel.Store.dll.temp
	echo ¶áÈ¡ÎÄ¼şËùÓĞÕß...
	takeown /a /f %windir%\SysWOW64\Windows.ApplicationModel.Store.dll
	echo »ñÈ¡ÎÄ¼şÈ¨ÏŞ...
	icacls %windir%\SysWOW64\Windows.ApplicationModel.Store.dll /grant Administrators:F
	if exist %windir%\SysWOW64\Windows.ApplicationModel.Store.dll.backup (
		echo É¾³ıÌæ»»µÄ DLL...
		del /f %windir%\SysWOW64\Windows.ApplicationModel.Store.dll
		echo »Ö¸´±¸·İ DLL...
		rename %windir%\SysWOW64\Windows.ApplicationModel.Store.dll.backup Windows.ApplicationModel.Store.dll
	) else (
		echo [31m### SysWOW64 DLL ±¸·İ²»´æÔÚ[0m
	)
	echo »Ö¸´ÎÄ¼ş DACL ×´Ì¬...
	icacls %windir%\SysWOW64 /restore %windir%\SysWOW64\Windows.ApplicationModel.Store.dll.temp && del /f %windir%\SysWOW64\Windows.ApplicationModel.Store.dll.temp
) else (
	echo ¿ªÊ¼´¦Àí System32 DLL
	echo ¼ÇÂ¼ÎÄ¼ş DACL ×´Ì¬...
	icacls %windir%\System32\Windows.ApplicationModel.Store.dll /save %windir%\System32\Windows.ApplicationModel.Store.dll.temp
	echo ¶áÈ¡ÎÄ¼şËùÓĞÕß...
	takeown /a /f %windir%\System32\Windows.ApplicationModel.Store.dll
	echo »ñÈ¡ÎÄ¼şÈ¨ÏŞ...
	icacls %windir%\System32\Windows.ApplicationModel.Store.dll /grant Administrators:F
	if exist %windir%\System32\Windows.ApplicationModel.Store.dll.backup (
		echo É¾³ıÌæ»»µÄ DLL...
		del /f %windir%\System32\Windows.ApplicationModel.Store.dll
		echo »Ö¸´±¸·İ DLL...
		rename %windir%\System32\Windows.ApplicationModel.Store.dll.backup Windows.ApplicationModel.Store.dll
	)
	echo »Ö¸´ÎÄ¼ş DACL ×´Ì¬...
	icacls %windir%\System32 /restore %windir%\System32\Windows.ApplicationModel.Store.dll.temp && del /f %windir%\System32\Windows.ApplicationModel.Store.dll.temp
)
echo [32m### Minecraft for Windows ÒÑÈ¡Ïû½âËø£¨»Ö¸´Ô­Ñù£©
goto Started

::È¡Ïû½âËø·½°¸B - Ìí¼Ó×¢²á±í²¢Æô¶¯·şÎñ
:bOff
echo Ìí¼Ó×¢²á±íÏî...
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ClipSVC\Parameters" /v ServiceDll /t REG_EXPAND_SZ /d "%SystemRoot%\System32\ClipSVC.dll" /f
echo Æô¶¯ ClipSVC ·şÎñ...
net	start ClipSVC
if %errorlevel%==2 (echo [31m### ClipSVC ·şÎñÆô¶¯Ê§°Ü£¨level2 ¿ÉÄÜÊÇÒòÎª Minecraft for Windows ±¾¾ÍÎ´½âËø£©) else if ERRORLEVEL 1 (echo [31m### ClipSVC ·şÎñÆô¶¯Ê§°Ü£¨level%serviceError%£©)
echo [32m### Minecraft for Windows ÒÑÈ¡Ïû½âËø£¨»Ö¸´Ô­Ñù£©
goto Started

:Help
echo.
echo [36m******°ïÖúĞÅÏ¢ÓëÏà¹ØÁ´½Ó
echo bat ½Å±¾ÖÆ×÷£º½Ü³öÊŞ jiecs_23 Jiecs
echo °ïÖúĞÅÏ¢ÓëÏà¹ØÁ´½Ó£ºhttps://www.jiecs.top/archives/764
echo ¡¾1¡¿·µ»ØÖ÷Ò³Ãæ
echo ¡¾2¡¿ÓÃä¯ÀÀÆ÷´ò¿ª°ïÖúÎÄµµÁ´½Ó
choice /c 12 /n /m "ÄãÏëÒªÖ´ĞĞµÄ²Ù×÷£º"
if ERRORLEVEL 2 start https://www.jiecs.top/archives/764
goto Started