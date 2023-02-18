*** Settings ***
Library  Browser


*** Variables ***
${URL}              https://www.rohlik.cz/
${headerusericon}   data-test=header-user-icon


*** Test Cases ***

Prihlaseni
    Login           sm.jiri@seznam.cz        Testovani864ZdR        JŠ


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
    #ověřit, že se stránka otevřela
    Get Title      contains    Online supermarket Rohlik.cz
    #kliknout na povolit cookies
    Click          id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    #kliknout na Účet
    Click          ${headerusericon}
    Sleep          2
    #zadat email ${pemail} do místa pro zadání emailu
    Type Text      id=email    ${pemail}
    #zadat heslo ${pheslo} do místa pro zadání hesla
    Type Text      xpath=//*[@id="password"]    ${pheslo}
    Sleep          2
    #kliknout na tlačítko "Přihlásit se"
    Click          data-test=btnSignIn
    Sleep          2
    #ověřit, že jsem přihlášený, data-test=header-user-icon musí obsahovat to co je v ${pnastane}
    Get Text       text="${pnastane}"
    #kliknout na data-test=header-user-icon, kde se nachází tlačítko pro odhlášení
    Click          ${headerusericon}
    Sleep          2
    #kliknout na Odhlásit se
    Click          data-test=user-box-logout-button
    #ověření, že došlo k odhlášení (např. data-test=header-user-icon obsahuje text Účet)
    Get Text       ${headerusericon}    contains     Účet

