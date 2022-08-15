#!/usr/bin/env bash

function help:prettier {
  cat <<EOF

Prettier commands:
  format:prettier             Format files handled by Prettier
  lint:prettier               Lint files handled by Prettier
EOF
}

function lint:prettier {
  npx prettier --check "${@:-.}"
}

function format:prettier {
  npx prettier --list-different --write "${@:-.}"
}
