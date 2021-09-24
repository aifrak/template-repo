#!/usr/bin/env bash

function git:help {
  cat <<EOF

Git commands:
  git:commit:lint-latest      Lint latest git commit message
EOF
}

function git:commit:lint-latest {
  local commit_message

  commit_message=$(git log -1 --pretty=format:"%s")

  echo "${commit_message}" | npx commitlint --color
}
