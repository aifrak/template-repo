#!/usr/bin/env bash

function release:help {
  cat <<EOF

Release commands:
  release                     Cut a release, tag it and publish it to Github
  release:ci                  Tag and cut a release from CI
  release:dry-run             Simulate cutting a release without updating files or pushing to git
  release:test                Dry run release, run tests for release
  release:hooks:test          Run tests for hooks during a release
  prerelease                  Cut a prerelease, tag with a suffix it and publish it to Github (default: dev)
  - Usage: prerelease [dev|alpha|beta|rc]
  release-it:custom:test      Run tests related to custom hooks and/or plugins for release-it
EOF
}

function release {
  npx release-it "${@}" --ci
}

function release:ci {
  local modifier=${1:-""}

  if [[ -n "${modifier}" ]]; then
    prerelease "${modifier}"
  else
    release
  fi
}

function release:dry-run {
  release --dry-run --no-git.requireBranch --no-git.requireCleanWorkingDir
}

function release:test {
  release-it:custom:test
  release:dry-run
  release:hooks:test
}

function prerelease {
  local modifier=${1:-"dev"}
  local allowed_modifiers="^(dev|alpha|beta|rc)$"

  # Format and possible options depend on "release-it" plugins
  if [[ ! "${modifier}" =~ ${allowed_modifiers} ]]; then
    alert_die "Unknown version modifier. Accepted values: dev, alpha, beta, rc"
  fi

  release "calendar.${modifier}" --github.preRelease
}

function changelog {
  release \
    --no-git.commit \
    --no-git.push \
    --no-git.tag \
    --no-git.requireBranch \
    --no-git.requireCleanWorkingDir
}

function release-it:custom:test {
  for path in ./scripts/release-it/tests/**/*.test.js; do
    node "${path}"
  done
}

function release:hooks:test {
  function reset_updated_files {
    local updated_files=(
      CHANGELOG.md
    )

    git checkout -- "${updated_files[@]}"
  }

  for path in ./scripts/release-it/hooks/**/*.sh; do
    bash "${path}"
  done

  trap '$(reset_updated_files)' EXIT
}
