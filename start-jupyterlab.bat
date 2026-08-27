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

REM --- Step 1: locate uv ----------------------------------------
where uv >nul 2>nul
if errorlevel 1 (
    REM The standalone installer normally installs uv here
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

    if errorlevel 1 (
        echo.
        echo [ERROR] uv could not be installed automatically.
        echo.
        echo Please take a photo or screenshot of the message above
        echo and send it to the instructor.
        echo.
        pause
        exit /b 1
    )

    REM Make the freshly installed uv available in this window
    set "PATH=%USERPROFILE%\.local\bin;%PATH%"

    REM Check that uv can now be found
    where uv >nul 2>nul
    if errorlevel 1 (
        echo.
        echo [ERROR] uv appears to have been installed, but Windows
        echo could not find it.
        echo.
        echo Please close this window and double-click this launcher again.
        echo.
        pause
        exit /b 1
    )

    echo.
    echo uv installed successfully.
    echo.
)

REM --- Step 3: show uv version ----------------------------------
for /f "tokens=*" %%i in ('uv --version') do set UV_VERSION=%%i
echo Found %UV_VERSION%
echo.

REM --- Step 4: prepare and start JupyterLab ---------------------
echo Ready to go. Preparing JupyterLab ...
echo.
echo NOTE: The VERY FIRST start downloads Python and all packages.
echo       This can take several minutes - please do not close
echo       this window.
echo.
echo       Every start after that should be much faster.
echo.
echo JupyterLab will open in your browser automatically.
echo To stop it: click on this window and press Ctrl+C.
echo.

uv run jupyter lab

REM --- Step 5: handle errors ------------------------------------
if errorlevel 1 (
    echo.
    echo [ERROR] JupyterLab could not be started.
    echo.
    echo Please take a photo or screenshot of the message above
    echo and send it to the instructor.
    echo.
    pause
    exit /b 1
)

echo.
echo JupyterLab has stopped.
echo You can close this window now.
pause