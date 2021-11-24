*** Settings ***
Library  Browser


*** Variables ***
${URL}      https://www.rohlik.cz/


*** Test Cases ***

Prihlaseni bad login
    Login               dsadsad@sdas.cz                     dasdas                      Přihlásit

Prihlaseni bad heslo
   Login               radek.tester@seznam.cz              dasdas                      Přihlásit

Prihlaseni success
    Login               radek.tester@seznam.cz              tajneheslotajneheslo        JT
    Logout              Přihlásit

*** Keywords ***

Login
    [Arguments]     ${pemail}      ${pheslo}     ${pnastane}
    log             ${pemail}
    log             ${pheslo}
    log             ${pnastane}

    #otevřít prohlížeč
    New Browser     chromium    headless=false

    #otevřít stránku rohlik.cz
    New Page        https://www.rohlik.cz/

    #ověřit že se stránka otevřela
    Get Title       contains    Rohlik.cz

    #kliknout na login
    Click           data-test=header-user-icon

    #zadat email ${pemail} do místa pro zadání emailu
    Type Text      data-test=user-login-form-email          ${pemail}

    #zadat heslo ${pheslo} do místa pro zadání hesla
    Type Text      data-test=user-login-form-password          ${pheslo}
    #nebo Type Text  css=#password      ${pheslo}

    #klinout na tlačítko "Přihlasit se"
    Click      data-test=btnSignIn

    #ověřit že jsem přihlášený data-test=header-user-icon musí obsahovat to co je v ${pnastane}
    Get Text    data-test=header-user-icon      ==      ${pnastane}

Logout
    [Arguments]     ${pnastane}
    log             ${pnastane}
    Click       data-test=header-user-icon
    Click       data-test=user-box-logout-button
    Get Text    data-test=header-user-icon      ==      ${pnastane}

