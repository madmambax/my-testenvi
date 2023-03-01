*** Settings ***
Library  Browser

*** Variables ***
${pnastane}  Toje Test

*** Test Cases ***

#Starting a browser with a page
#    New Browser    chromium    headless=false
#    New Context    viewport={'width': 1920, 'height': 1080}
#    New Page       https://marketsquare.github.io/robotframework-browser/Browser.html
#    Get Title      ==    Browser

Starting a browser with a page
    New Browser    chromium    headless=false
    New Context    viewport={'width': 1920, 'height': 1080}
    New Page       https://rohlik.cz
    Get Title      contains    Rohlik
    Click          id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    Sleep          5
    Click          data-test=header-user-icon
    Type Text      id=email    mar.man@post.cz


Start browser page google
    New Browser    firefox    headless=false
    New Page       https://google.com
    Get Title      contains    Google
    Sleep          5
    Click          xpath=//*[@id="L2AGLb"]/div
    Sleep          5
    Click          xpath=//*[@id="gb"]/div/div[2]/a
    Sleep          5
    Type Text      xpath=//*[@id="identifierId"]      tojetester23@gmail.com
    Sleep          5
    Click          id=identifierNext
    Sleep          10
    Type Text      xpath=//*[@id="password"]/div[1]/div/div[1]/input   Patriot2023!
    Sleep          5
    Click          id=passwordNext
    Sleep          5
    Get Text       text="${pnastane}"

# fail cannot select cookies
Start browser page seznam
    New Browser    firefox    headless=false
    New Page       https://seznam.cz
    Get Title      contains  Seznam
    Click          css=[data-testid="button-agree"]
    Sleep          5


Start browser page czc
    New Browser    chromium    headless=false
    New Page       https://czc.cz
    Get Title      contains  CZC
    Click          xpath=//*[@id="ccp-popup"]/div/div[2]/button[3]
    Sleep          5
    Click          id=login
    Sleep          5