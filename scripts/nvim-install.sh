#!/usr/bin/env bash
# Installs a pinned Neovim release into /usr/local/nvim.
#
# /usr/local itself is root-owned but /usr/local/nvim is not, so this replaces
# the tree's contents in place rather than renaming the directory — that keeps
# the whole thing sudo-free. The previous version is kept as a tarball next to
# the install so a bad upgrade is one `tar xzf` away.
#
# Usage: ./nvim-install.sh [version]   e.g. ./nvim-install.sh v0.12.4

set -euo pipefail

VERSION="${1:-v0.12.4}"
PREFIX="/usr/local/nvim"
BACKUP_DIR="$HOME/.local/share/nvim-releases"

case "$(uname -s)/$(uname -m)" in
	Darwin/arm64) ASSET="nvim-macos-arm64.tar.gz" ;;
	Darwin/x86_64) ASSET="nvim-macos-x86_64.tar.gz" ;;
	Linux/aarch64) ASSET="nvim-linux-arm64.tar.gz" ;;
	Linux/x86_64) ASSET="nvim-linux-x86_64.tar.gz" ;;
	*) echo "unsupported platform: $(uname -s)/$(uname -m)" >&2; exit 1 ;;
esac

if [ ! -w "$PREFIX" ]; then
	echo "$PREFIX is not writable by $(whoami)." >&2
	echo "Run: sudo mkdir -p $PREFIX && sudo chown $(whoami) $PREFIX" >&2
	exit 1
fi

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

echo "==> downloading $VERSION/$ASSET"
curl -fsSL -o "$TMP/$ASSET" \
	"https://github.com/neovim/neovim/releases/download/$VERSION/$ASSET"

echo "==> extracting"
tar xzf "$TMP/$ASSET" -C "$TMP"
EXTRACTED="$TMP/${ASSET%.tar.gz}"

# Fail before touching the existing install if the new binary cannot run at all.
"$EXTRACTED/bin/nvim" --version >/dev/null

if [ -x "$PREFIX/bin/nvim" ]; then
	CURRENT="$("$PREFIX/bin/nvim" --version | head -1 | awk '{print $2}')"
	mkdir -p "$BACKUP_DIR"
	echo "==> backing up $CURRENT to $BACKUP_DIR/nvim-$CURRENT.tar.gz"
	tar czf "$BACKUP_DIR/nvim-$CURRENT.tar.gz" -C "$(dirname "$PREFIX")" "$(basename "$PREFIX")"
fi

echo "==> installing into $PREFIX"
rm -rf "$PREFIX/bin" "$PREFIX/lib" "$PREFIX/share"
cp -R "$EXTRACTED/bin" "$EXTRACTED/lib" "$EXTRACTED/share" "$PREFIX/"

echo "==> installed: $("$PREFIX/bin/nvim" --version | head -1)"

case ":$PATH:" in
	*":$PREFIX/bin:"*) ;;
	*) echo "note: add '$PREFIX/bin' to PATH — it is not there right now" >&2 ;;
esac
