#!/bin/bash

# Install Wallpaper as link.
ln -sfn ~/dotfiles/Minnosppuccin.png ~/.config/Minnosppuccin.png

# Install .bashrc as link.
ln -sfn ~/dotfiles/.bashrc ~/.bashrc
ln -sfn ~/dotfiles/bash_themes.sh ~/.config/bash_themes.sh
source ~/.bashrc

# Install config folders as link.
ln -sfn ~/dotfiles/nvim ~/.config/nvim
ln -sfn ~/dotfiles/kitty ~/.config/kitty
ln -sfn ~/dotfiles/tmux ~/.config/tmux
ln -sfn ~/dotfiles/yazi ~/.config/yazi

# Install Binaries
. ./setup_bins.sh
