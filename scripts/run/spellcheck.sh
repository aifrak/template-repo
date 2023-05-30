#!/usr/bin/env bash

function help:spellcheck {
  cat <<EOF

Spellcheck commands:
  lint:spellcheck     Run spellcheck
EOF
}

function lint:spellcheck {
  npx cspell lint \
    --cache \
    --color \
    --dot \
    --no-progress \
    --no-must-find-files \
    --relative \
    --show-context "${@:-"**"}"
}
