@echo off
title sysinfo.bat
systeminfo
pause
systeminfo /fo csv > sysinfo.csv
echo Saved system info in .csv format to %~dp0!
echo ----------------------------------------------------------------------------------------------
echo You should open this in Excel for easier reading! Looking at this with notepad is painful.
echo ----------------------------------------------------------------------------------------------
echo [91mDO NOT SHARE THE "Network Card(s)" SECTION WITH ANYBODY. IT CONTAINS YOUR IP ADDRESS!![0m
echo ----------------------------------------------------------------------------------------------
pause