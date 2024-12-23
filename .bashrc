# My bashrc file for customizing the terminal prompt and adding some aliases.

# Aliases

alias dotbash="nvim ~/.bashrc && source ~/.bashrc"
alias vim="nvim"
alias open="nautilus"
alias norminette="python3 /home/bgrhnzcn/.local/lib/python3.12/site-packages/norminette/__main__.py"
alias ls="ls --color"
alias grep="grep --color"

# Theme selection for bash prompt

THEME="Default"

# Source bash themes
source ~/.config/bash_themes.sh

# vim:ts=4:sw=4
