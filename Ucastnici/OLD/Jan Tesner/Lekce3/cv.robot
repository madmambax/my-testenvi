*** Settings ***
Library  Browser

*** Variables ***
${URL}      https://www.rohlik.cz/

*** Test Cases ***
Prihlaseni bad login
    Login               dsadsad@sdas.cz                    dasdas                 Přihlásit
Prihlaseni bad heslo
    Login               hemof56369@probdd.com              dasdas                 Přihlásit
Prihlaseni success
    Login               hemof56369@probdd.com              7Csa6aZfQUbagpJ        JT

*** Keywords ***
Login
    [Arguments]     ${pemail}      ${pheslo}     ${pnastane}

    log             ${pemail}
    log             ${pheslo}
    log             ${pnastane}

    #otevřít prohlížeč
    New Browser    chromium    headless=false
    #otevřít stránku rohlik.cz
    New Page       ${URL}
    #ověřit že se stránka otevřela
    Get Title      ==    Online supermarket Rohlik.cz — nejrychlejší doručení ve městě
    Click          id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    #kliknout na Přihlásit
    Click          data-test=IconUserLogin
    sleep          5
    #zadat email ${pemail} do místa pro zadání emailu
    Click          id=email
    Type Text      id=email  ${pemail}
    sleep          5
    #zadat heslo ${pheslo} do místa pro zadání hesla
    Click          id=password
    Type Text      id=password  ${pheslo}
    sleep          5
    #klinout na tlačítko "Přihlasit se"
    Click          data-test=btnSignIn
    sleep          5
    #ověřit že jsem přihlášený data-test=header-user-icon musí obsahovat to co je v ${pnastane}
    Get Text        data-test=header-user-icon  *=  ${pnastane}
    sleep          5





#Starting a browser with a page
#   New Browser    chromium    headless=false
#   New Page       https://www.rohlik.cz/
#
#   Get Title      ==    Online supermarket Rohlik.cz — nejrychlejší doručení ve městě
#   Get Title      !=    Ahoj
#   Get Title      *=    Online supermarket
#
#   Click    id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
#   Click    data-test=IconUserLogin
#   Click    text="Hledat"
#   Click    "Hledat"
#   Click    css=.sc-4b6d3da4-2
#   Click    css=[type="submit"]
#   Click    xpath=//*[@id="searchForm"]/button
#   Click    css=[data-test="header-search-button"]
#   Click    data-test=header-search-button
#   Click    "Přihlásit"
#   Click    id=headerLogin
#   Click    css=.sc-9c1ebddd-3