#!/usr/bin/env sh

# Inspired from:
# - https://ivantanev.com/safer-coding-with-husky-hooks/
# - https://github.com/TomHerman11/npm-install-or-yarn-after-git-merge-checkout-rebase

# For multiple files, use "\|" as separator: "file1\|file2"
run_cmd_when_changed_files() {
  files="$1"
  cmd="$2"
  diff="$3"

  if (echo "$diff") | grep --quiet "^$files"; then
    echo "Git Hook - Command to execute: '$cmd'"
    eval "($cmd)"
    echo "Git Hook - Command executed with success"
  fi
}
