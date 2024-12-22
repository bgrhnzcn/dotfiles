# Name of the first session.
session="Main"

# Variable to check $session already exist.
is_session_exist=$(tmux list-session | grep $session)

# If session not exist, create one.
if [ "$is_session_exist" == "" ]; then
	tmux new-session -d -s $session
fi

# Rename first window for terminal.
tmux rename-window -t 1 "Terminal"

# Check editor window existence and if not exist, create and run $EDITOR.
editor="Editor"
is_editor_exist=$(tmux list-windows | awk '{print $2}' | grep $editor)

# Create and open vim in new window.
if [ "$is_editor_exist" == "" ]; then
	tmux new-window -t $session:2 -n "Editor"
	tmux send-keys -t "Editor" $EDITOR C-m
fi

# Attach session.
tmux attach-session -t $session

