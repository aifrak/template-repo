#!/usr/bin/env bash

function css:help {
  cat <<EOF

CSS commands:
  css:lint                    Lint SCSS, Sass, Less and all files containing CSS
EOF
}

function css:lint {
  npx stylelint \
    --color \
    --allow-empty-input \
    --cache \
    "${@:-"**/*{.css,.less,.scss,.sass}"}"
}

function css:format {
  npx stylelint \
    --color \
    --allow-empty-input \
    --cache \
    --fix \
    "${@:-"**/*{.css,.less,.scss,.sass}"}"
}
