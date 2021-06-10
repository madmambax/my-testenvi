*** Settings ***
Library     SeleniumLibrary

*** Variables ***
${LOGIN URL}      http://rohlik.cz
${BROWSER}        Chrome


*** Test Cases ***

Prihlaseni bad username
    Login                       jsemprihlasen                           hesloNeniPassword34                    Přihlásit
    Element Text Should Be      emailError Zadal(a) jste nesprávný e-mail nebo heslo.

Prihlaseni bad heslo
    Login                       TesterNotARobot12@gmail.com             passwordispassword                     Přihlásit
    Element Text Should Be      emailError Zadal(a) jste nesprávný e-mail nebo heslo.

Prihlaseni success
    Login                       TesterNotARobot12@gmail.com             hesloNeniPassword34                    TT



*** Keywords ***

Login/Log Out

    Open Browser        ${LOGIN URL}    ${BROWSER}
    Title Should Be     test_login
    [Arguments]         ${email}                            ${heslo}                    ${validation}
    New Page            ${URL}
    Get Title           contains                            Rohlik
    Click               id=headerLogin
    Type Text           data-test=user-login-form-email     ${email}
    Type Text           data-test=user-login-form-password  ${heslo}
    Click               data-test=btnSignIn
    Get Text            data-test=header-user-icon          ==                          ${validation}
    ${log}=             Get Text                            data-test=header-user-icon
    Log                 ${log}
    Take Screenshot

    Click               id=headerUser
    Click               data-test=user-box-logout-button



