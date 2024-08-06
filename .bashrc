# /etc/bashrc

# System wide functions and aliases
# Environment stuff goes in /etc/profile

# It's NOT a good idea to change this file unless you know what you
# are doing. It's much better to create a custom.sh shell script in
# /etc/profile.d/ to make custom changes to your environment, as this
# will prevent the need for merging in future updates.

# Theme selection for bash prompt

declare -A themes

# Pre-determined palettes are here

purple_palette=('5;141' '5;98' '5;196')
blue_palette=('5;111' '5;69' '5;196')

themes["Purple"]="${purple_palette[*]}"
themes["Blue"]="${blue_palette[*]}"

# Theme selection variable

THEME="Purple"

# Aliases

alias dotbash="nvim ~/.bashrc && source ~/.bashrc"
alias vim="nvim"
alias open="nautilus"
alias norminette="python3 /home/bgrhnzcn/.local/lib/python3.12/site-packages/norminette/__main__.py"

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
# Prevent doublesourcing
if [ -z "$BASHRCSOURCED" ]; then
  BASHRCSOURCED="Y"

  # are we an interactive shell?
  if [ "$PS1" ]; then
    if [ -z "$PROMPT_COMMAND" ]; then
      declare -a PROMPT_COMMAND
      case $TERM in
      xterm*)
        if [ -e /etc/sysconfig/bash-prompt-xterm ]; then
            PROMPT_COMMAND=/etc/sysconfig/bash-prompt-xterm
        else
            PROMPT_COMMAND='printf "\033]0;%s@%s\007" "${USER}" "${PWD/#$HOME/\~}"'
        fi
        ;;
      screen*)
        if [ -e /etc/sysconfig/bash-prompt-screen ]; then
            PROMPT_COMMAND=/etc/sysconfig/bash-prompt-screen
        else
            PROMPT_COMMAND='printf "\033k%s@%s\033\\" "${USER}" "${PWD/#$HOME/\~}"'
        fi
        ;;
      *)
        [ -e /etc/sysconfig/bash-prompt-default ] && PROMPT_COMMAND=/etc/sysconfig/bash-prompt-default
        ;;
      esac
    fi
    # Turn on parallel history
    shopt -s histappend
    # Turn on checkwinsize
    shopt -s checkwinsize
    # Change the default prompt string
    [ "$PS1" = "\\s-\\v\\\$ " ] && PS1="[\u@\W]\\$ "
    # You might want to have e.g. tty in prompt (e.g. more virtual machines)
    # and console windows
    # If you want to do so, just add e.g.
    # if [ "$PS1" ]; then
    #   PS1="[\u@\h:\l \W]\\$ "
    # fi
    # to your custom modification shell script in /etc/profile.d/ directory
  fi

  if ! shopt -q login_shell ; then # We're not a login shell
    # Need to redefine pathmunge, it gets undefined at the end of /etc/profile
    pathmunge () {
        case ":${PATH}:" in
            *:"$1":*)
                ;;
            *)
                if [ "$2" = "after" ] ; then
                    PATH=$PATH:$1
                else
                    PATH=$1:$PATH
                fi
        esac
    }

    # Set default umask for non-login shell only if it is set to 0
    [ `umask` -eq 0 ] && umask 022

    SHELL=/bin/bash
    # Only display echos from profile.d scripts if we are no login shell
    # and interactive - otherwise just process them to set envvars
    for i in /etc/profile.d/*.sh; do
        if [ -r "$i" ]; then
            if [ "$PS1" ]; then
                . "$i"
            else
                . "$i" >/dev/null
            fi
        fi
    done

    unset i
    unset -f pathmunge
  fi

fi
# vim:ts=4:sw=4
