#!/usr/bin/env bash

function markdown:help {
  cat <<EOF

Markdown commands:
  markdown:lint             Lint markdown files
EOF
}

function markdown:lint {
  npx markdownlint "${@:-.}"
}
