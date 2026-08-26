@echo off
REM ---------------------------------------------------------------
REM  USE Python - JupyterLab launcher for Windows
REM  Just double-click this file. No terminal required.
REM ---------------------------------------------------------------

setlocal
cd /d "%~dp0"

echo ===============================================================
echo   USE Python - starting JupyterLab
echo ===============================================================
echo.

REM --- Step 1: is uv installed? ---------------------------------
where uv >nul 2>nul
if errorlevel 1 (
    echo uv was not found.
    echo Installing uv now ...
    echo.

    winget install --id=astral-sh.uv -e --accept-source-agreements --accept-package-agreements

    if errorlevel 1 (
        echo.
        echo [ERROR] uv could not be installed automatically.
        echo.
        echo Please open PowerShell and run:
        echo.
        echo     winget install --id=astral-sh.uv -e
        echo.
        pause
        exit /b 1
    )

    REM Refresh PATH for the current process
    set "PATH=%USERPROFILE%\.local\bin;%PATH%"

    REM Check again
    where uv >nul 2>nul
    if errorlevel 1 (
        echo.
        echo uv was installed, but Windows has not made it available
        echo to this window yet.
        echo.
        echo Please close this window and double-click the launcher again.
        echo.
        pause
        exit /b 1
    )

    echo.
    echo uv installed successfully.
    echo.
)

REM --- Step 2: start JupyterLab ---------------------------------
echo Ready to go. Preparing JupyterLab ...
echo.
echo NOTE: The VERY FIRST start downloads Python and all packages.
echo       This can take several minutes - please do not close
echo       this window. Every start after that should be much faster.
echo.
echo JupyterLab will open in your browser automatically.
echo To stop it: click on this window and press Ctrl+C.
echo.

uv run jupyter lab

if errorlevel 1 (
    echo.
    echo [ERROR] JupyterLab could not be started.
    echo Please take a photo or screenshot of the message above and send it to me.
    echo.
    pause
    exit /b 1
)

echo.
echo JupyterLab has stopped. You can close this window now.
pause