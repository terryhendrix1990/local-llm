@echo off
setlocal enabledelayedexpansion

echo Aider running with directory %~dp0

REM Check if OLLAMA_API_BASE is set
if "%OLLAMA_API_BASE%"=="" (
    echo Defaulting to http://localhost:11434 for ollama
    echo Set environment variable OLLAMA_API_BASE to a different host to override
    set OLLAMA_API_BASE=http://localhost:11434
)

REM -----------------------------
REM Check if Ollama is running
REM -----------------------------
for /f "tokens=2" %%i in ('tasklist /FI "IMAGENAME eq ollama.exe" /FO TABLE /NH') do (
    set OLLAMA_PID=%%i
)

set OLLAMA_STARTED=0

if "%OLLAMA_PID%"=="" (
    if "%OLLAMA_API_BASE%"=="http://localhost:11434" (
        echo Ollama not running. Starting Ollama...
        mkdir "%~dp0\.aider-logs" 2>nul
        start "" ollama serve > "%~dp0\.aider-logs\application.log" 2>&1
        set OLLAMA_STARTED=1
        echo Ollama started
        REM Give it a few seconds to initialize
        timeout /t 3 /nobreak >nul
    )
) else (
    echo Ollama already running with PID %OLLAMA_PID%
)

REM -----------------------------
REM Run Aider in Docker
REM -----------------------------
docker run --rm -it ^
  -e "OLLAMA_API_BASE=%OLLAMA_API_BASE%" ^
  --volume "%cd%:/app" ^
  paulgauthier/aider-full %*

REM -----------------------------
REM Cleanup function (not easily implemented in batch)
REM -----------------------------
