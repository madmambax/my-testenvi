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
    Logout              JT

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
    sleep          2
    Click          id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    #kliknout na Přihlásit
    Click          data-test=IconUserLogin
    sleep          2
    #zadat email ${pemail} do místa pro zadání emailu
    Click          id=email
    Type Text      id=email  ${pemail}
    sleep          2
    #zadat heslo ${pheslo} do místa pro zadání hesla
    Click          id=password
    Type Text      id=password  ${pheslo}
    sleep          2
    #klinout na tlačítko "Přihlasit se"
    Click          data-test=btnSignIn
    sleep          2
    #ověřit že jsem přihlášený data-test=header-user-icon musí obsahovat to co je v ${pnastane}
    Get Text        data-test=header-user-icon  *=  ${pnastane}
    sleep          2
    Take Screenshot

Logout
    [Arguments]    ${pnastane}
    log            ${pnastane}

    Click          data-test=header-user-icon
    sleep          2
    Click          data-test=user-box-logout-button
    sleep          2
    Get Text       data-test=header-user-icon  ==  Přihlásit
    sleep          2
    Take Screenshot
