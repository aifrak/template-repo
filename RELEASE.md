# Release

Releases are cut from the `main` branch only.

_Versioning convention_: [Calendar Versioning (CalVer)](https://calver.org/)
_Format_: `YYYY.MM.MINOR`
_Possible modifiers_:

- Empty
- `dev` for releases as development or prealpha
- `alpha`
- `beta`
- `rc` for releases as release candidate

Examples:

- Empty modifier: `2021.11.64`
- `alpha` modifier: `2021.11.64-alpha`

## How to publish a release? 🤔

1. Go to the repository on `github.com`
1. Click on `Actions`
1. Click on `Release`
1. Click on `Run workflow`
1. Choose a version modifier suffix (optional). Possible values:
   - Let it empty for stable release. No modifier will be added.
   - `dev` for releases as development or prealpha
   - `alpha`
   - `beta`
   - `rc` for releases as release candidate
1. Click on `Run workflow`

This workflow uses [Release It!](https://github.com/release-it/release-it) to:

- update `VERSION`
- generate/update `CHANGELOG.md`
- commit and push to git
- attach assets to `Github Release`
- create a `Github Release`

## How `CHANGELOG.md` is updated? 📄

`CHANGELOG.md` is automatically by the plugin
[@release-it/conventional-changelog](https://github.com/release-it/conventional-changelog).

Custom templates under `./scripts/release-it` control the header text of the
file. The later has tag to distinguish the static header from the generated
lines.

## What is `VERSION`? 🤔

It contains the latest version.

In other words, it is the latest git tag. The version from this file is used to calculate
the next version.

This file and other files containing the application version are automatically
updated by [@release-it/bumper](https://github.com/release-it/bumper).
The later is supported by a custom `release-it` plugin (`calver-bumper.js`)
which calculate the next `CalVer`.
