#/usr/bin/env bash

function get_tmux_option() {
  local option=$1
  local default_value=$2
  local option_value=$(tmux show-option -gqv "$option")
  if [[ -z "$option_value" ]]; then
    echo "$default_value"
  else
    echo "$option_value"
  fi
}

function set_tmux_option() {
  local option="$1"
  local value="$2"
  tmux set-option -gq "$option" "$value"
}

function get_tmux_window_option() {
  local option=$1
  local default_value=$2
  local option_value=$(tmux show-window-option -gv "$option")
  if [[ -z "$option_value" ]]; then
    echo "$default_value"
  else
    echo "$option_value"
  fi
}

function set_tmux_window_option() {
  local option="$1"
  local value="$2"
  tmux set-window-option -gq "$option" "$value"
}

function in_git_repo() {
  cd $(tmux display-message -p -F "#{pane_current_path}")
  local is_inside_work_tree=$(git rev-parse --is-inside-work-tree 2> /dev/null)
  [ "$is_inside_work_tree" == true ]
}
