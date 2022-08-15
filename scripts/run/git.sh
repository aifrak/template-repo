#!/usr/bin/env bash

function help:git {
  cat <<EOF

Git commands:
  lint:git:commit                       Lint git commit message
  is-contributor-dependabot:git:commit  Check if Dependabot is (co-)author of the commit
EOF
}

# NOTE: Dependabot is not flexible to apply commitlint rules
# see: https://github.com/dependabot/dependabot-core/issues/1666
# see: https://github.com/dependabot/dependabot-core/issues/2056
function lint:git:commit {
  local commit_message

  if is-contributor-dependabot:git:commit; then
    warning "SKIPPED './run ${FUNCNAME[0]}': Dependabot is (co-)author of latest commit"

    close
  fi

  commit_message=$(git_log "%s")

  echo "${commit_message}" | npx commitlint --color
}

function is-contributor-dependabot:git:commit {
  is_author_dependabot || is_co_author_dependabot
}

# —————————————————————————————————————————————— #
#                Helper functions                #
# —————————————————————————————————————————————— #

function git_log() {
  local format="${1}"

  git log -1 --pretty=format:"${format}"
}

function is_author_dependabot {
  local commit_author
  local dependabot_name="dependabot[bot]"

  commit_author=$(git_log "%an")

  [[ "${commit_author}" == "${dependabot_name}" ]]
}

function is_co_author_dependabot {
  local commit_co_author
  local dependabot_name="dependabot[bot]"

  commit_co_author=$(git_log "%(trailers:key=Co-Authored-By,valueonly)")

  [[ "${commit_co_author}" == *"${dependabot_name}"* ]]
}
