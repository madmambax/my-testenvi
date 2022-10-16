*** Settings ***
Documentation    Tento test file obsahuje 2 pozitivní a 2 negativní test casy na otestování
...               přihlašování do aplikace 'Testovací login' na webu testovani.kitner.cz
Test Setup      Set Strict Mode    False
Library         Browser
Library         Screenshot

*** Variables ***
${url1}     http://testovani.kitner.cz/
${url2}     login_app/

*** Test Cases ***
PřihlášeníP1
    [Tags]              pozitivní
    New Page            ${url1}${url2}
    Type Text            id=inputUsername     novak                                         # Input 'Jméno'
    Type Text            id=inputPassword     tajnenovak                                    # Input 'Heslo'
    Click                id=butt                                                            # Tlačítko s textem 'Login'.
    Take Screenshot
    Get Url               ==           http://testovani.kitner.cz/login_app/welcome.php     # AssertP1

PřihlášeníP2
    [Tags]          pozitivní
    New Page        ${url1}${url2}
    Type Text        id=inputUsername     admin                 # Input 'Jméno'
    Type Text        id=inputPassword     tajneadmin            # Input 'Heslo'
    Click            id=butt                                    # Je to tlačítko s textem 'Login'.
    Get Text         id=logout     ==  odhlásit                 # AssertP2

PřihlášeníN1
    [Documentation]    Paní Nováková se zkouší přihlásit k účtu manžela (zná jeho heslo).
    [Tags]           negativní
    New Page        ${url1}${url2}
    Type Text        id=inputUsername     novakova                                  # Input 'Jméno'
    Type Text        id=inputPassword     tajnenovak                                # Input 'Heslo'
    Click            id=butt                                                        # Tlačítko s textem 'Login'.
    Get Text         id=login_form   *=      Kombinace jmena a hesla nesouhlasi!!!   # AssertN1

PřihlášeníN2
    [Documentation]    Admin zapomněl svoje heslo a tak to zkouší..
    [Tags]          negativní
    New Browser         headless=False
    New Page        ${url1}${url2}
    Type Text        id=inputUsername     admin                                         # Input 'Jméno'
    Type Text       id=inputPassword     tajnyadmin                                     # Input 'Heslo'
    Click           id=butt                                                             # Tlačítko s textem 'Login'.
    Get Url          !=           http://testovani.kitner.cz/login_app/welcome.php      # AssertN2
