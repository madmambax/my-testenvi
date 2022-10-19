*** Settings ***
Documentation
Library         Browser
Resource        DU_Keywords.robot
Resource        DU_TestData.robot
Resource        DU_Konfigurace.robot
Test Timeout    ${test_timeout}[15]   # Neplatí pro teardowny.
Suite Setup     Suite_Setup_DU4
Test Setup      Assert_DU4_1
Test Teardown   Assert_DU4_2
Suite Teardown  Suite_Teardown_DU4

*** Test Cases ***
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
# Použít 'Wait For Element' místo Sleep.
# Nevím, jak.