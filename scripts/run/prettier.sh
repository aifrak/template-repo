#!/usr/bin/env bash

function prettier:help {
  cat <<EOF

Prettier commands:
  prettier:format             Format files handled by Prettier
  prettier:lint               Lint files handled by Prettier
EOF
}

function prettier:lint {
  npx prettier --check "${@:-.}"
}

function prettier:format {
  npx prettier --list-different --write "${@:-.}"
}
