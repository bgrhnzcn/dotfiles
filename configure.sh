#!/bin/bash

# Install Wallpaper as link.
ln -sfn ~/dotfiles/Minnosppuccin.png	~/.config/Minnosppuccin.png

# Install .bashrc as link.
ln -sfn ~/dotfiles/.bashrc				~/.bashrc
ln -sfn ~/dotfiles/bash_themes.sh		~/.config/bash_themes.sh

. ~/.bashrc

# Install config folders as link.
ln -sfn ~/dotfiles/nvim					~/.config/nvim
ln -sfn ~/dotfiles/Kitty				~/.config/kitty
ln -sfn ~/dotfiles/tmux					~/.config/tmux
ln -sfn ~/dotfiles/yazi					~/.config/yazi
ln -sfn ~/dotfiles/.clang-format		~/.clang-format

# Install Binaries
. ./setup_bins.sh
