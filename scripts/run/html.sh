#!/usr/bin/env bash

function html:help {
  cat <<EOF

CSS commands:
  html:lint                   Lint HTML files and templates
EOF
}

function html:lint {
  local ignore_globs=(
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
