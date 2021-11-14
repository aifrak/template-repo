// CalVer date tags 0Y, 0M, 0W and 0D are not supported by "@release-it/bumper"
// and "@release-it/conventional-changelog".
// Reason: Those plugins support semver only.

const { readFileSync } = require('fs');
const commitGroupsSort = require('./scripts/release-it/plugins/conventional-changelog/commit-groups-sort');
const types = require('./scripts/release-it/types');

const scriptsPath = './scripts/release-it';
const hooksPath = `${scriptsPath}/hooks`;
const pluginsPath = `${scriptsPath}/plugins`;
const templatesPath = `${scriptsPath}/templates`;

module.exports = {
  git: {
    // eslint-disable-next-line no-template-curly-in-string
    commitMessage: 'chore: Release ${version}\n\n[skip ci]',
    requireBranch: 'main',
  },
  github: {
    release: true,
  },
  npm: false,
  hooks: {
    'before:conventional-changelog:beforeRelease': `sh ${hooksPath}/changelog/delete_header.sh`,
    'after:conventional-changelog:beforeRelease': `sh ${hooksPath}/changelog/add_header.sh`,
  },
  plugins: {
    '@release-it/bumper': {
      in: {
        file: 'VERSION',
        type: 'text/plain',
      },
      out: [
        {
          file: 'VERSION',
          type: 'text/plain',
        },
      ],
    },
    [`${pluginsPath}/calver-bumper.js`]: {},
    '@release-it/conventional-changelog': {
      infile: 'CHANGELOG.md',
      ignoreRecommendedBump: true,
      preset: {
        name: 'conventionalcommits',
        types,
      },
      writerOpts: {
        headerPartial: readFileSync(`${templatesPath}/header.hbs`, 'utf-8'),
        commitGroupsSort,
      },
    },
  },
};
