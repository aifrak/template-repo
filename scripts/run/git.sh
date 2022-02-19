#!/usr/bin/env bash

function git:help {
  cat <<EOF

Git commands:
  git:commit:lint                       Lint git commit message
  git:commit:is-contributor-dependabot  Check if Dependabot is (co-)author of the commit
EOF
}

# NOTE: Dependabot is not flexible to apply commitlint rules
# see: https://github.com/dependabot/dependabot-core/issues/1666
# see: https://github.com/dependabot/dependabot-core/issues/2056
function git:commit:lint {
  local commit_message

  if git:commit:is-contributor-dependabot; then
    warning "SKIPPED './run ${FUNCNAME[0]}': Dependabot is (co-)author of latest commit"

    close
  fi

  commit_message=$(git log -1 --pretty=format:"%s")

  echo "${commit_message}" | npx commitlint --color
}

function git:commit:is-contributor-dependabot {
  is_author_dependabot || is_co_author_dependabot
}

function is_author_dependabot {
  local commit_author
  local dependabot_name="dependabot[bot]"

  commit_author=$(git log -1 --pretty=format:"%an")

  [[ "${commit_author}" == "${dependabot_name}" ]]
}

function is_co_author_dependabot {
  local commit_co_author
  local dependabot_name="dependabot[bot]"

  commit_co_author=$(git log -1 --pretty=format:"%(trailers:key=Co-Authored-By,valueonly)")

  [[ "${commit_co_author}" == *"${dependabot_name}"* ]]
}
