#!/bin/bash
set -e

# 1. Kurulum dizinlerini tanımla
INSTALL_DIR="$HOME/.local"
NPM_DIR="$INSTALL_DIR/npm"
BIN_DIR="$INSTALL_DIR/bin"
TMP_DIR=$(mktemp -d)

mkdir -p "$NPM_DIR" "$BIN_DIR"

echo "[1/4] En son npm sürümü indiriliyor..."
cd "$TMP_DIR"

URL=$(curl -s https://registry.npmjs.org/npm/latest | sed -n 's/.*"tarball":"\([^"]*\)".*/\1/p')
curl -LO $URL

echo "[2/4] Arşiv açılıyor..."
TARBALL=$(ls npm-*.tgz)
tar -xzf "$TARBALL"
cd package

echo "[3/4] Kullanıcı dizinine kuruluyor..."
# `npm`'i kendi dizinine kur
node bin/npm-cli.js install --prefix "$NPM_DIR" .

# npm ikonu user-level `bin` dizinine bağla
ln -sf "$NPM_DIR/bin/npm" "$BIN_DIR/npm"
ln -sf "$NPM_DIR/bin/npx" "$BIN_DIR/npx"

echo "[4/4] PATH ayarları"
if ! echo "$PATH" | grep -q "$BIN_DIR"; then
  echo "export PATH=\"\$HOME/.local/bin:\$PATH\"" >> "$HOME/.bashrc"
  echo "📌 PATH güncellendi. Değişikliğin geçerli olması için terminali yeniden başlat ya da:"
  echo "source ~/.bashrc"
fi

# Temizliği yap
rm -rf "$TMP_DIR"

echo "✅ Kullanıcı dizinine npm başarıyla kuruldu!"
echo "🔁 Yeni terminal açarak veya 'source ~/.bashrc' komutunu çalıştırarak npm'i kullanabilirsin."

