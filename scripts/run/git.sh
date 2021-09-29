#!/usr/bin/env bash

function git:help {
  cat <<EOF

Git commands:
  git:commit:lint-latest      Lint latest git commit message
EOF
}

function git:commit:lint-latest {
  local commit_author
  local commit_message

  commit_author=$(git log -1 --pretty=format:"%an")

  if [[ "${commit_author}" == "dependabot[bot]" ]]; then
    # NOTE: Dependabot is not flexible to apply commitlint rules
    # see: https://github.com/dependabot/dependabot-core/issues/1666
    # see: https://github.com/dependabot/dependabot-core/issues/2056
    warning "SKIPPED ${FUNCNAME[0]}: Dependabot is author of latest commit"

    close
  fi

  commit_message=$(git log -1 --pretty=format:"%s")

  echo "${commit_message}" | npx commitlint --color
}
