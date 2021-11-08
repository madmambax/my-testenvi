//const { test, expect } = require('@playwright/test');
const { firefox } = require('@playwright/test');  // Or 'chromium' or 'webkit'.

test('basic test', async ({ page }) => {
  const browser = await firefox.launch();
//  const page = await browser.newPage();
  await page.goto('https://www.google.com/chrome/browser/canary.html');
  dumpFrameTree(page.mainFrame(), '');
  await browser.close();

  function dumpFrameTree(frame, indent) {
    console.log(indent + frame.url());
    for (const child of frame.childFrames()) {
      dumpFrameTree(child, indent + '  ');
    }
  }
});


//test('basic test', async ({ page }) => {
//    dumpFrameTree(page.mainFrame(), '');
//});