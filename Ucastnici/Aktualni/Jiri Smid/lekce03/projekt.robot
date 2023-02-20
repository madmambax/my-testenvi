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

    #otevře prohlížeč
    New Browser    chromium    headless=false

    #otevře stránku https://www.rohlik.cz/
    New Page       ${URL}

    #ověří, že se stránka otevřela
    Get Title      contains    Online supermarket Rohlik.cz

    #klikne na "Povolit všechny" a tím povolí cookies
    Click          id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll

    #klikne na "Účet"
    Click          ${headerusericon}
    Sleep          1

    #zadá email ${pemail} do místa pro zadání emailu
    Type Text      id=email    ${pemail}

    #zadá heslo ${pheslo} do místa pro zadání hesla
    Type Text      xpath=//*[@id="password"]    ${pheslo}
    Sleep          1

    #klikne na tlačítko "Přihlásit se"
    Click          data-test=btnSignIn
    Sleep          1

    #ověří, že jsem přihlášený; data-test=header-user-icon musí obsahovat to co je v ${pnastane}
    Get Text       ${headerusericon}    ==    ${pnastane}    #Get Text   text="${pnastane}"

    #klikne na data-test=header-user-icon (JŠ), kde se nachází tlačítko "Odhlásit se" a ověří jej
    Click          ${headerusericon}
    Get Text       data-test=user-box-logout-button    contains     Odhlásit se
    Sleep          1

    #klikne na "Odhlásit se"
    Click          data-test=user-box-logout-button

    #ověří, že došlo k odhlášení (např. tím, že ${headerusericon} obsahuje text Účet)
    Get Text       ${headerusericon}    contains     Účet

