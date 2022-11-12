// @ts-check

/** @type {import('@playwright/test').PlaywrightTestConfig} */
const config = {
  retries: 1,
  use: {
    trace: 'on-first-retry',
  },
};

module.exports = config;