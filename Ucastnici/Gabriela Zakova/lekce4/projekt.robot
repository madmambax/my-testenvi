# požadavky
#   pip install robotframework-browser
#   rfbrowser init


*** Settings ***
Documentation   Automatizace idoklad.cz s BrowserLibrary
Library  Browser

Resource        TestData.robot

Suite Teardown  Uklid         #úklid po ukončení celé sady testů

Test Setup      Pred_testem   #nastavení před samotným testem


*** Variables ***
${URL}      https://app.idoklad.cz/Account/Login


*** Test Cases ***
#Prihlaseni bad login -  NUTNO OPRAVIT!!
  #Login                 hloupost@seznam.cz                     stalosejejda                Přihlásit

Prihlaseni success
    Login               ${USER_NAME}                            ${USER_PASSWORD}            ${OVERENI}


*** Keywords ***

Login
    [Arguments]         ${email}                                ${heslo}                    ${validation}
    New Page            ${URL}
    Get Title           contains                                přihlášení
    Type Text           css=#UserName                           ${email}                    #nebo id=UserName
    Type Text           xpath=//input[@id='Password']           ${heslo}                    #nebo id=Password 
    Click               id=csw-login-button                                   #nemělo by fungovat i tohle name=submitButton ?? 
    Get Text            id=csw-fast-step-new-invoice-button     ==                          ${validation}
    ${log}=             Get Text                                id=csw-fast-step-new-invoice-button
    Log                 ${log}
    Take Screenshot

Pred_testem
    Open Browser
    New Page                ${URL}

Uklid
    Close Browser