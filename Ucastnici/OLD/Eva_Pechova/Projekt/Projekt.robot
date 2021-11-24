*** Settings ***
Documentation   Úkol: Projekt

Library         Browser
Library         DebugLibrary

Resource        TestData.robot
Resource        Konfigurace.robot

Test Setup      Start case
Test Teardown   Close case

Test Timeout    30

*** Variables ***


*** Test Cases ***
Test1

    Start Case
    Login               ${USER_NAME}                 chyba                     ${ERROR_TEXT_IncorrectEmailOrPwd}
    click               ${SEL_HeaderLogo}

Test2
    Start Case
    Login               chyba                        ${USER_PASSWORD}          ${ERROR_TEXT_FillCorrectEmail}
    click               ${SEL_HeaderLogo}

Test3

    Start Case
    Login                ${USER_NAME}                 ${USER_PASSWORD}          EP
    Logout

Test Objednavky
    ${kusu} =	        Set Variable	              5
    Login               ${USER_NAME}                  ${USER_PASSWORD}          EP
    Pridat do kosiku    Losos                         ${kusu}
    Click               ${SEL_CartContent}
    Odebrat z kose      ${kusu}
    Logout

*** Keywords ***
Start Case
    New Browser         chromium    headless=false
    New Page            ${URL}

Login
    [Arguments]        ${USER_NAME}                    ${USER_PASSWORD}             ${text}

    Set Browser Timeout     30

    click               ${SEL_HeaderLogin}
    type text           ${SEL_LoginFormEmail}           ${USER_NAME}
    type text           ${SEL_LoginFormPwd}             ${USER_PASSWORD}
    click               ${SEL_BtnSignIn}
    Get Text            ${SEL_HeaderLoginErrorTxt}      contains                     ${text}

Pridat do kosiku
    [Arguments]         ${Zbozi}                        ${Kusu}
    Type Text           ${SEL_SearchGlobal}             ${Zbozi}
    Sleep               3
    Click               ${SEL_BtnSearchGlobal}
    click               ${SEL_BtnAdd}
    Sleep               3

    ${Pocet}            Evaluate                        ${Kusu} - 1
    Click               ${SEL_BtnPlus}                  clickCount=${Pocet}
    Get Text            ${SEL_Cart}                     matches                             (?i)${Zbozi}

Logout

    Click               ${SEL_HeaderLoginErrorTxt}
    Click               ${SEL_UserBoxLogoutBtn}

Odebrat z kose
    [Arguments]                 ${Kusu}

    Click               ${SEL_BtnMinus}                 clickCount=${Kusu}
    Sleep               3

Close case
    close browser


