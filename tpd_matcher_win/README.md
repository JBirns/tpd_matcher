# Windows build

On a Windows build machine, install a current Python from python.org and then double-click `build_windows.bat`. The script uses an isolated `.build-venv` for packaging tools.

The distributable application is placed in `dist\TPDMatcher\`. Distribute that entire folder, preserving its contents. Recipients open `TPDMatcher.exe`; they do not need Python, Tkinter, or a terminal.

Windows SmartScreen may warn for an unsigned, locally built executable. Code-signing is a separate optional release step.
