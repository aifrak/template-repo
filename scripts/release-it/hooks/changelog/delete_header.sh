#!/usr/bin/env bash

set -euo pipefail

changelog="CHANGELOG.md"
tag_cut_limit="<!-- changelog-header:end -->"

if [ -f "${changelog}" ]; then
  sed -i "1,/${tag_cut_limit}/d" "${changelog}"
fi
