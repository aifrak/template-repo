// @ts-nocheck
/**
 * Custom plugin to calculate the next CalVer.
 *
 * Replace https://github.com/casmith/release-it-calver-plugin because
 * it does not support "MODIFIER" (alpha, beta, rc, dev)
 *
 * Inspired from on https://github.com/release-it/conventional-changelog/blob/5.0.0/index.js
 */

/* eslint import/no-extraneous-dependencies: ["error", {"devDependencies": true}] */
import calver from 'calver';
// eslint-disable-next-line import/no-unresolved
import { Plugin } from 'release-it';

const DEFAULT_LEVEL = 'minor';
const DEFAULT_FORMAT = `yyyy.mm.${DEFAULT_LEVEL}`;
const DEFAULT_RELEASE_TYPE = `calendar.${DEFAULT_LEVEL}`;

// Values used from "calver" package
const LEVEL_SEPARATOR = '.';
const MODIFIERS = new Set(['alpha', 'beta', 'dev', 'rc']);

export default class CalverBumper extends Plugin {
  /* ———————————————————————————————————————————— */
  /*          Implement Plugin interfaces         */
  /* ———————————————————————————————————————————— */

  getIncrementedVersion(options) {
    return this.getRecommendedVersion(options);
  }

  getIncrementedVersionCI(options) {
    return this.getIncrementedVersion(options);
  }

  getIncremented(options) {
    return this.getIncrementedVersion(options);
  }

  /* ———————————————————————————————————————————— */
  /*                Class functions               */
  /* ———————————————————————————————————————————— */

  getRecommendedVersion({ increment, latestVersion, isPreRelease, preReleaseId }) {
    const { log } = this;
    let releaseType = DEFAULT_RELEASE_TYPE;

    if (increment) {
      log.warn(`The recommended bump is "${releaseType}", but is overridden with "${increment}".`);
      releaseType = increment;
    }

    releaseType = CalverBumper.getReleaseTypeIfPreRelease(releaseType, isPreRelease, preReleaseId);

    calver.validateLevels(releaseType);

    return CalverBumper.incrementCalver(releaseType, latestVersion);
  }

  static getReleaseTypeIfPreRelease(releaseType, isPreRelease, preReleaseId) {
    if (isPreRelease) {
      return preReleaseId ? `calendar.${preReleaseId}` : 'calendar.rc';
    }

    return releaseType;
  }

  /**
   * Increment the version using Calver versioning.
   *
   * Custom CalVer logic:
   * - Date is always incremented when a modifier is not given
   * - When date is same, "minor" or modifier are incremented according to the given level
   * - When date is different, "minor" and modifier are reset to 0
   * - "minor" is untouched when using a modifier
   */
  static incrementCalver(releaseType, latestVersion) {
    const newVersion = CalverBumper.newCalendarVersion();
    const latestVersionWithoutModifier = latestVersion.split('-')[0];

    const isSameDate = CalverBumper.isSameDate(newVersion, latestVersionWithoutModifier);

    if (CalverBumper.getModifierFromLevel(releaseType)) {
      return CalverBumper.incrementModifier(isSameDate ? latestVersion : newVersion, releaseType);
    }

    if (isSameDate) {
      return CalverBumper.incrementDefaultLevel(latestVersionWithoutModifier);
    }

    return newVersion;
  }

  static newCalendarVersion() {
    return calver.inc(DEFAULT_FORMAT, '', 'calendar');
  }

  static incrementDefaultLevel(version) {
    return calver.inc(DEFAULT_FORMAT, version, DEFAULT_LEVEL);
  }

  static incrementModifier(version, releaseType) {
    return calver.inc(DEFAULT_FORMAT, version, releaseType);
  }

  static getModifierFromLevel(releaseType) {
    return releaseType
      .split(LEVEL_SEPARATOR)
      .filter((level) => MODIFIERS.has(level))
      .pop();
  }

  static isSameDate(version1, version2) {
    const parsedVersion1 = CalverBumper.parsedVersion(version1);
    const parsedVersion2 = CalverBumper.parsedVersion(version2);

    return JSON.stringify(parsedVersion1.calendar) === JSON.stringify(parsedVersion2.calendar);
  }

  static parsedVersion(latestVersion) {
    const levels = calver.validateLevels(DEFAULT_LEVEL);
    const format = calver.validateFormat(DEFAULT_FORMAT, levels);

    return calver.parseVersion(latestVersion, format, levels);
  }
}
