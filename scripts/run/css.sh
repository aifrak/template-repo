#!/usr/bin/env bash

css_globs="**/*.{css,sass,scss}"

function help:css {
  cat <<EOF

CSS commands:
  format:css          Format CSS, SASS/SCSS files
  lint:css            Lint CSS, SASS/SCSS files
EOF
}

function lint:css {
  npx stylelint \
    --allow-empty-input \
    --color \
    --cache \
    "${@:-${css_globs}}"
}

function format:css {
  npx stylelint \
    --fix \
    --allow-empty-input \
    --color \
    --cache \
    "${@:-${css_globs}}"
}
