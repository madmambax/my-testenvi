*** Settings ***
Library  Browser


*** Variables ***
${URL}      https://www.rohlik.cz/


*** Test Cases ***


Prihlaseni success
    OpenPage
    Login               manod33170@teknowa.com              3jgRYyfUYxUeENL             T9
    Logout

Prihlaseni bad login
    OpenPage
    Login               dsadsad@sdas.cz                     dasdas                      Přihlásit

Prihlaseni bad heslo
    OpenPage
    Login               radek.tester@seznam.cz              dasdas                      Přihlásit

Test copy selectoru
    New Browser     chromium    headless=true
    New Page        https://test-app.portalobcana.online/osp/#/uvod
    Get Title       ^=  Osobní
    ${text} =  Get Text  css=#nav-menu-home-block > a
    log to console  ${text}
    Should Be Equal    ${text}    Úvodní strana  strip_spaces=True


*** Keywords ***
# Cílem úkolu je doplnit toto klíčové slovo tak aby všechny testy prošly
OpenPage
    New Browser    chromium    headless=false
    #otevřít stránku rohlik.cz
    New Page       ${URL}
    #ověřit že se stránka otevřela
    Get Title      ^=  Online
    Wait For Elements State  id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    Click          id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
Login
    [Arguments]     ${pemail}      ${pheslo}     ${pnastane}

    log             ${pemail}
    log             ${pheslo}
    log             ${pnastane}

    #kliknout na Přihlásit
    Click           data-test=IconUserLogin

    #zadat email ${pemail} do místa pro zadání emailu
    Type Text         id=email    ${pemail}

    #zadat heslo ${pheslo} do místa pro zadání hesla
    Type Text         id=password    ${pheslo}
    #klinout na tlačítko "Přihlasit se"

    Click           data-test=btnSignIn
    sleep  1
    #ověřit že jsem přihlášený data-test=header-user-icon musí obsahovat to co je v ${pnastane}
    ${text} =     Get Text    css=[data-test=header-user-icon]
    log to console  ${text}
    Should Contain  ${text}  ${pnastane}

Logout
    Click   data-test=header-user-icon
    Click   data-test=user-box-logout-button
#    sleep  10

