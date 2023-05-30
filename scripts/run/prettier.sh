#!/usr/bin/env bash

function help:prettier {
  cat <<EOF

Prettier commands:
  format:prettier     Format files handled by Prettier
  lint:prettier       Lint files handled by Prettier
EOF
}

function lint:prettier {
  npx prettier \
    --cache \
    --cache-location="${APP_DIR}/.prettier-cache" \
    --check "${@:-.}"
}

function format:prettier {
  npx prettier \
    --cache \
    --cache-location="${APP_DIR}/.prettier-cache" \
    --list-different \
    --write "${@:-.}"
}
