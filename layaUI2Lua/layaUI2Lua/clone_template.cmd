CHCP 65001
@echo off

cd /d %~dp0

start libs/lua.exe src/cloneTemplate.lua %1 

@REM echo %1 >> "aaaaaaaaaaaaaaaa.txt"




