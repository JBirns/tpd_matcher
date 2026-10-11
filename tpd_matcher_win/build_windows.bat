@echo off
REM Run this file on Windows by double-clicking it, or from Command Prompt.
cd /d "%~dp0"

REM Tkinter is required on the build PC only. Standard python.org Python includes it.
REM An isolated virtual environment avoids changing the user's normal Python.
py -c "import tkinter; print('Tkinter build support found')"
if errorlevel 1 goto :error

if not exist ".build-venv\Scripts\python.exe" py -m venv .build-venv
if errorlevel 1 goto :error

set "BUILD_PYTHON=%CD%\.build-venv\Scripts\python.exe"
"%BUILD_PYTHON%" -m pip install --upgrade pip
if errorlevel 1 goto :error

"%BUILD_PYTHON%" -m pip install -r "..\requirements.txt" pyinstaller
if errorlevel 1 goto :error

"%BUILD_PYTHON%" -m PyInstaller --noconfirm --clean --onedir --windowed --name TPDMatcher --collect-all openpyxl --distpath "%CD%\dist" --workpath "%CD%\build" --specpath "%CD%\build" "..\matcher.py"
if errorlevel 1 goto :error

echo.
echo Windows application created at: %CD%\dist\TPDMatcher\TPDMatcher.exe
pause
exit /b 0

:error
echo.
echo Build failed. Read the message above, then press a key to close.
pause
exit /b 1
