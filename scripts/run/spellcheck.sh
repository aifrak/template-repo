#!/usr/bin/env bash

function spellcheck:help {
  cat <<EOF

Spellcheck commands:
  spellcheck:lint             Run spellcheck
EOF
}

function spellcheck:lint {
  npx cspell lint \
    --cache \
    --color \
    --no-progress \
    --no-must-find-files \
    --relative \
    --show-context "${@:-"{**,**/.*,**/.*/**}"}"
}
