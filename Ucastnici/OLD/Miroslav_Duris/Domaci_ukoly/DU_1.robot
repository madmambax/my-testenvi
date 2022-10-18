*** Settings ***
Documentation    Tento test file obsahuje 2 pozitivní a 2 negativní test casy na otestování
...              přihlašování do aplikace 'Testovací login' na webu testovani.kitner.cz
Test Setup       Setup_DU1
# Zkusit to udělat i bez vypnutýho Strict Mode.
Library          Browser

*** Variables ***
${url1}     http://testovani.kitner.cz/
${url2}     login_app/

*** Test Cases ***
PřihlášeníPoz1
    [Tags]               pozitivní
#    New Browser          browser=firefox
# Nefunguje.
    New Page             ${url1}${url2}
    Type Text            id=inputUsername     novak                                                # Input 'Jméno'.
    Type Text            id=inputPassword     tajnenovak                                           # Input 'Heslo'.
#    Click                text=Login
# Nefunguje a nevím proč/kvůli čemu.
    Click                id=butt                                                                   # Tlačítko s textem 'Login'.
    Sleep                1                    Čekání na přihlášení se do účtu
    Take Screenshot
    Get Url              ==                   http://testovani.kitner.cz/login_app/welcome.php     # AssertPoz1
    [Teardown]           TeardownPoz

PřihlášeníPoz2
    [Tags]           pozitivní
    New Page         ${url1}${url2}
    Type Text        id=inputUsername     admin                                             # Input 'Jméno'.
    Type Text        id=inputPassword     tajneadmin                                        # Input 'Heslo'.
    Click            id=butt                                                                # Je to tlačítko s textem 'Login'.
    Sleep            1                    Čekání na přihlášení se do účtu
    Take Screenshot
    Get Text         id=logout            ==                                odhlásit        # AssertPoz2
    # Vytvořil bych i jiný (a asi lepší) assert, ale nepamatuju si, jak se kombinují css selektory.
    [Teardown]           TeardownPoz

PřihlášeníNeg1
    [Documentation]    Paní Nováková se zkouší přihlásit k účtu manžela (zná jeho heslo).
    [Tags]             negativní
    New Page           ${url1}${url2}
    Type Text          id=inputUsername     novakova                                        # Input 'Jméno'.
    Type Text          id=inputPassword     tajnenovak                                      # Input 'Heslo'.
    Click              id=butt                                                              # Tlačítko s textem 'Login'.
    Take Screenshot
    Get Text           id=login_form        *=      Kombinace jmena a hesla nesouhlasi!!!   # AssertNeg1
    [Teardown]         TeardownNeg

PřihlášeníNeg2
    [Documentation]    Admin zapomněl svoje heslo a tak to zkouší..
    [Tags]             negativní
    New Page           ${url1}${url2}
    Type Text          id=inputUsername     admin                                                   # Input 'Jméno'.
    Type Text          id=inputPassword     tajnyadmin                                              # Input 'Heslo'.
    Click              id=butt                                                                      # Tlačítko s textem 'Login'.
    Take Screenshot
    Get Url            !=                   http://testovani.kitner.cz/login_app/welcome.php        # AssertNeg2
    [Teardown]         TeardownNeg

*** Keywords ***
Setup_DU1
    Set Strict Mode    False
    Set Log Level      TRACE
#    New Browser        headless=False
# Použil jsem při ladění testcasů a pro kontrolu po dokončení celý test. sady.

TeardownPoz
    Click           id=logout
    Sleep           1
    Close Page

TeardownNeg
    Close Page