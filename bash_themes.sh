
declare -A themes

# Pre-determined palettes are here

default_palette=('\e[0;35m' '\e[30;45m' '\e[0;36m' '\e[30;46m' '\e[0;34m' '\e[30;44m' '\e[0;33m' '\e[30;43m' '\e[0;32m' '\e[30;42m' '\e[0;31m' '\e[30;41m' '\e[0;31m' '\e[30;41m')

themes["Default"]="${default_palette[*]}"

circle_left="\uE0B6"
circle_right="\uE0B4"
line="\uF45B"
clock_ico="\uF017"
user_ico="\uF2C0"
dir_ico="\uF413"
git_ico="\uE0A0"
shell_ico="\uF120"
exit_ico="\uEA87"

# Theme selection variable

set_theme()
{
	local selected_theme="${themes[$THEME]}"

	local palette=($selected_theme)
	
	clock1="${palette[0]}"
	clock2="${palette[1]}"
	shell1="${palette[2]}"
	shell2="${palette[3]}"
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
		dir="~${dir#$HOME}"
	fi
	# Time as Hour:Minute format.
	local clock=$(date +"%H:%M")
	# "/bin/bash" but skips "/bin/".
	local shell="bash"
	# Get the current branch name and set color theme
	set_theme
	local branch_name=$(git branch --show-current 2>/dev/null)
	local changes=$(git diff --name-only 2>/dev/null | wc -l 2>/dev/null)
	if [ "$changes" == "0" ]; then
		git1=$git1
		git2=$git2
	else
		git1=$git_err1
		git2=$git_err2
	fi
	exit_prompt=""
	if [ $exit != "0" ]; then
		exit_prompt="${exit1}${circle_left}${exit2}${exit_ico} ${exit}${exit1}${circle_right}\e[0m"
	fi
	local right="${exit_prompt} ${clock1}${circle_left}${clock2}${clock_ico}  ${clock}${clock1}${circle_right}\e[0m"
	if [ -z "$branch_name" ]; then
		# No branch, not in a git repo
		local left=" ${shell1}${circle_left}${shell2}${shell_ico}  ${shell}${shell1}${circle_right}\e[0m \
${user1}${circle_left}${user2}${user_ico}  ${USER}${user1}${circle_right}\e[0m \
${dir1}${circle_left}${dir2}${dir_ico}  ${dir}${dir1}${circle_right}\e[0m"
	else
		# Branch exist, print that branch and change color to indicate state.
		local left=" ${shell1}${circle_left}${shell2}${shell_ico}  ${shell}${shell1}${circle_right}\e[0m \
${user1}${circle_left}${user2}${user_ico}  ${USER}${user1}${circle_right}\e[0m \
${git1}${circle_left}${git2}${git_ico} ${branch_name}${git1}${circle_right}\e[0m \
${dir1}${circle_left}${dir2}${dir_ico}  ${dir}${dir1}${circle_right}\e[0m"
	fi
	# Get column count to calculate prompt size
	local columns=$(tput cols)
	local plain_left=$(echo -e "${left}" | sed -r 's/\x1B\[[0-9;]*[a-zA-Z]//g')
	local plain_right=$(echo -e "${right}" | sed -r 's/\x1B\[[0-9;]*[a-zA-Z]//g')
	local space_count=$((columns - ${#plain_left} - ${#plain_right}))
	local spaces=$(printf '%*s' ${space_count})
	PS1=$(printf "$left$spaces$right\n  \uF101 ")
}

PROMPT_COMMAND=update_ps1
