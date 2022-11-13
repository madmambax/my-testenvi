"""
Úkoly od Radka:
1. V názvech testů/testcasů (ale i d.) nepoužívat proměnný - opravit.
2. Názvy proměnných, klíč. slov ad. mají být popisný - opravit.
"""

*** Settings ***
Documentation    Aplikace na URL ${APP_API_url} slouží pro přihlášení uživatele do aplikace 'TestLogin'.
Library          RequestsLibrary
Resource         DU_Keywords.robot
Resource         DU_Konfigurace.robot
Resource         DU_TestData.robot
Suite Setup      Suite_Setup_DU5

*** Variables ***
&{header}         Content-Type=application/json
# V dokumentaci k API aplikace 'TestLogin' je hlavička (header) zmíněna přesně ve znění výše.
# API aplikace 'TestLogin' ale komunikuje i s defaultně nastavenou/vyplněnou hlavičkou.

*** Test Cases ***
LoginApp_API_${poz}1
    Login_přes_API    ${login}[0]    ${password}[0]
    AssertPoz

LoginApp_API_${poz}2
    Login_přes_API    ${login}[1]    ${password}[1]
    AssertPoz

LoginApp_API_${neg}1
    [Documentation]    Kombinace jméno/login + heslo nesedí.
    Login_přes_API    ${login}[2]    ${password}[0]
    AssertNeg

LoginApp_API_${neg}2
    [Documentation]    Správné jméno/login + nesprávné heslo.
    Login_přes_API    ${login}[1]    ${password}[2]
    AssertNeg

LoginApp_API_${neg}3
    [Documentation]    Použita metoda GET (místo metody POST).
    Login_přes_API_metodou_GET    ${login}[0]    ${password}[0]
    AssertNeg
