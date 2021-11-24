# Code convention

## Git workflow

The follow git workflow is [Scaled Trunk-Based Development](https://trunkbaseddevelopment.com).

1. `main` is the only long-lived branch
1. All other branches are short-lived branches

## Git commit messages

Commit messages must follow the specification from [Conventional Commits](https://www.conventionalcommits.org).

To help you to choose the right `type` or `scope`, you can commit:

- from the dedicated extension in `Source Control` tab of `vscode`
- from the terminal via `commitizen` with the command `npx cz`

## run

### Function names

- Use `:` to separate scopes
- Use `-` (kebab-case) for scope names or purposes
- Use `_` (snake_case) for helper functions that should not directly be used by
  the CLI

```shellscript
function dev:dotnet-core:global-install {
  ...
}
```

In the above example, `dev` and `dotnet-core` are scopes and separated by `:`.
