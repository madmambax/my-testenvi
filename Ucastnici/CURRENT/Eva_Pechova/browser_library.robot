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
    Login               radek.tester@seznam.cz              tajneheslotajneheslo

*** Keywords ***

Login
    [Arguments]      ${pemail}       ${pheslo}      ${pnastane}
    log              ${pemail}
    log              ${pheslo}
    log              ${pnastane}
    Set Browser Timeout     30
    New Browser         chromium    headless=false
    New Page            ${URL}
    Get Title           contains    Rohlik.cz
    click               data-test=header-user-icon
    type text           data-test=user-login-form-email            ${pemail}
    type text           data-test=user-login-form-password         ${pheslo}
    click               data-test="btnSignIn"
    get text            data-test=header-user-icon                 ${pnastane}
    Take Screenshot