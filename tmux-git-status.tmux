#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

git_status="#($CURRENT_DIR/scripts/git_status.sh)"
placeholder="\#{git_status}"

source $CURRENT_DIR/scripts/shared.sh

function do_interpolation() {
  local string="$1"
  local interpolated="${string/$placeholder/$git_status}"
  echo "$interpolated"
}

function update_tmux_option() {
  local option="$1"
  local option_value="$(get_tmux_option "$option")"
  local new_option_value="$(do_interpolation "$option_value")"
  set_tmux_option "$option" "$new_option_value"
}

function update_tmux_window_option() {
  local option="$1"
  local option_value="$(get_tmux_window_option "$option")"
  local new_option_value="$(do_interpolation "$option_value")"
  set_tmux_window_option "$option" "$new_option_value"
}

function main() {
  update_tmux_option "status-left"
  update_tmux_option "status-right"
  update_tmux_window_option "pane-border-format"
}

main
