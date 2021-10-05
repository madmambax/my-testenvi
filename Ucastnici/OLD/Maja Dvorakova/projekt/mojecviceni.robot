*** Settings ***
Library     SeleniumLibrary

Resource        Ucastnici/Maja Dvorakova/projekt/TestovaciData.robot

Suite Setup     Pred kazdym testem

Suite Teardown  Na konci kazdeho testu



*** Variables ***



*** Test Cases ***

Prihlaseni bad username
    Login                       ${BAD_USER1}              ${USER1_PWD}
    Element Text Should Be      emailError Zadal(a) jste nesprávný e-mail nebo heslo.

Prihlaseni bad heslo
    Login                       ${USER1_NAME}             ${BAD_USER1_PWD}
    Element Text Should Be      emailError Zadal(a) jste nesprávný e-mail nebo heslo.

Prihlaseni success
    Login                       ${USER1_NAME}             ${USER1_PWD}                   ${USER1_SHORT}



*** Keywords ***

Login

    Open Browser        ${URL}                              ${BROWSER}
    Title Should Be     test_login

    [Arguments]         ${email}                            ${heslo}                    ${validation}

    Open Browser        ${URL}

    Get Title           contains                            Rohlik
    Click               id=headerLogin
    Type Text           data-test=user-login-form-email     ${email}
    Type Text           data-test=user-login-form-password  ${heslo}
    Click               data-test=btnSignIn
    Get Text            data-test=header-user-icon          ==                          ${validation}
    ${log}=             Get Text                            data-test=header-user-icon
    Log                 ${log}
    Take Screenshot

Logout
    Click               id=headerUser
    Click               data-test=user-box-logout-button    odhlaseni

Pred kazdym testem

    Open Browser        ${URL}


Na konci kazdeho testu

    Close Browser

