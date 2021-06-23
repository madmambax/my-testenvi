# Testování přihlášení do aplikace rohlik.cz



*** Settings ***
Documentation   Automatizace rohlik.cz s BrowserLibrary
Library         Browser

Resource        Pat_Projekt_TestData.robot
Resource        Pat_Projekt_Configuration.robot

Test Setup      Pred_testem
Suite Teardown  Uklid_sada


*** Variables ***
# proměnné přesunuty do souboru Pat_Projekt_TestData.robot


*** Test Cases ***

Login uspesne data-test
    [Documentation]  Uspesne prihlaseni pomoci data-test
    Login                       ${USER_RIGHT_NAME}      ${USER_RIGHT_PWD}
    Logout

Login uspesne id
    [Documentation]  Uspesne prihlaseni pomoci id
    Login_id                    ${USER_RIGHT_NAME}      ${USER_RIGHT_PWD}
    [Teardown]      Logout

Login zapomenute heslo
    [Documentation]  Zapomenute heslo
    Login_zapom_heslo           ${USER_RIGHT_NAME}


Login prazdne heslo
    [Documentation]  Prazdne heslo
    Login_Prazdne_heslo         ${USER_RIGHT_NAME}


Login neplatny email
    [Documentation]  Zadan neplatny e-amil
    Login_Neplatny_email        ${USER_WRONG_NAME}      ${USER_RIGHT_PWD}



*** Keywords ***
Login
    [Documentation]  	Uspesne prihlaseni
    [Arguments]         ${username}         ${password}
    Get Title           contains                    ${TEXT_TitleText}      # Hláška: TimeoutError: page.goto: Timeout 10000ms exceeded.
    Click               ${SEL_HeaderLogin}
    Sleep               2
    Type Text           ${SEL_LoginFormEmail}       ${username}
    Type Text           ${SEL_LoginFormPwd}         ${password}
    Sleep               2
    Click               ${SEL_BtnSignIn}

Login_id
    [Documentation]  	Uspesne prihlaseni
    [Arguments]         ${username}         ${password}
    Get Title           contains                    ${TEXT_TitleText}      # Hláška: TimeoutError: page.goto: Timeout 10000ms exceeded.
    Click               ${SEL_HeaderLogin}
    Type Text           ${SEL_ID_Email}             ${username}
    Type Text           ${SEL_ID_Password}          ${password}
    Click               ${SEL_CSS_BtnSignIn}
    Get Text            ${SEL_VerifUserShort}       contains      ${USER_SHORT}

Login_zapom_heslo
    [Documentation]  	Zapomenute heslo
    [Arguments]         ${username}
    Click               ${SEL_HeaderLogin}
    Click               ${ERROR_TEXT_ForgottenPassword}
    Type Text           ${SEL_XPATH_Email}             ${username}
    Click               ${SEL_Btn}

Login_Prazdne_heslo
    [Documentation]  	Prazdne heslo
    [Arguments]         ${username}
    Click               ${SEL_HeaderLogin}
    Type Text           ${SEL_ID_Email}              ${username}
    Click               ${SEL_BtnSignIn}
    Get Text            ${ERROR_ID_ObligatoryPassword}        ==      ${ERROR_TEXT_ObligatoryPassword}

Login_Neplatny_email
    [Documentation]  	Neplatny email
    [Arguments]         ${username}         ${password}
    Click               ${SEL_XPATH_HeaderLogin_1}
    Type Text           ${SEL_ID_Email}            ${username}
    Type Text           ${SEL_ID_Password}         ${password}
    Click               ${SEL_XPATH_HeaderLogin_2}
    Get Text            ${ERROR_ID_FillCorrectEmail}       ==      ${ERROR_TEXT_FillCorrectEmail}

Logout
    [Documentation]  	Odhlaseni
    Click               ${SEL_HeaderUser}
    Click               ${SEL_Logout}

Pred_testem
    New Page                ${URL}
    Set Browser Timeout     20

Uklid_sada
    Close Page          ${URL}