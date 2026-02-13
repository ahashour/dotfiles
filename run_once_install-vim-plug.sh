#!/bin/sh
# Install vim-plug for Vim so ~/.vimrc Plug commands work.
# After apply, run vim and :PlugInstall to install plugins.
set -e
plug_vim="${HOME}/.vim/autoload/plug.vim"
if [ -f "$plug_vim" ] && [ -s "$plug_vim" ]; then
  exit 0
fi
mkdir -p "$(dirname "$plug_vim")"
curl -fLo "$plug_vim" --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
