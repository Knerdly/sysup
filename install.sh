#!/bin/sh
# Install sysup from GitHub to ~/.local/sbin

REPO_RAW_URL="https://raw.githubusercontent.com/Knerdly/init-eponym/main/sysup"
INSTALL_DIR="${HOME}/.local/sbin"
INSTALL_PATH="${INSTALL_DIR}/sysup"

mkdir -p "${INSTALL_DIR}"

echo "📥 Downloading sysup from GitHub..."
curl -fsSL "${REPO_RAW_URL}" -o "${INSTALL_PATH}" || {
  echo "❌ Failed to download sysup script"
  exit 1
}

# Validate that it's a shell script
if ! head -n 1 "${INSTALL_PATH}" | grep -q "^#\!/"; then
  echo "❌ Downloaded file is not a valid script. Aborting."
  rm -f "${INSTALL_PATH}"
  exit 1
fi

chmod +x "${INSTALL_PATH}"

# Check if INSTALL_DIR is in PATH
case ":${PATH}:" in
  *":${INSTALL_DIR}:"*) ;;
  *) echo "⚠️  ${INSTALL_DIR} not in PATH. Add this to your shell config:"
     echo "export PATH=\"${INSTALL_DIR}:\$PATH\"" ;;
esac

echo "✅ sysup installed to ${INSTALL_PATH}"