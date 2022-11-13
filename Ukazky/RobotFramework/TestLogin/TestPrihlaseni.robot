*** Settings ***
Documentation    Tento test file obsahuje 2 pozitivní a 2 negativní test casy na otestování
...              přihlašování do aplikace 'Testovací login' na webu testovani.kitner.cz

Suite Setup       Setup
#Test Setup       Setup
# Zkusit to udělat i bez vypnutýho Strict Mode.
Library          Browser

*** Variables ***
${url1}     http://testovani.kitner.cz/
${url2}     login_app/

*** Test Cases ***
Úspěšné přihlášení novak
    [Tags]           pozitivní
    Login            novak               tajnenovak            ano
    [Teardown]       TeardownPoz

Úspěšné přihlášení admin
    [Tags]           pozitivní
    Login            admin               tajneadmin            ano
    [Teardown]       TeardownPoz

Neúspěšné přihlášení chybné jméno
    [Documentation]  Paní Nováková se zkouší přihlásit k účtu manžela (zná jeho heslo).
    [Tags]           negativní
    Login            novakova            tajnenovak            ne
    [Teardown]       TeardownNeg

Neúspěšné přihlášení chybné heslo
    [Documentation]  Admin zapomněl svoje heslo a tak to zkouší..
    [Tags]           negativní
    Login            admin               tajnyadmin            ne
    [Teardown]       TeardownNeg

*** Keywords ***

Login
    [Arguments]        ${jmeno}     ${heslo}     ${prihlasen}

    Type Text          id=inputUsername     ${jmeno}                         # Input 'Jméno'.
    Type Text          id=inputPassword     ${heslo}                         # Input 'Heslo'.
    Click              id=butt                                               # Tlačítko s textem 'Login'.
    Take Screenshot

    IF    '${prihlasen}' == 'ano'
       Get Url      ==                   http://testovani.kitner.cz/login_app/welcome.php     # AssertPoz1
       Get Text     id=logout            ==    odhlásit        # AssertPoz2
    ELSE
       Get Url      !=                   http://testovani.kitner.cz/login_app/welcome.php        # AssertNeg2
       Get Text     id=login_form        *=      Kombinace jmena a hesla nesouhlasi!!!   # AssertNeg1
    END



Setup
    Set Strict Mode    False
    New Browser        headless=False
    New Page           ${url1}${url2}
# Použil jsem při ladění testcasů a pro kontrolu po dokončení celý test. sady.

TeardownPoz
    Click           id=logout
#    Sleep           1
#    Close Page

TeardownNeg
#    Close Page
    Log   konec testu