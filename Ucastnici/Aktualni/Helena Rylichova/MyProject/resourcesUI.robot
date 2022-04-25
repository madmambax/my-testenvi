*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               domain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library           Browser

*** Variables ***
${BROWSER}              chromium
${WU_URL_NIGHTLY}       https://nightly.webuntis.com/
${WU_URL_STAGING}       https://tom.staging.webuntis.com/
${HELP_CENTER_URL}      https://help.untis.at/hc/de/articles/4403307948434
${SCHOOL_NIGHTLY_HRY}   nightlyhry
${SCHOOL_NIGHTLY_API}   nightlyautoapi
${VALID USER}           admin
${VALID PASSWORD}       admin
${INVALID USER}         wrongUsername
${INVALID PASSWORD}     wrongPassword


*** Keywords ***
Open Browser To Login Page
   New Browser    chromium    headless=false
   New Page       ${WU_URL_NIGHTLY}

Open Particular School
   click            id=school
   type text        input#school    ${SCHOOL_NIGHTLY_HRY}
   click            css=body > div > form > p:nth-child(6) > input
   sleep            2
   get url          *=  index.do#/basic/login

Insert invalid Credentials
    type text               xpath=//div[@id='app']/div/div[@class='redesigned-main']/div[@class='content-container']/div[@class='widget-section']//form[@class='un-form']/div[@class='un-input-group un2-utils__mb-1']//label[@class='un-input-group__label']       ${INVALID USER}
    type text               xpath=//div[@id='app']/div/div[@class='redesigned-main']/div[@class='content-container']/div[@class='widget-section']//form[@class='un-form']/div[@class='un-input-group']//label[@class='un-input-group__label']                       ${VALID PASSWORD}
    click                   xpath=//div[@id='app']/div/div[@class='redesigned-main']/div[@class='content-container']/div[@class='widget-section']//form[@class='un-form']/button[@type='submit']
    get element             xpath=//div[@id='login-form-errors']/div[@class='un2-login-form__error-message']
    take screenshot
    type text               xpath=//div[@id='app']/div/div[@class='redesigned-main']/div[@class='content-container']/div[@class='widget-section']//form[@class='un-form']/div[@class='un-input-group un2-utils__mb-1']//label[@class='un-input-group__label']       ${VALID USER}
    type text               xpath=//div[@id='app']/div/div[@class='redesigned-main']/div[@class='content-container']/div[@class='widget-section']//form[@class='un-form']/div[@class='un-input-group']//label[@class='un-input-group__label']                       ${INVALID PASSWORD}
    click                   xpath=//div[@id='app']/div/div[@class='redesigned-main']/div[@class='content-container']/div[@class='widget-section']//form[@class='un-form']/button[@type='submit']
    get element             xpath=//div[@id='login-form-errors']/div[@class='un2-login-form__error-message']
    take screenshot
    type text               xpath=//div[@id='app']/div/div[@class='redesigned-main']/div[@class='content-container']/div[@class='widget-section']//form[@class='un-form']/div[@class='un-input-group un2-utils__mb-1']//label[@class='un-input-group__label']       ${INVALID USER}
    type text               xpath=//div[@id='app']/div/div[@class='redesigned-main']/div[@class='content-container']/div[@class='widget-section']//form[@class='un-form']/div[@class='un-input-group']//label[@class='un-input-group__label']                       ${INVALID PASSWORD}
    click                   xpath=//div[@id='app']/div/div[@class='redesigned-main']/div[@class='content-container']/div[@class='widget-section']//form[@class='un-form']/button[@type='submit']
    get element             xpath=//div[@id='login-form-errors']/div[@class='un2-login-form__error-message']
    take screenshot

Insert valid Credentials
    type text               xpath=//div[@id='app']/div/div[@class='redesigned-main']/div[@class='content-container']/div[@class='widget-section']//form[@class='un-form']/div[@class='un-input-group un2-utils__mb-1']//label[@class='un-input-group__label']           ${VALID USER}
    type text               xpath=//div[@id='app']/div/div[@class='redesigned-main']/div[@class='content-container']/div[@class='widget-section']//form[@class='un-form']/div[@class='un-input-group']//label[@class='un-input-group__label']                           ${VALID PASSWORD}
    click                   xpath=//div[@id='app']/div/div[@class='redesigned-main']/div[@class='content-container']/div[@class='widget-section']//form[@class='un-form']/button[@type='submit']
    sleep                   2
    get url                 *=  webuntis.com/today
    get element             xpath=//*[@id="root"]/div/div[1]/div[1]/div[1]/div[1]/div[2]/div[2]

Platform - Main Page assertion
    click                   xpath=/html//div[@id='root']/div[@class='app menu-expanded show-legacy-webuntis']/div[@class='untis-navigation-bar']//a[@href='/messages-of-the-day']//div[@class='item-name']
    click                   xpath=/html//div[@id='root']/div[@class='app menu-expanded show-legacy-webuntis']/div[@class='untis-navigation-bar']//a[@href='/platform-overview']//div[@class='item-name']
    get element             xpath=/html//main[@id='layout-main']/div[@class='page']//div[@class='platform-list']
    get text                text=WebUntis Platform enables the integration of applications of other providers. Tap "+" to see a list of available integrations.
    get element             xpath=/html//main[@id='layout-main']/div[@class='page']/div[@class='page-header-container']//a[@href='https://help.untis.at/hc/de/articles/4403307948434']