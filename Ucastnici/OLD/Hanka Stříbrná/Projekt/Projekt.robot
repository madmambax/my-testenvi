*** Settings ***

Library     Browser
Resource    TestData.robot
Library     OperatingSystem

Suite Setup     pred_sadou
Test Setup      pred_testem
Test Teardown   po_testu
Suite Teardown  po_sade

*** Variables ***
${URL}         https://rohlik.cz


*** Test Cases ***

Správné heslo

    Login           ${USER1_NAME}              ${USER1_PASSWORD}            ${USER1_SHORT}
    Take Screenshot

Špatné heslo

   Login            ${USER1_NAME}               spatneheslo                  ${ERROR_TEXT_IncorrectEmailOrPwd}
   Take Screenshot

Špatný email

    Login           spatnyemail@gmail.com       ${USER1_PASSWORD}            ${ERROR_TEXT_IncorrectEmailOrPwd}
    Take Screenshot


Odlášení
    Login           ${USER1_NAME}               ${USER1_PASSWORD}            ${USER1_SHORT}
    Click           ${SEL_HeaderUser}
    Click           ${SEL_UserBoxLogoutBtn}
    Get Text        ${SEL_HeaderLogin}           contains                   Přihlásit
    Take Screenshot



*** Keywords ***

Login
    [Arguments]     ${můjemail}      ${mojeheslo}     ${odezva}

    log             ${můjemail}
    log             ${mojeheslo}
    log             ${odezva}

    Get Title       Contains                            ${TEXT_MainTitle}
    Click           "Přihlásit"
    Type Text       ${SEL_LoginFormEmail}                ${můjemail}
    Type Text       ${SEL_LoginFormPwd}                  ${mojeheslo}
    Click           ${SEL_BtnSignIn}
    Get Text        ${SEL_HeaderLoginErrorTxt}            contains              ${odezva}


pred_sadou
    ${b_timeout}=    Set Browser Timeout     ${timeout_browser}
    Log              ${b_timeout}

pred_testem
    New Browser      chromium    headless=false
    New Page         ${URL}

po_testu
    Close Browser

po_sade
#    ${output} =     Get file    log.html
#    Log             ${output}
#    New Browser     chromium    headless=false
#    New Page        ${output}
    Log To Console    Všechno dobře dopadlo (-;
