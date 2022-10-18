*** Settings ***
Documentation
Library         Browser
Resource        DU_Keywords.robot
Resource        DU_TestData.robot
Resource        DU_Konfigurace.robot
Suite Setup     Suite_Setup_DU4
Test Setup      Assert_DU4_1
Test Teardown   Assert_DU4_2
Suite Teardown  Suite_Teardown_DU4
Test Timeout    # Co se tím nastavuje a jak?

*** Test Cases ***
# Použít 'wait for element' místo Sleep.
# A/nebo Set Browser Timeout.
Přihlášení${poz}1
    Login    ${login}[0]    ${password}[0]
    Logout

Přihlášení${poz}2
    Login    ${login}[1]    ${password}[1]
    Logout

Přihlášení${neg}1
    [Documentation]    Nesprávný login + správné heslo.
    Login    ${login}[2]    ${password}[0]

Přihlášení${neg}2
    [Documentation]    Správný login + nesprávné heslo.
    Login    ${login}[1]    ${password}[2]

*** Comments ***
