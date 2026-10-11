#!/usr/bin/env bash
# Run this on Linux from this directory: bash build_linux.sh
set -euo pipefail
cd "$(dirname "$0")"

# By default this uses the active Python (including pyenv). To choose another
# interpreter: PYTHON_BIN=/path/to/python bash build_linux.sh
PYTHON_BIN="${PYTHON_BIN:-python3}"
command -v "$PYTHON_BIN" >/dev/null || {
  echo "Python executable not found: $PYTHON_BIN" >&2
  exit 1
}

# Keep packaging tools out of the user's normal Python environment. The final
# bundle contains Python, Tk, and the application dependencies for recipients.
"$PYTHON_BIN" -c 'import tkinter; print("Tkinter build support found")'
if [[ ! -x .build-venv/bin/python ]]; then
  "$PYTHON_BIN" -m venv .build-venv
fi
BUILD_PYTHON="$PWD/.build-venv/bin/python"
"$BUILD_PYTHON" -m pip install --upgrade pip
"$BUILD_PYTHON" -m pip install -r ../requirements.txt pyinstaller
"$BUILD_PYTHON" -m PyInstaller --noconfirm --clean --onedir --windowed \
  --name TPDMatcher \
  --collect-all openpyxl \
  --distpath "$PWD/dist" \
  --workpath "$PWD/build" \
  --specpath "$PWD/build" \
  ../matcher.py

echo "Linux application created at: $PWD/dist/TPDMatcher/TPDMatcher"
