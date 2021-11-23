const assert = require('assert');
const CalverBumper = require('../../plugins/calver-bumper');

// Fixed timestamp for testing
// 1637580780451: 22 Nov 2021
Date.now = function now() {
  return 1_637_580_780_451;
};

/* ———————————————————————————————————————————— */
/*       Date different than current date       */
/* ———————————————————————————————————————————— */

// Test increment
assert.strictEqual(CalverBumper.incrementCalver('calendar.minor', '2020.10.0'), '2021.11.0');

// Test increment date with reset "minor"
assert.strictEqual(CalverBumper.incrementCalver('calendar.minor', '2020.10.1'), '2021.11.0');

// Test increment date with reset "minor" and removed modifier
assert.strictEqual(
  CalverBumper.incrementCalver('calendar.minor', '2020.10.0-alpha.0'),
  '2021.11.0'
);

// Test increment date with added modifier and reset "minor"
assert.strictEqual(
  CalverBumper.incrementCalver('calendar.alpha', '2020.10.0'),
  '2021.11.0-alpha.0'
);

// Test increment date with reset "minor" and modifier
assert.strictEqual(
  CalverBumper.incrementCalver('calendar.alpha', '2020.10.1-alpha.1'),
  '2021.11.0-alpha.0'
);

// Test increment date and modifier level with reset "minor"
assert.strictEqual(
  CalverBumper.incrementCalver('calendar.beta', '2020.10.1-alpha.0'),
  '2021.11.0-beta.0'
);

// Test increment date and modifier level with reset "minor" and modifier
assert.strictEqual(
  CalverBumper.incrementCalver('calendar.beta', '2020.10.1-alpha.1'),
  '2021.11.0-beta.0'
);

/* ———————————————————————————————————————————— */
/*           Date same as current date          */
/* ———————————————————————————————————————————— */

// Test increment "minor"
assert.strictEqual(CalverBumper.incrementCalver('calendar.minor', '2021.11.1'), '2021.11.2');

// Test reset modifier
assert.strictEqual(
  CalverBumper.incrementCalver('calendar.minor', '2021.11.0-alpha.0'),
  '2021.11.1'
);

// Test reset modifier and increment "minor"
assert.strictEqual(
  CalverBumper.incrementCalver('calendar.minor', '2021.11.1-alpha.0'),
  '2021.11.2'
);

// Test add modifier
assert.strictEqual(
  CalverBumper.incrementCalver('calendar.alpha', '2021.11.0'),
  '2021.11.0-alpha.0'
);

// Test increment modifier only
assert.strictEqual(
  CalverBumper.incrementCalver('calendar.alpha', '2021.11.1-alpha.1'),
  '2021.11.1-alpha.2'
);
// Test increment modifier level only
assert.strictEqual(
  CalverBumper.incrementCalver('calendar.beta', '2021.11.1-alpha.1'),
  '2021.11.1-beta.0'
);
