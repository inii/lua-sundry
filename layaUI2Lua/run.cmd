CHCP 65001
@echo off

@REM set /p driName="输入模块目录名(input module dir name )"
@REM echo %driName%

@REM set /p fileName="输入文件名(input file name)"  
@REM echo %fileName%

%~dp0\libs\lua.exe main.lua %driName% %fileName%


pause