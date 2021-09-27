#!/usr/bin/env bash

css_globs="**/*.{css,less,sass,scss}"

function css:help {
  cat <<EOF

CSS commands:
  css:format                  Format SCSS, Sass, Less and all files containing CSS
  css:lint                    Lint SCSS, Sass, Less and all files containing CSS
EOF
}

function css:lint {
  npx stylelint \
    --color \
    --allow-empty-input \
    --cache \
    "${@:-${css_globs}}"
}

function css:format {
  npx stylelint \
    --color \
    --allow-empty-input \
    --cache \
    --fix \
    "${@:-${css_globs}}"
}
