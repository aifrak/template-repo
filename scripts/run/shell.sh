#!/usr/bin/env bash

shell_scripts_globs=(
  ./run
  ./scripts/**/*.sh
)

function shell:help {
  cat <<EOF

Shell commands:
  shell:format                Format given Shell scripts
  shell:lint                  Lint given Shell scripts
EOF
}

function shell:lint {
  shellcheck -x "${@:-${shell_scripts_globs[@]}}"
}

function shell:format {
  shfmt -w "${@:-${shell_scripts_globs[@]}}"
}
