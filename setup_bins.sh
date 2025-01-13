#!/bin/bash

if [ ! -d "$HOME/.local/bin" ]; then
	mkdir -p "$HOME/.local/bin"
fi

# Install Neovim

# Install Custom Scripts
ln -sfn ~/dotfiles/scripts/ccf ~/.local/bin/ccf

# Install Yazi
ln -sfn ~/.local/share/applications/yazi/target/release/yazi ~/.local/bin
