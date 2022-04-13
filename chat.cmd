:: ######################################################
:: VERSION 0.1.210405a - Jan 2021
:: SCRIPT: Verify
:: CREATION DATE: 2015-01-16
:: LAST MODIFIED: 2021-04-05
:: AUTHOR: Mark SOUTHBY
:: EMAIL: mark@southby.ca
:: ######################################################
:: #### Modified Batch Chat app from internet. 
:: #### Can be used and modified with persmission.
:: #### Added time and date, and ability to keep chat log after screen clearing, updated paths
:: #### Customized for CMPFOR 21-02
@echo off
::set /p user=Username:
title Chat Input
color 1f
mode con:cols=45 lines=3
set count=1

if "%1"=="/textbox" goto textbox
title Chat Input
color 1f

mode con:cols=45 lines=3
echo %date% %time%:  **> chat.live
start %~s0 /textbox
::if not exist u: net use u: \\172.31.180.15\
:: !!!!!!!!!!!!!!SET PATH TO A NETWORK SHARE THAT EVERYONE JOINING THE CHAT CAN SEE!!!!!!!!!!!!!!!!!!!
set path=U:\CMPFOR_STUDENTS\SOUTHBY,Mark\CLI_ChatRoom
U:
CD %PATH%
echo %date% %time%:  ** Chatroom started >> chatlog.txt
set /p user=Username:
::echo %date% %time%:  ** %user% has joined the conversation >> %path%\chatlog.txt
echo %date% %time%:  ** %user% has joined the conversation >> chatlog.txt
:start
cls

echo ** CLS=clear Text and Exit=Exit App **
echo.
set /p chat=%user% say's:

if /i "%chat%"=="cls" goto settings
if /i "%chat%"=="exit" goto settings
if /i "%lastchat%"=="%chat%" goto settings

::echo %date% %time% #%user%: %chat% >> %path%\chatlog.txt
echo %date% %time% #%user%: %chat% >> chatlog.txt
set lastchat=%chat%
goto start

:settings
if /i "%chat%"=="CLS" (
::move %path%\chatlog.txt %path%\chatlog%count%.txt
move chatlog.txt chatlog%count%.txt
set /a count=%count%+1
:: echo %date% %time%: ** Room has been cleared by %user% > %path%\chatlog.txt
echo %date% %time%: ** Room has been cleared by %user% > chatlog.txt
)
if /i "%chat%"=="exit" (
if exist chat.live del chat.live
::echo %date% %time%: ** %user% has left the conversation >> %path%\chatlog.txt
echo %date% %time%: ** %user% has left the conversation >> chatlog.txt
goto exit
)

goto start


:textbox
title Display Box
mode con:cols=45 lines=25
color 0a
::if not exist u: net use u: \\172.31.180.15\
cls
:startbox
pushd U:\CMPFOR_STUDENTS\SOUTHBY,Mark\CLI_ChatRoom\
type chatlog.txt
ping localhost -n 5 >nul
cls
popd
if not exist chat.live goto exit
goto startbox

:exit
::net use l: /delete
exit
