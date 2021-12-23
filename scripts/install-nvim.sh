#!/usr/bin/env sh

ver=v0.6.0
loc=$HOME/.local/bin

curl -LJO "https://github.com/neovim/neovim/releases/download/${ver}/nvim.appimage" \
  && curl -LJO "https://github.com/neovim/neovim/releases/download/${ver}/nvim.appimage.sha256sum"

sha256sum -c nvim.appimage.sha256sum
chmod u+x ./nvim.appimage
./nvim.appimage --appimage-extract

[ -d $loc ] || mkdir -p "$loc"

ln -s "$(pwd)/squashfs-root/usr/bin/nvim" "$loc/nvim"
ln -s $HOME/.vimrc $HOME/.config/nvim/init.vim
