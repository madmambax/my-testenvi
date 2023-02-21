
# požadavky
#   pip install robotframework-browser
#   rfbrowser init


*** Settings ***
Library  Browser


*** Variables ***
${URL}      https://www.rohlik.cz/


*** Test Cases ***

Prihlaseni bad login
    Login               dsadsad@sdas.cz                     dasdas                      Účet
Prihlaseni bad heslo
    Login               radek.tester@seznam.cz              dasdas                      Účet
Prihlaseni success
    Login               radek.tester@seznam.cz              tajneheslotajneheslo        JT


*** Keywords ***

# Cílem úkolu je doplnit toto klíčové slovo tak aby všechny testy prošly
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
    Get Title      contains    Rohlik.cz
    #kliknout na povolit cookies
    Click    id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    #kliknout na Přihlásit
    Click    data-test=header-user-icon
    #zadat email ${pemail} do místa pro zadání emailu
    Type Text    id=email    ${pemail}
    #zadat heslo ${pheslo} do místa pro zadání hesla
    Type Text    id=password    ${pheslo}
    #klinout na tlačítko "Přihlasit se"
    Click    data-test=btnSignIn
    #ověřit že jsem přihlášený data-test=header-user-icon musí obsahovat to co je v ${pnastane}
    Get Text    text="${pnastane}"


    #saucedemo.com např. otestovat automaticky