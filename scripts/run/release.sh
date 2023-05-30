#!/usr/bin/env bash

function help:release {
  cat <<EOF

Release commands:
  release                   Update CHANGELOG.md and version files, cut a release and publish to Github
  release:ci                Release from CI. If modifier given, it will prerelease.
    - Usage: release:ci [MODIFIER]
  release:dry-run           Simulate cutting a release without updating files or pushing to git
  prerelease                Cut a prerelease, tag with a suffix it and publish it to Github (default: dev)
    - Usage: prerelease [dev|alpha|beta|rc]
  test:release              Dry run release, run tests for release
  test:release:hooks        Run tests for hooks during a release
  test:release-it:custom    Run tests related to custom hooks and/or plugins for release-it
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
  release \
    --dry-run \
    --no-git.requireBranch \
    --no-git.requireCleanWorkingDir \
    --no-git.requireUpstream \
    --git.pushRepo="git://fake.host.for.dry.run/user/repo"
}

function test:release {
  test:release-it:custom
  release:dry-run
  test:release:hooks
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

function test:release-it:custom {
  for path in ./scripts/release-it/tests/**/*.test.js; do
    node "${path}"
  done
}

function test:release:hooks {
  for path in ./scripts/release-it/hooks/**/*.sh; do
    bash "${path}"
  done

  trap '$(reset_updated_files)' EXIT
}

function reset_updated_files {
  local updated_files=(
    CHANGELOG.md
  )

  git checkout -- "${updated_files[@]}"
}
