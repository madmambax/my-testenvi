*** Settings ***
Library  Browser

*** Variables ***

${URL}      https://www.rohlik.cz/vitejte#_=_

*** Test Cases ***

* Test Cases *

Pozitivní přihlášení
    Open URL
    Login          radek.tester@seznam.cz       tajneheslotajneheslo
    Click          id=headerUser
    ${Text}=        Get Text       data-test=my-account-button
    Log To Console      ${Text}      # jen pro kontrolu
    Should Be Equal     ${Text}    Můj účet

Odhlášení
    Open URL
    Login          radek.tester@seznam.cz       tajneheslotajneheslo
    Click          id=headerUser
    Click          text=Odhlásit se
    Click          id=headerLogin
    ${Text}=        Get Text       data-test=btnSignIn
    Log To Console      ${Text}      # jen pro kontrolu
    Should Be Equal     ${Text}    Přihlásit se

*** Keywords ***

Open URL
    New Browser    chromium    headless=false
    New Page       ${URL}
    Get Title      ==    Online supermarket Rohlik.cz — nejrychlejší doručení ve městě
    Click          id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    Sleep          2

Přihlášení
    Click          id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    Sleep          2
    Click          id=headerLogin
Login
    Click          id=headerLogin
    [Arguments]     ${username}     ${password}
    Type Text       data-test=user-login-form-email  ${username}
    Type Text       data-test=user-login-form-password      ${password}
    Click           data-test=btnSignIn