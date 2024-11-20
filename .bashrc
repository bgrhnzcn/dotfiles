# /etc/bashrc

# System wide functions and aliases
# Environment stuff goes in /etc/profile

# It's NOT a good idea to change this file unless you know what you
# are doing. It's much better to create a custom.sh shell script in
# /etc/profile.d/ to make custom changes to your environment, as this
# will prevent the need for merging in future updates.

# Theme selection for bash prompt
export VK_LAYER_PATH="/home/buozcan/scop/libs/Vulkan-ValidationLayers/build/layers"

declare -A themes

# Pre-determined palettes are here

purple_palette=('5;141' '5;98' '5;196')
blue_palette=('5;111' '5;69' '5;196')

themes["Purple"]="${purple_palette[*]}"
themes["Blue"]="${blue_palette[*]}"

# Theme selection variable

THEME="Purple"

# Aliases

alias open="nautilus"
alias code="~/vscode/code/bin/code"
alias grep="grep --color"
alias ls="ls --color"
alias vim="/var/lib/flatpak/app/io.neovim.nvim/current/active/export/bin/io.neovim.nvim"
alias vi="/var/lib/flatpak/app/io.neovim.nvim/current/active/export/bin/io.neovim.nvim"
alias nvim="/var/lib/flatpak/app/io.neovim.nvim/current/active/export/bin/io.neovim.nvim"

set_theme()
{
		local selected_theme="${themes[$THEME]}"

		local palette=($selected_theme)
		
		BG_COLOR1="${palette[0]}"
		BG_COLOR2="${palette[1]}"
		ERR_COLOR="${palette[2]}"
}

update_ps1()
{
    # Get the current branch name and set color theme
	set_theme
    local branch_name=$(git branch --show-current 2>/dev/null)
	local changes=$(git diff --name-only 2>/dev/null | wc -l 2>/dev/null)
	if [ "$changes" == "0" ]; then
		git_status="39"
	else
		git_status="38;$ERR_COLOR"
	fi
    if [ -z "$branch_name" ]; then
        # No branch, not in a git repo
        PS1='\[\e[48;${BG_COLOR2}m\]  \[\e[1;2;3m\]\A\[\e[22;23m\] \[\e[38;${BG_COLOR2};48;${BG_COLOR1}m\] \[\e[38;${BG_COLOR1};48;${BG_COLOR2}m\] \e[38;5;255;1m\]\s\[\e[39m\]@\u\[\e[22m\] \[\e[38;${BG_COLOR2};48;${BG_COLOR1}m\] \[\e[39;1m\]\w\[\e[22m\] \[\e[0;38;${BG_COLOR1}m\] \[\e[0m\]'
    else
        # In a git repo, show branch name
       PS1='\[\e[48;${BG_COLOR2}m\]  \[\e[1;2;3m\]\A\[\e[22;23m\] \[\e[38;${BG_COLOR2};48;${BG_COLOR1}m\] \[\e[38;${BG_COLOR1};48;${BG_COLOR2}m\] \[\e[38;5;255;1m\]\s\[\e[39m\]@\u \[\e[38;${BG_COLOR2};48;${BG_COLOR1}m\]  \[\e[38;${BG_COLOR1};48;${BG_COLOR2}m\] \[\e[1;3;${git_status}m\]'"$branch_name"'\[\e[22;23m\] \[\e[38;${BG_COLOR2};48;${BG_COLOR1}m\] \[\e[39;1m\]\w\[\e[22m\] \[\e[0;38;${BG_COLOR1}m\] \[\e[0m\]'
    fi
}
PROMPT_COMMAND=update_ps1

# vim:ts=4:sw=4
