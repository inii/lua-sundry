CHCP 65001
@echo off

cd /d %~dp0

echo %1
start libs/lua.exe src/cloneTemplate.lua %1

