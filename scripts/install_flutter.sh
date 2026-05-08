#!/usr/bin/env bash
set -euo pipefail

FLUTTER_VERSION="${FLUTTER_VERSION:-3.29.0}"
INSTALL_DIR="${HOME}/flutter"
ARCHIVE_URL="https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz"

if command -v flutter >/dev/null 2>&1; then
  echo "Flutter ya está instalado: $(flutter --version | head -n 1)"
  exit 0
fi

mkdir -p "${HOME}"
cd "${HOME}"

echo "Descargando Flutter ${FLUTTER_VERSION}..."
curl -fL "${ARCHIVE_URL}" -o flutter.tar.xz

echo "Instalando en ${INSTALL_DIR}..."
rm -rf "${INSTALL_DIR}"
mkdir -p "${INSTALL_DIR}"
tar -xJf flutter.tar.xz -C "${INSTALL_DIR}" --strip-components=1
rm -f flutter.tar.xz

if ! grep -q 'export PATH="$HOME/flutter/bin:$PATH"' "${HOME}/.bashrc" 2>/dev/null; then
  echo 'export PATH="$HOME/flutter/bin:$PATH"' >> "${HOME}/.bashrc"
fi

export PATH="$HOME/flutter/bin:$PATH"
flutter --version
