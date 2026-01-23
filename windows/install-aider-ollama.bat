@echo off
setlocal

echo Installing aider-ollama for Windows

REM 1️⃣ Ensure %USERPROFILE%\bin exists
mkdir "%USERPROFILE%\bin" 2>nul

REM 2️⃣ Installation path
set SCRIPT="%USERPROFILE%\bin\aider-ollama.bat"

REM Copy aider-ollama script
echo Installing %~dp0\aider-ollama.bat to %SCRIPT%
copy "%~dp0\aider-ollama.bat" "%SCRIPT%" >nul
echo Installed aider-ollama %SCRIPT%. You can run it with the command 'aider-ollama'.

REM 3️⃣ Check if PATH includes %USERPROFILE%\bin
set PATH_CHECK=0
for /f "tokens=*" %%i in ('echo %PATH%') do (
    if "%%i"=="%USERPROFILE%\bin" set PATH_CHECK=1
)

REM 4️⃣ Add %USERPROFILE%\bin to PATH if not already
if %PATH_CHECK%==0 (
    echo Adding %USERPROFILE%\bin to PATH...
    setx PATH "%PATH%;%USERPROFILE%\bin"
    echo Added %USERPROFILE%\bin to PATH
    echo Installation complete. Restart your command prompt or run 'refreshenv'.
) else (
    echo %USERPROFILE%\bin is already in PATH
    echo Installation complete.
)

pause
