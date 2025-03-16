#!/bin/bash

if [ ! -d "$HOME/.local/bin" ]; then
	mkdir -p "$HOME/.local/bin"
fi

# Install Neovim

# Install Custom Scripts
ln -sfn ~/dotfiles/scripts/ccf ~/.local/bin/ccf

