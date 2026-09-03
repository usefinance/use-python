@echo off
REM ---------------------------------------------------------------
REM  USE Python - Visual Studio Code launcher for Windows
REM  Opens this course folder in VS Code.
REM ---------------------------------------------------------------

setlocal
cd /d "%~dp0"

echo ===============================================================
echo   USE Python - starting Visual Studio Code
echo ===============================================================
echo.

REM --- Step 1: locate uv ----------------------------------------
where uv >nul 2>nul
if errorlevel 1 (
    if exist "%USERPROFILE%\.local\bin\uv.exe" (
        set "PATH=%USERPROFILE%\.local\bin;%PATH%"
    )
)

REM --- Step 2: install uv if necessary --------------------------
where uv >nul 2>nul
if errorlevel 1 (
    echo uv was not found.
    echo Installing uv now ...
    echo.

    powershell -NoProfile -ExecutionPolicy ByPass -Command ^
        "irm https://astral.sh/uv/install.ps1 | iex"

    if errorlevel 1 goto :launch_error
    set "PATH=%USERPROFILE%\.local\bin;%PATH%"
)

REM --- Step 3: prepare the workspace environment ----------------
echo Preparing the Python environment ...
uv run python -c "import sys; print('Using ' + sys.executable)"
if errorlevel 1 goto :launch_error
echo.

REM --- Step 4: use the VS Code command if it is already on PATH --
where code >nul 2>nul
if not errorlevel 1 (
    echo Opening this folder in Visual Studio Code ...
    code .
    if errorlevel 1 goto :launch_error
    exit /b 0
)

REM --- Step 5: look in the normal VS Code installation folders ---
call :find_vscode
if defined VSCODE_EXE goto :launch_vscode

REM --- Step 6: offer the official user installer -----------------
echo Visual Studio Code was not found on this computer.
echo.
set /p "INSTALL_VSCODE=Install Visual Studio Code now? [Y/N]: "
if /I not "%INSTALL_VSCODE%"=="Y" (
    echo.
    echo You can install Visual Studio Code later from:
    echo https://code.visualstudio.com/download
    echo.
    pause
    exit /b 0
)

echo.
echo Downloading the official Visual Studio Code user installer ...
powershell -NoProfile -ExecutionPolicy ByPass -Command ^
    "$ErrorActionPreference = 'Stop'; $architecture = if ($env:PROCESSOR_ARCHITECTURE -eq 'ARM64') { 'win32-arm64-user' } elseif ([Environment]::Is64BitOperatingSystem) { 'win32-x64-user' } else { 'win32-ia32-user' }; $installer = Join-Path $env:TEMP 'VSCodeUserSetup.exe'; Invoke-WebRequest -Uri ('https://code.visualstudio.com/sha/download?build=stable&os=' + $architecture) -OutFile $installer; $process = Start-Process -FilePath $installer -Wait -PassThru; if ($process.ExitCode -ne 0) { throw ('VS Code installer exited with code ' + $process.ExitCode) }; Remove-Item -LiteralPath $installer -Force"

if errorlevel 1 (
    echo.
    echo [ERROR] Visual Studio Code could not be installed automatically.
    echo.
    echo Please take a photo or screenshot of the message above
    echo and send it to the instructor.
    echo.
    pause
    exit /b 1
)

call :find_vscode
if not defined VSCODE_EXE (
    echo.
    echo [ERROR] Visual Studio Code was installed, but could not be found.
    echo.
    echo Please close this window and double-click this launcher again.
    echo.
    pause
    exit /b 1
)

:launch_vscode
echo Opening this folder in Visual Studio Code ...
start "" "%VSCODE_EXE%" "%CD%"
if errorlevel 1 goto :launch_error
exit /b 0

:launch_error
echo.
echo [ERROR] Visual Studio Code could not be started.
echo.
echo Please take a photo or screenshot of the message above
echo and send it to the instructor.
echo.
pause
exit /b 1

:find_vscode
set "VSCODE_EXE="
for %%P in ("%LOCALAPPDATA%\Programs\Microsoft VS Code\Code.exe" "%ProgramFiles%\Microsoft VS Code\Code.exe" "%ProgramFiles(x86)%\Microsoft VS Code\Code.exe") do (
    if not defined VSCODE_EXE if exist "%%~fP" set "VSCODE_EXE=%%~fP"
)
exit /b
