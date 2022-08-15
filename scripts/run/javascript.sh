#!/usr/bin/env bash

function help:js {
  cat <<EOF

Javascript commands:
  format:js                  Format JS files and any files containing Javascript
  lint:js                    Lint JS files and any files containing Javascript
EOF
}

function lint:js {
  npx eslint \
    --cache \
    --color \
    --format pretty \
    --max-warnings 0 \
    --no-error-on-unmatched-pattern \
    "${@:-.}"
}

function format:js {
  npx eslint \
    --fix \
    --fix-type layout \
    --cache \
    --color \
    --format pretty \
    --max-warnings 0 \
    --no-error-on-unmatched-pattern \
    "${@:-.}"
}
