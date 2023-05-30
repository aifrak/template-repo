#!/usr/bin/env bash

function help:html {
  cat <<EOF

HTML commands:
  lint:html           Lint HTML files and templates
EOF
}

function lint:html {
  local ignore_globs=(
    **/.git/**
    **/.history/**
    **/node_modules/**
    **/npm_cache/**
  )

  local ignore_string="${ignore_globs[*]}"
  ignore_string="${ignore_string// /,}"

  npx htmlhint \
    --ignore "${ignore_string}" \
    "${@:-"**/*.{htm,html}"}"
}
