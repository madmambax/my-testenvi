#DÚ3

*** Settings ***
Library  Browser


*** Variables ***
${URL}              https://www.rohlik.cz/
${headerusericon}   data-test=header-user-icon


*** Test Cases ***

Prihlaseni
    Login           sm.jiri@seznam.cz        Testovani864ZdR        JŠ


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
    #ověřit, že se stránka otevřela
    Get Title      contains    Online supermarket Rohlik.cz
    #kliknout na povolit cookies
    Click          id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    #kliknout na Účet
    Click          ${headerusericon}
    Sleep          1
    #zadat email ${pemail} do místa pro zadání emailu
    Type Text      id=email    ${pemail}
    #zadat heslo ${pheslo} do místa pro zadání hesla
    Type Text      xpath=//*[@id="password"]    ${pheslo}
    Sleep          1
    #kliknout na tlačítko "Přihlásit se"
    Click          data-test=btnSignIn
    Sleep          1
    #ověřit, že jsem přihlášený; data-test=header-user-icon musí obsahovat to co je v ${pnastane}
    Get Text       text="${pnastane}"
    #kliknout na data-test=header-user-icon, kde se nachází tlačítko "Odhlásit se" a ověřit jej
    Click          ${headerusericon}
    Get Text       data-test=user-box-logout-button    contains     Odhlásit se
    Sleep          1
    #kliknout na "Odhlásit se"
    Click          data-test=user-box-logout-button
    #ověření, že došlo k odhlášení (např. ${headerusericon} obsahuje text Účet)
    Get Text       ${headerusericon}    contains     Účet

