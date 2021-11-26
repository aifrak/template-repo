#!/usr/bin/env bash

set -euo pipefail

changelog="CHANGELOG.md"
tag_cut_limit="<!-- changelog-header:end -->"

sed -i "1,/${tag_cut_limit}/d" "${changelog}"
