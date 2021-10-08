#!/usr/bin/env bash

css_globs="**/*.{css,less,sass,scss}"

function css:help {
  cat <<EOF

CSS commands:
  css:format                  Format CSS, SCSS, SASS, LESS and any files containing CSS
  css:lint                    Lint CSS, SCSS, SASS, LESS and any files containing CSS
EOF
}

function css:lint {
  npx stylelint \
    --allow-empty-input \
    --color \
    --cache \
    "${@:-${css_globs}}"
}

function css:format {
  npx stylelint \
    --fix \
    --allow-empty-input \
    --color \
    --cache \
    "${@:-${css_globs}}"
}
