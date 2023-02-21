*** Settings ***
Library  Browser

*** Variables ***
${URL}                  https://www.rohlik.cz/
${LoginFormEmail}       id=email
${LoginFormPwd}         id=password
${BtnSignIn}            data-test=btnSignIn
${HeaderLoginErrorTxt}  xpath=//div[@class='u-mr--8']

*** Test Cases ***

Logon success
    Login               mann.m@seznam.cz                    Plostice2023!               MM


*** Keywords ***

# Cílem úkolu je doplnit toto klíčové slovo tak aby všechny testy prošly
Login
    [Arguments]     ${pemail}      ${pheslo}     ${pmessage}

    log             ${pemail}
    log             ${pheslo}
    log             ${pmessage}

    #otevřít prohlížeč
    New Browser    chromium    headless=false
    New Context    viewport={'width': 1920, 'height': 1080}
    #otevřít stránku rohlik.cz
    New Page       ${URL}
    #ověřit že se stránka otevřela
    Get Title      contains    Rohlik
    #kliknout na povolit cookies
    Click          id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    Sleep          5
    #kliknout na Přihlásit
    Click          data-test=header-user-icon
    #zadat email ${pemail} do místa pro zadání emailu
    Type Text      ${LoginFormEmail}    ${pemail}

    #zadat heslo ${pheslo} do místa pro zadání hesla
    Type Text        ${LoginFormPwd}    ${pheslo}
    #klinout na tlačítko "Přihlasit se"
    Click            ${BtnSignIn}
    #ověřit že jsem přihlášený data-test=header-user-icon musí obsahovat to co je v ${pnastane}
    Get Text    text="${pmessage}"