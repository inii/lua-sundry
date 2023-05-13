CHCP 65001
@echo off

cd /d %~dp0
echo %cd%
start libs/lua.exe src/main.lua

@REM echo . >> "aaaaaaaaaaaaaaaa.txt"
