"""
Úkoly od Radka:
1. V názvech testů/testcasů (ale i d.) nepoužívat proměnný - opravit.
2. Názvy proměnných, klíč. slov ad. mají být popisný - opravit.
---
Moje úkoly:
1. Napsat to i pro www.rohlik.cz
2. Negativní testy by se tady daly zpracovat i jako data-driven testy - zkusit to.
"""

*** Settings ***
Documentation    Test file obsahuje test casy na automatické přihlášení (a odhlášení) do webové aplikace 'Testovací login'
...              na webu testovani.kitner.cz
...              2 testy pozitivní a 2 negativní. Všechny napsány minimalisticky.
Test Setup       Setup_DU3
Library          Browser
Resource         DU_Variables.robot
Test Teardown    Teardown_DU3

*** Test Cases ***
PřihlášeníaOdhlášení${poz}1
    Login         ${login}[0]    ${password}[0]
    Assert_poz
    Lougout       # Odhlášení se z účtu včetně assertu.

PřihlášeníaOdhlášení${poz}2
    Login          ${login}[1]    ${password}[1]
    Assert_poz2
    Lougout        # Odhlášení se z účtu včetně assertu.

Přihlášení${neg}1
    [Documentation]    Nesprávný login + správné heslo.
    Login              ${login}[2]    ${password}[0]
    Assert_neg

Přihlášení${neg}2
    [Documentation]    Správný login + nesprávné heslo.
    Login              ${login}[1]     ${password}[2]
    Assert_neg

*** Keywords ***
Setup_DU3
    Set Strict Mode    ${strModeF}
    Log Variables
#    New Browser        headless=False      # Pro ladění test casů a pro kontrolu po dokončení celý test. sady.

Login
    [Arguments]          ${login}               ${password}
    New Page             ${url}[0]
    Type Text            ${selector}[0]         ${login}
    Type Text            ${selector}[1]         ${password}
    Log                  {Jméno: ${login}, Heslo: ${password}}
    Click                ${selector}[2]
    Sleep                ${sleep}["0.5"]

Lougout
    Click           ${selector}[3]
#    Click           ${selector}[10]                               # Taky funguje.
#    Click           xpath=/html/body/div/form/div[1]/p[2]/a       # Taky funguje.
    Get Url         !=                   ${url}[1]                # Assert.

# Asserty>
Assert_poz
    Get Url     ==                 ${url}[1]
    Get Text    ${selector}[6]     ==           ${login}[0]
#    Get Text    ${selector}[9]     ==           ${login}[0]     # Taky funguje.

Assert_poz2
    Get Url     ==                ${url}[1]
    Get Text    ${selector}[3]    ==            ${text}["1"]
    Get Text    ${selector}[7]    ==            ${login}[1]

Assert_neg
    Get Text    ${selector}[4]    *=            ${text}["2"]
    Get Url     !=                ${url}[1]

# Teardowny>
Teardown_DU3    # Měl by se provést na konci každého test casu.
    Take Screenshot
    Close Page
