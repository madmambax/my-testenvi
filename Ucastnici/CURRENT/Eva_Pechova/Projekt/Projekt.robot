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
Login spatny email
    Login           chyba                  ${USER_PASSWORD}           ${ERROR_TEXT_FillCorrectEmail}

Login spatne heslo
    Login           ${USER_NAME}            bad                       ${ERROR_TEXT_IncorrectEmailOrPwd}
    Click           ${SEL_HeaderLogo}

Login vse OK
    Login           ${USER_NAME}            ${USER_PASSWORD}
    Logout

Test Objednavky
    ${kusu} =	        Set Variable	            5
    Login               ${USER_NAME}                ${USER_PASSWORD}
    Pridat do kosiku    Losos                       ${kusu}
    Click               ${SEL_CartContent}
    Odebrat z kose      ${kusu}
    Logout

*** Keywords ***

Login
    [Arguments]        ${USER_NAME}                ${USER_PASSWORD}

    Set Browser Timeout     30

Start Case
    New Browser         chromium    headless=false
    New Page            ${URL}

    Get Title           contains    Rohlik.cz
    click               ${SEL_HeaderLogin}
    type text           ${SEL_LoginFormEmail}       ${USER_NAME}
    type text           ${SEL_LoginFormPwd}         ${USER_PASSWORD}
    click               ${SEL_BtnSignIn}
    Get Text            ${SEL_HeaderLoginErrorTxt}

Pridat do kosiku
    [Arguments]         ${Zbozi}                    ${Kusu}
    Type Text           ${SEL_SearchGlobal}         ${Zbozi}
    Sleep               3
    Click               ${SEL_BtnSearchGlobal}
    click               ${SEL_BtnAdd}
    Sleep               3

    ${Pocet}            Evaluate                    ${Kusu} - 1
    Click               ${SEL_BtnPlus}              clickCount=${Pocet}
    Get Text            ${SEL_Cart}                 matches                             (?i)${Zbozi}

Logout

    Click               ${SEL_HeaderLoginErrorTxt}
    Click               ${SEL_UserBoxLogoutBtn}

Odebrat z kose
    [Arguments]                 ${Kusu}

    Click               ${SEL_BtnMinus}           clickCount=${Kusu}
    Sleep               3

Close case
    close browser


