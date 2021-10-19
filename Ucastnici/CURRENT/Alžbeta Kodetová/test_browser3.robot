
# požadavky
#   pip install robotframework-browser
#   rfbrowser init


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
    Set Browser Timeout    20
    New Browser    chromium    headless=false
    New Context    viewport={'width': 1920, 'height': 1080}
    New Page       https://www.rohlik.cz/
    Get Title      *=    Rohlik.cz

    Click          text="Přihlásit"

    Type Text      data-test=user-login-form-email    ${pemail}
    Type Text      data-test=user-login-form-password   ${pheslo}

    Click          data-test=btnSignIn

    Get Text       data-test=header-user-icon    ==    ${pnastane}

    #otevřít prohlížeč

    #otevřít stránku rohlik.cz

    #ověřit že se stránka otevřela

    #kliknout na login

    #zadat email ${pemail} do místa pro zadání emailu

    #zadat heslo ${pheslo} do místa pro zadání hesla

    #klinout na tlačítko "Přihlasit se"

    #ověřit že jsem přihlášený data-test=header-user-icon musí obsahovat to co je v ${pikona}