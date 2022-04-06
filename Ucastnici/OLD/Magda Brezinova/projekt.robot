# požadavky
#   pip install robotframework-browser
#   rfbrowser init


*** Settings ***
Documentation   Automatizace kalkulačky s BrowserLibrary. Správné heslo jsem poslala v emailu.
Library  Browser

Resource    Projekt/Data/TestData.robot
Resource    Projekt/Configuration/Configuration.robot

Test Setup      Před testem
Test Teardown   Po testu



*** Variables ***


*** Test Cases ***

Prihlaseni success
    Login               magda.brezinova@renomia.cz              Spatneheslo        ${USER}      #Správné heslo jsem poslala v emailu.


Prihlaseni a odhlaseni success
    Login               magda.brezinova@renomia.cz              Spatneheslo        ${USER}      #Správné heslo jsem poslala v emailu.
    Logout              ${USER}


Prihlaseni negativni
    Login negativni              magda@renomia.cz              Spatneheslo        ${ERROR_TEXT_BadSigning}        #Správné heslo jsem poslala v emailu.


Prihlaseni negativni
    Login negativni              magda.brezinova@renomia.cz              Badpassword        ${ERROR_TEXT_BadSigning}


*** Keywords ***

Login
    [Arguments]         ${email}                            ${heslo}                    ${validation}
    Get Title           contains                            Vítejte
    Click               ${SEL_LoginOtherVariant}
    Type Text           ${SEL_LoginUsername}                ${email}
    Type Text           ${SEL_LoginPassword}                ${heslo}
    Click               ${SEL_LoginButton}
    Get Text            //span[text()="${validation}"]
    ${log}=             Get Text                            //span[text()="${validation}"]
    Log                 Url: ${URL} ${\n} user: ${log} ${\n} login: ${email} ${\n} password: ${heslo}


Login negativni
    [Arguments]         ${email}                            ${heslo}                    ${validation}
    Get Title           contains                            Vítejte
    Click               ${SEL_LoginOtherVariant}
    Type Text           ${SEL_LoginUsername}                ${email}
    Type Text           ${SEL_LoginPassword}                ${heslo}
    Click               ${SEL_LoginButton}
    Get Text            ${SEL_LoginVallidationBad}             contains        ${validation}
    Log                 Url: ${URL} ${\n} user: ${email} ${\n} password: ${heslo}


Logout
    [Arguments]         ${validation}
    Click               //span[text()="${validation}"]
    Click               ${SEL_Logout}
    Get Title           contains                            Vítejte


Před testem
    ${b_timeout}        Set Browser Timeout                 ${TIMEOUT_BROWSER}
    Open Browser        ${URL}                              headless=false     #dá se použít pro nastavení dalších parametru - umožňuje např vypnout headless mode
    New Page            ${URL}

Po testu
    Take Screenshot