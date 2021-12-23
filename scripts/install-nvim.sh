#!/usr/bin/env sh

ver=v0.6.0

curl -LJO "https://github.com/neovim/neovim/releases/download/${ver}/nvim.appimage" \
  && curl -LJO "https://github.com/neovim/neovim/releases/download/${ver}/nvim.appimage.sha256sum"

sha256sum -c nvim.appimage.sha256sum
chmod u+x ./nvim.appimage
./nvim.appimage --appimage-extract
ln -s "$(pwd)/squashfs-root/usr/bin/nvim" "$HOME/.local/bin/nvim"
