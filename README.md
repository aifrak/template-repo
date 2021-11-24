# Template repository

This is a template repository.

[![CI](https://github.com/aifrak/template-repo/actions/workflows/ci.yml/badge.svg)](https://github.com/aifrak/template-repo/actions/workflows/ci.yml)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg)](https://conventionalcommits.org)
[![Commitizen friendly](https://img.shields.io/badge/commitizen-friendly-brightgreen.svg)](http://commitizen.github.io/cz-cli/)
[![License](https://img.shields.io/github/license/aifrak/template-repo?color=blue)](https://github.com/aifrak/template-repo/blob/master/LICENSE)

After cloning this template repository:

- Rework the content of `README.md`
- Rename the project with this command:

```bash
bash ./scripts/rename_project.sh [PROJECT_NAME] [OWNER_NAME]
```

- [Create a Personal Access Token (PAT)](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)
  with all scopes for `repo` checked
- Add a new action secret named `PAT_PR_AUTO_MERGE` with the value of the PAT

## License

[MIT License](https://github.com/aifrak/template-repo/blob/main/LICENSE)
