# My bashrc file for customizing the terminal prompt and adding some aliases.

# Enviroments

. "$HOME/.cargo/env"

if [ -d ~/Scripts ]; then
	export PATH="$PATH:$HOME/Scripts:$HOME/.bin"
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

# Aliases

alias logout="gnome-session-quit --logout"
alias dotbash="$EDITOR ~/.bashrc && source ~/.bashrc"
alias vim="$EDITOR"
alias open="$FILE_MANAGER"
alias norminette="python3 /home/bgrhnzcn/.local/lib/python3.12/site-packages/norminette/__main__.py"
alias ls="ls --color"
alias grep="grep --color"
alias start="~/Scripts/setup-tmux-session.sh"

# Theme selection for bash prompt

THEME="Default"

# Source bash themes

source ~/.config/bash_themes.sh

# vim:ts=4:sw=4
