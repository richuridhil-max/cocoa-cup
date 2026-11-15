@echo off
echo Starting COCOACUP in Fullscreen Mode...

set CHROME_PATH="C:\Program Files\Google\Chrome\Application\chrome.exe"
set CHROME_X86="C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
set EDGE_PATH="C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
set EDGE_X64="C:\Program Files\Microsoft\Edge\Application\msedge.exe"

if exist %CHROME_PATH% (
    start "" %CHROME_PATH% --start-fullscreen "%~dp0index.html"
    exit /b
)

if exist %EDGE_PATH% (
    start "" %EDGE_PATH% --start-fullscreen "%~dp0index.html"
    exit /b
)

if exist %CHROME_X86% (
    start "" %CHROME_X86% --start-fullscreen "%~dp0index.html"
    exit /b
)

if exist %EDGE_X64% (
    start "" %EDGE_X64% --start-fullscreen "%~dp0index.html"
    exit /b
)

start "" "%~dp0index.html"
