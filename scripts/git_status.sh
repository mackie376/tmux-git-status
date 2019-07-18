#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $CURRENT_DIR/shared.sh

PANE_PATH=$(tmux display-message -p -F "#{pane_current_path}" -t0)
cd $PANE_PATH

function git_changes() {
  local changes=$(git diff --shortstat | sed 's/^[^0-9]*\([0-9]*\)[^0-9]*\([0-9]*\)[^0-9]*\([0-9]*\)[^0-9]*/\1;\2;\3/')
  local changes_array=(${changes//;/ })
  local result=()

  if [[ -n ${changes_array[0]} ]]; then
    result+=("~${changes_array[0]}")
  fi
  if [[ -n ${changes_array[1]} ]]; then
    result+=("+${changes_array[1]}")
  fi
  if [[ -n ${changes_array[2]} ]]; then
    result+=("-${changes_array[2]}")
  fi

  local joined=$(printf " %s" "${result[@]}")
  local joined=${joined:1}

  if [[ -n $joined ]]; then
    echo "$joined"
  fi
}

function git_status() {
  if in_git_repo; then
    local status=$(git rev-parse --abbrev-ref HEAD)
    local changes=$(git_changes)
    printf "$status $changes"
  else
    printf "(not in repos)"
  fi
}

main() {
  git_status
}

main
