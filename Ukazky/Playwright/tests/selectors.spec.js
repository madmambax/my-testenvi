const { test, expect } = require('@playwright/test');
const assert = require('assert')

test('Alza login test', async ({ page }) => {
  await page.goto('https://alza.cz/');
//  const title = page.locator('.navbar__inner .navbar__title');
//  await expect(title).toHaveText('Alza');

  // Click text=Přihlásit
//  await page.click('text=Přihlásit');

//  // Click [placeholder="@"]
//  await page.frame({
//    name: 'loginIframe'
//  }).click('[placeholder="@"]');

  const visibleBooksSelector = 'text=Přihlásit'
  const visibleBooks = await page.$$(visibleBooksSelector)
  console.log('Ahoj');
  console.log(visibleBooks);

  assert.equal(visibleBooks.length, 1)

  // Fill [placeholder="@"]
  await page.fill('#userName', 'login')
//  await page.frame({ name: 'loginIframe'}).fill('[placeholder="@"]', 'login');




});