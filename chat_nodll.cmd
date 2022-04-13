title %username%"s Input
color 1f
mode con:cols=45 lines=3
set DLL=0

@echo off
if "%1"=="/textbox" goto textbox
title %username%'s Input
color 1f

mode con:cols=45 lines=3
::echo. > chat.dll
set DDL=1
start %~s0 /textbox
if not exist l: net use l: \\tatfor063-cw\PUB
set path=l:\
echo ** %username% has joined the conversation >> %path%\chatlog.txt
:start
cls

echo ** CLS=clear Text and Exit=Exit App **
echo.
set /p chat=%username% say's:

if /i "%chat%"=="cls" goto settings
if /i "%chat%"=="exit" goto settings
if /i "%lastchat%"=="%chat%" goto settings

echo %username%: %chat% >> %path%\chatlog.txt
set lastchat=%chat%
goto start

:settings
if /i "%chat%"=="CLS" (
echo ** Room has been cleared by %username% > %path%\chatlog.txt
)
if /i "%chat%"=="exit" (
::if exist chat.dll del chat.dll
if /i %DLL%==1 set DLL=0
echo ** %username% has left the conversation >> %path%\chatlog.txt
goto exit
)

goto start


:textbox
title Display Box
mode con:cols=45 lines=25
color 0a
if not exist l: net use l: \\tatfor063-cw\PUB
cls
:startbox
pushd l:\
type chatlog.txt
ping localhost -n 5 >nul
cls
popd
::if not exist chat.dll goto exit
if /i %DLL%==0 goto exit
goto startbox

:exit
net use l: /delete
exit
