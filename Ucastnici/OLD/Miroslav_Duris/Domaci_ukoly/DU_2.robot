*** Settings ***
Documentation    Oproti DÚ_1 jsou tu některé konstanty nahrazeny proměnnými (pro zjednodušení testu),
...              přidány výpisy do logu (všech proměnných a načtených hodnot)
...              a vytvořena klíčová slova.
Test Setup       Setup_DU2
Library          Browser
Test Teardown    Teardown_DU2

*** Variables ***
# Můžu zkusit zapsat ty proměnný do seznamů a slovníků a zkusit, jestli budou použitelný v klíč. slovehch s test casech.

# Obecné
${poz}          PozitivníTest
${neg}          NegativníTest
# URLs
@{url}
${url1}         http://testovani.kitner.cz/
${url2}         login_app/
${url3}         ${url1}${url2}
${url4}         welcome.php
${url5}         ${url3}${url4}
# Identifikátory (selektory)
${selector1}         id=inputUsername
${selector2}         id=inputPassword
${selector3}         id=butt
${selector4}         id=logout
${selector5}         id=login_form
${selector6}         text=Login
# Loginy
${login1}         novak
${login2}         admin
${login3}         novakova
# Hesla
${password1}        tajnenovak
${password2}        tajneadmin
${password3}        tajnyadmin
# Texty
${text1}        odhlásit
${text2}        Kombinace jmena a hesla nesouhlasi!!!
# Nastavení sleepů
${sleep0.5}        0.5
${sleep1}          1
${sleep2}          2
# Nastavení úrovně logování
${logLevT}        trace
${logLevD}        debug
${logLevI}        info
# Nastavení Strict Mode
${strModeF}     false
${strModeT}     true

*** Test Cases ***
Přihlášení${poz}1
    [Tags]               ${poz}
#    New Browser          browser=firefox
# Nefunguje.
    Login                ${login1}                   ${password1}
#    Click                ${selector6}
# Nefunguje a nevím proč/kvůli čemu.
    AssertPoz1
    [Teardown]           TeardownPoz

Přihlášení${poz}2
    [Setup]         none
    [Tags]           ${poz}
    Login          ${login2}                    ${password2}
    AssertPoz2
    # Vytvořil bych i jiný (a asi lepší) assert, ale nepamatuju si, jak se kombinují css selektory.
    [Teardown]           TeardownPoz

Přihlášení${neg}1
    [Setup]         none
    [Documentation]    Paní Nováková se zkouší přihlásit k účtu manžela (zná jeho heslo).
    [Tags]             ${neg}
    Login              ${login3}                     ${password1}
    AssertNeg1
    [Teardown]         TeardownNeg

Přihlášení${neg}2
    [Setup]         none
    [Documentation]    Admin zapomněl svoje heslo a tak to zkouší..
    [Tags]             ${neg}
    Login              ${login2}                 ${password3}
    AssertNeg2
    [Teardown]         TeardownNeg

*** Keywords ***
Setup_DU2
    Set Strict Mode    ${strModeF}
    Set Log Level      ${logLevT}
#    New Browser        headless=False
# Použil jsem při ladění testcasů a pro kontrolu po dokončení celý test. sady.

Login
    [Arguments]          ${login}               ${password}
    New Page             ${url3}
    Type Text            ${selector1}             ${login}                                                # Input 'Jméno'.
    Type Text            ${selector2}             ${password}                                           # Input 'Heslo'.
#    Sleep                ${sleep2}
#   Použil jsem při ladění testcasů.
    Click                ${selector3}                                                                   # Tlačítko s textem 'Login'.
    Sleep                ${sleep1}                    Čekání na přihlášení se do účtu.
    Take Screenshot

AssertPoz1
    Get Url              ==                   ${url5}

AssertPoz2
    Get Text         ${selector4}            ==       ${text1}

AssertNeg1
    Get Text           ${selector5}        *=      ${text2}

AssertNeg2
    Get Url            !=                   ${url5}
# Klíč. slova AssertPoz1, AssertPoz2, AssertNeg1, Assertneg2 nejsou dobrý klíč. slova. Mají hodně omezenou (přímo malou)
# použitelnost. Jejich použití tady odpovídá spíš acceptance test-driven development (nebo možná i
# behavior-driven development)

TeardownPoz
    Click           ${selector4}
    Sleep           ${sleep1}         Čekání na odhlášení se z účtu.
    Close Page

TeardownNeg
    Close Page

Teardown_DU2
    Set Strict Mode    ${strModeT}
    Set Log Level      ${logLevI}

*** Comments ***