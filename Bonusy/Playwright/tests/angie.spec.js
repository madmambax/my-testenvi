//const { chromium } = require('@playwright/test')
//const assert = require('assert')
//
//describe('Automation Bookstore', function () {
//    let browser,  page
//
//    before(async () => {
//        browser = await chromium.launch()
//    })
//    after(async () => {
//        await browser.close()
//    })
//
//    beforeEach(async () => {
//        page = await browser.newPage()
//        await page.goto('https://automationbookstore.dev/')
//    })
//    afterEach(async () => {
//        await page.close()
//    })
//
//    it('should have title', async () => {
//        assert.equal(await page.innerText('#page-title'), 'Automation Bookstore')
//    })
//})