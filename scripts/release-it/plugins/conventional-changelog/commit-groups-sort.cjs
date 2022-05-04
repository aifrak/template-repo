/**
 * Customize the order of commit groups done by conventional-changelog-writer
 * see https://github.com/conventional-changelog/conventional-changelog/tree/master/packages/conventional-changelog-writer
 *
 * Code from
 * https://github.com/conventional-changelog/conventional-changelog/blob/840d139c40a2c4e773794d794c34bc4dbfde27c2/packages/conventional-changelog-conventionalcommits/writer-opts.js#L160
 * but without the static array.
 */

const types = require('../../types.cjs');

function commitGroupsSort(a, b) {
  const groupA = a.title;
  const groupB = b.title;

  const indexA = types.findIndex((element) => element.section === groupA);
  const indexB = types.findIndex((element) => element.section === groupB);
  if (indexA >= indexB) {
    return 1;
  }
  return -1;
}

module.exports = commitGroupsSort;
