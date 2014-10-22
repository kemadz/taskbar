@ECHO OFF
SET "WDKBASEDIR=C:\WinDDK\7600.16385.1"
SET "NTMAKEENV=%WDKBASEDIR%\bin"
SET "PATH=%WDKBASEDIR%\bin\x86;%WDKBASEDIR%\bin\x86\x86;%PATH%"
SET "INCLUDE=.\include;%WDKBASEDIR%\inc\api;%WDKBASEDIR%\inc\api\crt\stl70;%WDKBASEDIR%\inc\crt;%WDKBASEDIR%\inc\ddk"
SET "LIB=.\lib;%WDKBASEDIR%\lib\crt\i386;%WDKBASEDIR%\lib\win7\i386"

IF EXIST dakad.exe DEL /Q /F dakad.exe
IF EXIST build RMDIR /Q /S build
MD build
cl.exe /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_UNICODE" /D "UNICODE" /nologo /MD /W3 /EHsc /O2 /c /Fo"build/" src\taskbar.cpp
rc.exe /l 0x409 /d "NDEBUG" /fo"build\taskbar.res" src\taskbar.rc >NUL
link.exe build\taskbar.obj build\taskbar.res psapi.lib kernel32.lib user32.lib msvcrt_winxp.obj /NOLOGO /RELEASE /SUBSYSTEM:WINDOWS /MACHINE:X86 /MERGE:.rdata=.text /OPT:REF /OPT:ICF /OUT:"dakad.exe"
