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


*** Keywords ***

Login
    [Arguments]     ${pemail}      ${pheslo}     ${pnastane}

    log             ${pemail}
    log             ${pheslo}
    log             ${pnastane}

    #otevřít prohlížeč
    New Browser    chromium    headless=false
    New Context    viewport={'width': 1920, 'height': 1080}

    #otevřít stránku rohlik.cz
    New Page       https://www.rohlik.cz/
    #ověřit že se stránka otevřela
    Get Title       ==   Online supermarket Rohlik.cz — nejrychlejší doručení ve městě
    Click       id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    sleep       2
    #kliknout na Přihlásit
    Click   id=headerLogin
    #zadat email ${pemail} do místa pro zadání emailu
    Type Text    id=email   ${pemail}
    #zadat heslo ${pheslo} do místa pro zadání hesla
    Type Text    id=password    ${pheslo}
    #klinout na tlačítko "Přihlasit se"
    Click   data-test=btnSignIn
    #ověřit že jsem přihlášený data-test=header-user-icon musí obsahovat to co je v ${pnastane}
    Sleep    10
    Get Text       data-test=header-user-icon  ==    ${pnastane}
