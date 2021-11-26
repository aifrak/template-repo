#!/usr/bin/env bash

set -euo pipefail

header="./scripts/release-it/hooks/changelog/header-template.md"
changelog="CHANGELOG.md"
tmp_file="CHANGELOG.md.tmp"

cat "${header}" "${changelog}" >"${tmp_file}"
mv "${tmp_file}" "${changelog}"
