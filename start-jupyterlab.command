#!/bin/bash
# ---------------------------------------------------------------
#  USE Python - JupyterLab launcher for macOS
#  Just double-click this file. No terminal required.
#  The very first time: right-click -> Open (see README.md)
# ---------------------------------------------------------------

# Always work in the folder this script lives in
cd "$(dirname "$0")" || exit 1

echo "==============================================================="
echo "  USE Python - starting JupyterLab"
echo "==============================================================="
echo

# --- Step 1: locate uv ----------------------------------------
# When launched by double-clicking in Finder the PATH is often
# incomplete, so also look in the usual installation locations.
if ! command -v uv >/dev/null 2>&1; then
    for LOCATION in /opt/homebrew/bin /usr/local/bin "$HOME/.local/bin"; do
        if [ -x "$LOCATION/uv" ]; then
            export PATH="$LOCATION:$PATH"
            break
        fi
    done
fi

# --- Step 2: install uv if necessary --------------------------
if ! command -v uv >/dev/null 2>&1; then
    echo "uv was not found."
    echo "Installing uv now ..."
    echo

    curl -LsSf https://astral.sh/uv/install.sh | sh

    STATUS=$?
    if [ $STATUS -ne 0 ]; then
        echo
        echo "[ERROR] uv could not be installed automatically."
        echo
        echo "Please take a photo or screenshot of the message above"
        echo "and send it to me."
        echo
        echo "To close this window: Cmd+W"
        exit $STATUS
    fi

    # uv's installer normally puts uv here
    export PATH="$HOME/.local/bin:$PATH"

    # Check again
    if ! command -v uv >/dev/null 2>&1; then
        echo
        echo "[ERROR] uv was installed, but could not be found."
        echo
        echo "Please close this window and double-click the launcher again."
        echo
        echo "To close this window: Cmd+W"
        exit 1
    fi

    echo
    echo "uv installed successfully."
    echo
fi

# --- Step 3: start JupyterLab ---------------------------------
echo "Ready to go. Preparing JupyterLab ..."
echo
echo "NOTE: The VERY FIRST start downloads Python and all packages."
echo "      This can take several minutes - please do not close"
echo "      this window. Every start after that should be much faster."
echo
echo "JupyterLab will open in your browser automatically."
echo "To stop it: click on this window and press Ctrl+C."
echo

uv run jupyter lab

STATUS=$?
if [ $STATUS -ne 0 ]; then
    echo
    echo "[ERROR] JupyterLab could not be started."
    echo "Please take a photo or screenshot of the message above and send it to me."
    echo
    echo "To close this window: Cmd+W"
    exit $STATUS
fi

echo
echo "JupyterLab has stopped. You can close this window now (Cmd+W)."