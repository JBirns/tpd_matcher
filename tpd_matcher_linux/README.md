# Linux build

On a Linux build machine with a GUI-enabled Python (including a pyenv Python rebuilt with Tk support), run:

```bash
bash build_linux.sh
```

The distributable application is placed in `dist/TPDMatcher/`. Distribute that entire folder, preserving its contents. Recipients open `TPDMatcher`; they do not need Python, Tkinter, or a terminal.

The build script intentionally creates a one-folder application because it is simpler to test and troubleshoot than a single self-extracting executable.

The script creates `.build-venv/` for PyInstaller and its build-only dependencies. It uses the active `python3`, including pyenv; specify another interpreter if needed:

```bash
PYTHON_BIN=/path/to/python bash build_linux.sh
```
