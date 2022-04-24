*** Settings ***
Library  Browser

*** Variables ***

${URL}      https://www.rohlik.cz/vitejte#_=_

*** Test Cases ***

* Test Cases *
Pozitivní přihlášení
    New Browser    chromium    headless=false
#    New Context    viewport={'width': 1920, 'height': 1080}
    New Page       ${URL}
    Get Title      ==    Online supermarket Rohlik.cz — nejrychlejší doručení ve městě

    Click          id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    Sleep          2
    Click          id=headerLogin
    Login          radek.tester@seznam.cz       tajneheslotajneheslo
    Sleep          5
    Click          id=headerUser

   ${Text}=        Get Text       data-test=my-account-button
   Log To Console      ${Text}      # jen pro kontrolu
   Should Be Equal     ${Text}    Můj účet

*** Keywords ***

Login
    [Arguments]     ${username}     ${password}
    Type Text       data-test=user-login-form-email  ${username}
    Type Text       data-test=user-login-form-password      ${password}
    Click           data-test=btnSignIn