# Code convention

## Git commit messages

Commit messages must follow the specification from [Conventional Commits](https://www.conventionalcommits.org).

To help you to choose the right `type` or `scope`, you can commit:

- from the dedicated extension in `Source Control` tab of `vscode`
- from the terminal via `commitizen` with the command `npx cz`

## run

### Function names

- Use `:` to separate scopes
- Use `-` (kebab-case) for scope names or purposes

```shellscript
function dev:dotnet-core:global-install {
  ...
}
```

In the above example, `dev` and `dotnet-core` are scopes and separated by `:`.
