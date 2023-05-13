CHCP 65001
@echo off

cd /d %~dp0
start libs/lua.exe src/main.lua

