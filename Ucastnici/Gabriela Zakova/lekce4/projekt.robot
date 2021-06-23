# požadavky
#   pip install robotframework-browser
#   rfbrowser init


*** Settings ***
Documentation   Automatizace idoklad.cz s BrowserLibrary
Library  Browser

Resource        TestData.robot


*** Variables ***
${URL}      https://app.idoklad.cz/Account/Login


*** Test Cases ***
Prihlaseni success
    Login               ${USER_NAME}                           ${USER_PASSWORD}             ${OVERENI}

Prihlaseni bad user name
    Login2              ${USER_NAME1}                          ${USER_PASSWORD}             ${OVERENI1}
    
Prihlaseni bad password
    Login2              ${USER_NAME}                           ${USER_PASSWORD1}            ${OVERENI1}

Prihlaseni empty
    Login3                                                                                  ${OVERENI1}

*** Keywords ***

Login
    [Arguments]         ${email}                                ${heslo}                    ${validation}
    New Page            ${URL}
    Get Title           contains                                přihlášení
    Type Text           css=#UserName                           ${email}                    #nebo id=UserName
    Type Text           xpath=//input[@id='Password']           ${heslo}                    #nebo id=Password 
    Click               id=csw-login-button                                   #nemělo by fungovat i tohle name=submitButton ?? 
    Get Text            id=csw-fast-step-new-invoice-button     ==                          ${validation}
    Take Screenshot

Login2
    [Arguments]         ${email}                                ${heslo}                    ${validation}
    New Page            ${URL}
    Get Title           contains                                přihlášení
    Type Text           css=#UserName                           ${email}                    #nebo id=UserName
    Type Text           xpath=//input[@id='Password']           ${heslo}                    #nebo id=Password 
    Click               id=csw-login-button                                   #nemělo by fungovat i tohle name=submitButton ?? 
    Get Text            id=csw-register-button                   ==                          ${validation}
    Take Screenshot

Login3
    [Arguments]                                                                             ${validation}
    New Page            ${URL}
    Get Title           contains                                přihlášení
    Click               id=csw-login-button                                   #nemělo by fungovat i tohle name=submitButton ?? 
    Get Text            id=csw-register-button                   ==                       ${validation}
    Take Screenshot
