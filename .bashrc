#!/bin/bash
# My bashrc file for customizing the terminal prompt and adding some aliases.

# Theme selection for bash prompt

THEME="Default"

# Source bash themes

source ~/.config/bash_themes.sh

# Enviroments

if [ -d ~/.local/bin ]; then
	export PATH="$HOME/.local/bin:$PATH"
fi

if command -v "nvim" &> /dev/null; then
	export EDITOR="nvim"
else
	export EDITOR="vi"
fi

if command -v "yazi" &> /dev/null; then
	export FILE_MANAGER="yazi"
else
	export FILE_MANAGER="nautilus"
fi

export PATH="$HOME/dotfiles/workenv:$PATH"

# Aliases

alias logout="gnome-session-quit --logout"
alias dotbash="$EDITOR ~/.bashrc && source ~/.bashrc"
alias vim="$EDITOR"
alias open="$FILE_MANAGER"
alias norminette="python3 /home/bgrhnzcn/.local/lib/python3.12/site-packages/norminette/__main__.py"
alias ls="ls --color"
alias grep="grep --color"
alias start="~/Scripts/setup-tmux-session.sh"
alias afclean='bash '/home/buozcan/AFC/AFCleaner.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
