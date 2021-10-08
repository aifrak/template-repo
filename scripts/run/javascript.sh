#!/usr/bin/env bash

function js:help {
  cat <<EOF

Javascript commands:
  js:format                  Format JS files and any files containing Javascript
  js:lint                    Lint JS files and any files containing Javascript
EOF
}

function js:lint {
  npx eslint \
    --cache \
    --color \
    --format pretty \
    --max-warnings 0 \
    --no-error-on-unmatched-pattern \
    "${@:-.}"
}

function js:format {
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
