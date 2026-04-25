#!/usr/bin/env bash
# setup.sh — install dependencies for ai-voice (macOS only)
set -euo pipefail

GREEN='\033[0;32m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; NC='\033[0m'
ok()   { echo -e "${GREEN}✓${NC} $*"; }
warn() { echo -e "${YELLOW}!${NC} $*"; }
die()  { echo -e "${RED}✗${NC} $*" >&2; exit 1; }

[[ "$(uname)" == "Darwin" ]] || die "This script supports macOS only."

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VENV_DIR="$SCRIPT_DIR/xtts-env"

echo "Setting up ai-voice..."
echo ""

if ! command -v brew &>/dev/null; then
    warn "Homebrew not found — installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    [[ -f /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
fi
ok "Homebrew $(brew --version | head -1)"

PYTHON_CMD=""
for cmd in python3.11 python3.10 python3.9; do
    if command -v "$cmd" &>/dev/null; then
        minor="$("$cmd" -c "import sys; print(sys.version_info.minor)" 2>/dev/null)" || continue
        if (( minor >= 9 && minor <= 11 )); then
            PYTHON_CMD="$cmd"; break
        fi
    fi
done

if [[ -z "$PYTHON_CMD" ]]; then
    warn "No suitable Python found (3.9–3.11). Installing python@3.11..."
    brew install python@3.11
    PYTHON_CMD="$(brew --prefix python@3.11)/bin/python3.11"
fi
ok "Python $($PYTHON_CMD --version)"

if [[ -d "$VENV_DIR" ]]; then
    warn "Virtual environment already exists at $VENV_DIR — skipping creation."
else
    "$PYTHON_CMD" -m venv "$VENV_DIR"
    ok "Virtual environment created."
fi
source "$VENV_DIR/bin/activate"

# 4. pip + TTS
pip install --upgrade pip --quiet
ok "pip $(pip --version | awk '{print $2}')"

echo "Installing Coqui TTS... (this may take a few minutes)"
pip install TTS --quiet
ok "TTS installed."

python -c "from TTS.api import TTS" 2>/dev/null || die "TTS import failed. Check the output above."

echo ""
echo -e "${GREEN}All done!${NC}"
echo ""
echo "Usage:"
echo "  source xtts-env/bin/activate"
echo "  python speak.py text.txt --lang en"
echo ""
