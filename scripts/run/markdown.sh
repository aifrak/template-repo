#!/usr/bin/env bash

function help:markdown {
  cat <<EOF

Markdown commands:
  lint:markdown       Lint markdown files
EOF
}

function lint:markdown {
  npx markdownlint "${@:-.}"
}
