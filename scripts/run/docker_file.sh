#!/usr/bin/env bash

dockerfile_globs=(Dockerfile*)

function help:dockerfile {
  cat <<EOF

Dockerfile commands:
  format:dockerfile           Format all Dockerfiles
  lint:dockerfile             Lint all Dockerfiles
EOF
}

function lint:dockerfile {
  hadolint "${@:-${dockerfile_globs[@]}}"
}

function format:dockerfile {
  shfmt -w "${@:-${dockerfile_globs[@]}}"
}
