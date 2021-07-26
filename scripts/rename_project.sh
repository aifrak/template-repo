#!/usr/bin/env bash

set -euo pipefail

# Command:
#   bash ./scripts/rename_project.sh [PROJECT_NAME] [OWNER_NAME]
#
# Use it only once to rename the project and the owner in all files, after
# cloning the repository.
# This file will be automatically deleted after its execution.

function rename {
  old_value=${1}
  new_value=${2}

  grep -rl "${old_value}" . --exclude-dir={.git,.history,node_modules} \
    | xargs sed -i "s/${old_value}/${new_value}/g"
}

old_project_name="template-repo"
old_owner="aifrak"
new_project_name=${1:-${old_project_name}}
new_owner=${2:-${old_owner}}

rename "${old_project_name}" "${new_project_name}"
rename "${old_owner}" "${new_owner}"

echo "Project and owner renamed!"

rm "${0}"

echo "Delete ${0}"
