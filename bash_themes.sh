
declare -A themes

# Pre-determined palettes are here

default_palette=('\e[0;35m' '\e[30;45m' '\e[0;36m' '\e[30;46m' '\e[0;34m' '\e[30;44m' '\e[0;33m' '\e[30;43m' '\e[0;32m' '\e[30;42m' '\e[0;31m' '\e[30;41m' '\e[0;31m' '\e[30;41m')

themes["Default"]="${default_palette[*]}"

circle_left="\uE0B6"
circle_right="\uE0B4"
line="\uF46B"
clock_ico="\uF018"
user_ico="\uF2C0"
host_ico="\UF08B9"
dir_ico="\uF413"
git_ico="\uE0A0"
shell_ico="\uF120"
exit_ico="\uEA87"
python_ico="\uE235"
# Theme selection variable

set_theme()
{
	local selected_theme="${themes[$THEME]}"

	local palette
	read -ra palette <<< "$selected_theme"
	
	clock1="${palette[0]}"
	clock2="${palette[1]}"
	shell1="${palette[2]}"
	shell2="${palette[3]}"
	host1="${palette[6]}"
	host2="${palette[7]}"
	user1="${palette[4]}"
	user2="${palette[5]}"
	dir1="${palette[6]}"
	dir2="${palette[7]}"
	git1="${palette[8]}"
	git2="${palette[9]}"
	git_err1="${palette[10]}"
	git_err2="${palette[11]}"
	exit1="${palette[12]}"
	exit2="${palette[13]}"
	py1="${palette[2]}"
	py2="${palette[3]}"
}

update_ps1()
{
	local exit="$?"
	# In this area, getting basic data for printing prompt.
	# Check current directory for converting tilde when $HOME exist in path.
	local dir="${PWD}";
	if [[ "$dir" == "$HOME" ]]; then
		dir="~"
	elif [[ "$dir" == "$HOME/"* ]]; then
		dir="~${dir#"$HOME"}"
	fi
	# Time as Hour:Minute format.
	local clock
	clock=$(date +"%H:%M")
	# "/bin/bash" but skips "/bin/".
	local shell="bash"
	# Get the current branch name and set color theme
	set_theme
	local branch_name
	branch_name=$(git branch --show-current 2>/dev/null)
	local changes
	changes=$(git diff --name-only 2>/dev/null | wc -l 2>/dev/null)
	
	if [ "$changes" == "0" ]; then
		git1=$git1
		git2=$git2
	else
		git1=$git_err1
		git2=$git_err2
	fi
	
	local shell_prompt=" ${shell1}${circle_left}${shell2}${shell_ico}  ${shell}${shell1}${circle_right}\e[0m "

	local host_prompts="${host1}${circle_left}${host2}${host_ico}  ${HOSTNAME}${host1}${circle_right}\e[0m "

	local user_prompt="${user1}${circle_left}${user2}${user_ico}  ${USER}${user1}${circle_right}\e[0m "

	local dir_prompt="${dir1}${circle_left}${dir2}${dir_ico}  ${dir}${dir1}${circle_right}\e[0m "

	local git_prompt="${git1}${circle_left}${git2}${git_ico} ${branch_name}${git1}${circle_right}\e[0m "

	local exit_prompt=""
	if [ $exit != "0" ]; then
		exit_prompt="${exit1}${circle_left}${exit2}${exit_ico} ${exit}${exit1}${circle_right}\e[0m "
	fi
	
	local python_env_prompt=""
	if [ -n "$VIRTUAL_ENV" ]; then
		python_env_prompt="${py1}${circle_left}${py2}${python_ico} ${py1}${circle_right}\e[0m "
	fi

	local right="${python_env_prompt}${exit_prompt}${clock1}${circle_left}${clock2}${clock_ico} ${clock}${clock1}${circle_right}\e[0m"
	
	if [ -z "$branch_name" ]; then
		# No branch, not in a git repo
		local left="${shell_prompt}${host_prompts}${user_prompt}${dir_prompt}"
	else
		# Branch exist, print that branch and change color to indicate state.
		local left="${shell_prompt}${host_prompts}${user_prompt}${git_prompt}${dir_prompt}"
	fi

	# Get column count to calculate prompt size
	local columns
	columns=$(tput cols)
	declare plain_left
	plain_left=$(echo -e "${left}" | sed -r 's/\x1B\[[0-9;]*[a-zA-Z]//g')
	local plain_right
	plain_right=$(echo -e "${right}" | sed -r 's/\x1B\[[0-9;]*[a-zA-Z]//g')
	local space_count=$((columns - ${#plain_left} - ${#plain_right}))
	local spaces
	spaces=$(printf '%*s' ${space_count})
	
	PS1=$(printf "$left$spaces$right\n  \UF17A9 ")
	PS2=$(printf "  \uF101 ")
	PS2="  \uF101 "
}

PROMPT_COMMAND=update_ps1
