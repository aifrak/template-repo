# Template repository

This is a template repository.

[![CI](https://github.com/aifrak/template-repo/actions/workflows/ci.yml/badge.svg)](https://github.com/aifrak/template-repo/actions/workflows/ci.yml)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg)](https://conventionalcommits.org)
[![Commitizen friendly](https://img.shields.io/badge/commitizen-friendly-brightgreen.svg)](http://commitizen.github.io/cz-cli/)
[![License](https://img.shields.io/github/license/aifrak/template-repo?color=blue)](https://github.com/aifrak/template-repo/blob/master/LICENSE)

## Steps after cloning

After cloning this template repository:

- Rework the content of `README.md`
- Rename the project with this command:

```bash
bash ./scripts/rename_project.sh [PROJECT_NAME] [OWNER_NAME]
```

- [Create a Personal Access Token (PAT)](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)
  with all scopes for `repo` checked
- Add a new action secret named `PAT_GITHUB` with the value of the PAT

## Setup development environment

All information about the setup of the development environment can be found [here](docs/setup.md).

## Documentation

Most documentation are listed under the [docs](docs) directory.

To see the full list of available bash command, run this command:

```bash
./run help
```

## License

[MIT License](https://github.com/aifrak/template-repo/blob/main/LICENSE)
