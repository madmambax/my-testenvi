*** Settings ***
Library     Browser


*** Test Cases ***

Starting a browser with a page
    New Browser    chromium    headless=false
    New Context
    New Page       https://www.rohlik.cz/vitejte


    # odklikne cookies
    Click       id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll


    #Click       text="Přihlásit"
    Click       id=headerLogin
    #Click       xpath=//*[@id="headerLogin"]
    #Click       data-test=IconUserLogin
    #Click       css=#headerLogin
    #Click       id=email
    Fill Text       id=email       dsadsad@sdas.cz
    Sleep       2