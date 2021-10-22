*** Settings ***
Library  Browser

*** Test Cases ***
Starting a browser with a page
    New Browser    chromium    headless=false

    New Page       https://www.rohlik.cz/
    Get Title      contains    Rohlik.cz

#    Click          text="Přihlásit"
#    Click          css=#headerLogin
#    Click          id=headerLogin
    Click          data-test=header-user-icon

    sleep   3