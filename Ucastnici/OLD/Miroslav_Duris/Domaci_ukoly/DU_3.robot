*** Settings ***
Documentation    Test file obsahuje test casy na automatické přihlášení (a odhlášení) do webové aplikace 'Testovací login'
...              na webu testovani.kitner.cz
...              Testy pozitivní i negativní.
...              Oproti předchozím DÚ:
Test Setup       Setup_DU3
Library          Browser
Resource         Variables_DU.robot
Test Teardown    Teardown_DU3
# Test Teardown se mi neloguje do log file - nebo ho tam prostě nemůžu najít.

*** Test Cases ***
Přihlášení${poz}1
    [Tags]                ${poz}
#    New Browser          browser=firefox                               # Nefunguje. A nevím proč.
#    Log Many    Název 1. test casu: ${1_nazev}  Název 2. test casu: ${2_nazev}  Název 3. test casu: ${3_nazev}  Název 4. test casu: ${4_nazev}
    Set Suite Variable    ${1_nazev}                  ${TEST_NAME}
    Log To Console        Název tohoto test casu: ${1_nazev}
#    Login                 ${login1}                   ${password1}           # Funguje.
    Login                 ${login}[0]               ${password}[0]
#    Click                ${selector6}                                   # Nefunguje a nevím proč/kvůli čemu.
    AssertPoz1
    [Teardown]           TeardownPoz

Přihlášení${poz}2
    [Setup]                 none
    [Tags]                  ${poz}
    Set Suite Variable      ${2_nazev}                   ${TEST_NAME}
    Log To Console          ${\n}${\n}Název tohoto test casu: ${2_nazev}
#    Login                   ${login2}                    ${password2}      # Funguje.
    Login                   ${login}[1]                  ${password}[1]
    AssertPoz2
    # Vytvořil bych i jiný (a asi lepší) assert(y), ale nepamatuju si, jak se kombinují css selektory.
    [Teardown]           TeardownPoz

Přihlášení${neg}1
    [Setup]                none
    [Documentation]        Paní Nováková se zkouší přihlásit k účtu manžela (zná jeho heslo).
    [Tags]                 ${neg}
    Set Suite Variable     ${3_nazev}                    ${TEST_NAME}
    Log To Console         ${\n}${\n}Název tohoto test casu: ${3_nazev}
#    Login                  ${login3}                     ${password1}      Funguje.*** Keywords ***
    Login                   ${login}[2]                     ${password}[0]
    AssertNeg1
    [Teardown]             TeardownNeg

Přihlášení${neg}2
    [Setup]                none
    [Documentation]        Admin zapomněl svoje heslo a tak to zkouší..
    [Tags]                 ${neg}
    Set Suite Variable     ${4_nazev}                ${TEST_NAME}
    Log To Console         ${\n}${\n}Název tohoto test casu: ${4_nazev}
#    Login                  ${login2}                 ${password3}               # Funguje.
    Login                   ${login}[1]                 ${password}[2]
    AssertNeg2
    [Teardown]             TeardownNeg
    Log    ${\n}Test Teardown> ${\n}${SPACE} Hodnoty Strict Mode a Log Level vráceny do defaultního stavu,${\n}${SPACE} tzn. Strict Mode na ${strModeT}, Log Level na ${logLev}["I"].    console=true    level=${logLev}["T"]

    Log Many    Název 1. test casu: ${1_nazev}    Název 2. test casu: ${2_nazev}    Název 3. test casu: ${3_nazev}    Název 4. test casu: ${4_nazev}
    # Proč mi to nefunguje, když to dám do Setup nebo Teardown?

*** Keywords ***
Setup_DU3
    ${puvodniHodnotaSM}    Set Strict Mode          ${strModeF}
    ${puvodniHodnotaLL}    Set Log Level            ${logLev}["T"]
    Log To Console         ${\n}Test Setup>${\n}${SPACE} Hodnota Strict Mode změněna z ${puvodniHodnotaSM} (defaultní) na ${strModeF}.${\n}${SPACE} Hodnota Log Level změněna z ${puvodniHodnotaLL} (defaultní) na ${logLev}["T"].${\n} ------------------
    Log Variables          level=${logLev}["T"]         # Pro zalogování všech proměnných z toho test filu do log file.
#    New Browser            headless=False          # Pro ladění testcasů a pro kontrolu po dokončení celý test. sady.

Login
    [Arguments]          ${login}               ${password}
#    New Page             ${url3}                       # Funguje.
    New Page                ${url}[0]
#    Type Text            ${selector1}           ${login}            # Input 'Jméno'.       # Funguje.
    Type Text            ${selector}[0]          ${login}
    Log To Console       ${\n}Login: ${login}
    Type Text            ${selector2}           ${password}           # Input 'Heslo'.      # Funguje.
    Type Text            ${selector}[1]         ${password}
#    Sleep                ${sleep2}                                                 # Pro ladění testcasů.
    Log To Console       Heslo: ${password}
#    Click                ${selector3}                     # Tlačítko s textem 'Login'.      # Funguje.
    Click                ${selector}[2]
#    Sleep                ${sleep1}              Čekání na přihlášení se do účtu.       # Funguje.
    Sleep                 ${sleep}["0.5"]
    Take Screenshot

AssertPoz1
    Get Url              ==                   ${url}[1]

AssertPoz2
    Get Text         ${selector}[3]            ==       ${text}["1"]

AssertNeg1
    Get Text           ${selector}[4]        *=      ${text}["2"]

AssertNeg2
    Get Url            !=                   ${url}[1]
# Klíč. slova AssertPoz1, AssertPoz2, AssertNeg1, AssertNeg2 nejsou dobrý klíč. slova. Mají hodně omezenou (přímo malou)
# použitelnost. Jejich použití tady odpovídá spíš acceptance test-driven development (nebo možná i behavior-driven development)

TeardownPoz
    Click           ${selector}[3]                                          # Tlačítko 'Odhlásit se'.
    Log             ${\n}Provedeno odhlášení v rámci teardown po test casu.${\n}        console=true    level=${logLev}["T"]
    Sleep           ${sleep}["1"]         Čekání na odhlášení se z účtu.
    Close Page

TeardownNeg
    Close Page

Teardown_DU3
    Set Strict Mode    ${strModeT}
    Set Log Level      ${logLev}["I"]
    # Log             Hodnoty Strict Mode a Log Level vráceny do defaultního stavu, tzn. Strict Mode: ${strModeT}; a Log Level: ${logLev}["I"].        console=true    level=${logLev}["T"]
    # Do console se to nevypíše. A ani do Logu!

    # Log Many    Název 1. test casu: ${Nazev1testCasu}  Název 2. test casu: ${Nazev2testCasu}  Název 3. test casu: ${Nazev3testCasu}  Název 4. test casu: ${Nazev4testCasu}
    # Není vidět v logu.

*** Comments ***