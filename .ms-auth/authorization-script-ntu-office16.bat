::@echo off
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\16.0\Common\InstallRoot" /v "Path"
if errorlevel 1 (
    call:Win64
)

FOR /F "tokens=2* delims=	 " %%A IN ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\16.0\Common\InstallRoot" /v "Path"') DO SET officepath=%%B
call:Auth "%officepath%ospp.vbs"
exit


:Win64
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\16.0\Common\InstallRoot" /v "Path"
if errorlevel 1 (
    cls
    echo Office 2016 is not installed
    pause
    exit
)

FOR /F "tokens=2* delims=	 " %%A IN ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\16.0\Common\InstallRoot" /v "Path"') DO SET officepath=%%B
call:Auth "%officepath%ospp.vbs"
exit


:Auth
cls

cscript %1 /sethst:140.112.8.166
cscript %1 /act
cscript %1 /dstatus
pause
::exit
