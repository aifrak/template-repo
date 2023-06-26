#!/usr/bin/env bash

shell_scripts_globs=(
  .husky/commit-msg
  .husky/helpers/*.sh
  .husky/post-*
  .husky/pre-*
  run
  scripts/**/*.sh
)

function help:shell {
  cat <<EOF

Shell commands:
  format:shell        Format given Shell scripts
  lint:shell          Lint given Shell scripts
EOF
}

function lint:shell {
  shellcheck -x "${@:-${shell_scripts_globs[@]}}"
}

function format:shell {
  shfmt -w "${@:-${shell_scripts_globs[@]}}"
}
