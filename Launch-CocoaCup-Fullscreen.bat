@echo off
title COCOACUP Fullscreen Launcher
echo ========================================================
echo   Launching COCOACUP in True Edge-to-Edge Fullscreen...
echo ========================================================

set "CHROME_PATH=C:\Program Files\Google\Chrome\Application\chrome.exe"
set "EDGE_PATH=C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
set "TARGET_URL=https://cocoa-cup.vercel.app"

if exist "%CHROME_PATH%" (
    start "" "%CHROME_PATH%" --app="%TARGET_URL%" --start-fullscreen
) else if exist "%EDGE_PATH%" (
    start "" "%EDGE_PATH%" --app="%TARGET_URL%" --start-fullscreen
) else (
    start "" "%TARGET_URL%"
)
