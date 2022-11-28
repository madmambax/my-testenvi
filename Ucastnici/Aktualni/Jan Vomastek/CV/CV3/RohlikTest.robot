*** Settings ***
Library     Browser

*** Test Cases ***
Start new page
    New Browser     chromium  headless=false
    New Context     viewport={'width': 1920, 'height': 1080}
    New Page        https://www.rohlik.cz
    Get Title       ==  Online supermarket Rohlik.cz — nejrychlejší doručení ve městě
    Get Title       *=  Rohlik
    Get Title       !=  Ahoj

    Click           id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll

#    Click    id=headerLogin
#    Click    xpath=//*[@id="headerLogin"]
    Click           data-test=header-user-icon
#    Click    "Přihlásit"
    Fill Text       xpath=//*[@id="email"]         ahoj@ahoj.cz
    Fill Secret     xpath=//*[@id="password"]      tajneheslo
    Click           data-test=btnSignIn
    Sleep           5s









#    Click    text="Hledat"
#    Click    "Hledat"
#    Click    css=.sc-4b6d3da4-2
#    Click    css=[type="submit"]
#    Click    xpath=//*[@id="searchForm"]/button
#
#    Click    css=[data-test="header-search-button"]
#    Click    data-test=header-search-button