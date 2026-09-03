#!/bin/bash
# ---------------------------------------------------------------
#  USE Python - Visual Studio Code launcher for macOS
#  Just double-click this file. No terminal required.
#  The very first time: right-click -> Open (see README.md)
# ---------------------------------------------------------------

# Always work in the folder this script lives in
cd "$(dirname "$0")" || exit 1

echo "==============================================================="
echo "  USE Python - starting Visual Studio Code"
echo "==============================================================="
echo

# --- Step 1: locate uv -----------------------------------------
if ! command -v uv >/dev/null 2>&1; then
    for LOCATION in /opt/homebrew/bin /usr/local/bin "$HOME/.local/bin"; do
        if [ -x "$LOCATION/uv" ]; then
            export PATH="$LOCATION:$PATH"
            break
        fi
    done
fi

# --- Step 2: install uv if necessary ---------------------------
if ! command -v uv >/dev/null 2>&1; then
    echo "uv was not found."
    echo "Installing uv now ..."
    echo

    curl -LsSf https://astral.sh/uv/install.sh | sh
    STATUS=$?
    if [ $STATUS -ne 0 ]; then
        echo
        echo "[ERROR] uv could not be installed automatically."
        exit $STATUS
    fi
    export PATH="$HOME/.local/bin:$PATH"
fi

# --- Step 3: prepare the workspace environment -----------------
echo "Preparing the Python environment ..."
uv run python -c 'import sys; print("Using " + sys.executable)'
STATUS=$?
if [ $STATUS -ne 0 ]; then
    echo
    echo "[ERROR] The Python environment could not be prepared."
    exit $STATUS
fi
echo

# --- Step 4: open an existing VS Code installation -------------
if [ -d "/Applications/Visual Studio Code.app" ] || [ -d "$HOME/Applications/Visual Studio Code.app" ]; then
    echo "Opening this folder in Visual Studio Code ..."
    open -a "Visual Studio Code" "$PWD"
    exit $?
fi

# The command-line launcher is an additional fallback.
if command -v code >/dev/null 2>&1; then
    echo "Opening this folder in Visual Studio Code ..."
    code .
    exit $?
fi

# --- Step 5: offer the official download page ------------------
echo "Visual Studio Code was not found on this Mac."
echo
read -r -p "Open the official Visual Studio Code download page now? [y/N] " INSTALL_VSCODE
case "$INSTALL_VSCODE" in
    [yY]|[yY][eE][sS])
        open "https://code.visualstudio.com/download"
        echo
        echo "The download page has opened in your browser."
        echo "Install Visual Studio Code, move it to Applications, then"
        echo "double-click this launcher again."
        ;;
    *)
        echo
        echo "You can install Visual Studio Code later from:"
        echo "https://code.visualstudio.com/download"
        ;;
esac

echo
echo "You can close this window now (Cmd+W)."
