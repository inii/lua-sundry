CHCP 65001
@echo off

set /p driName="输入模块目录名(input module dir name: eg.activityModule)"
echo %driName%

set /p fileName="输入文件名(input file name: eg. Act12284Module | Act1002Panel | Act1002Cell)"  
echo %fileName%

%~dp0\libs\lua.exe src\newFile.lua %driName% %fileName%

pause