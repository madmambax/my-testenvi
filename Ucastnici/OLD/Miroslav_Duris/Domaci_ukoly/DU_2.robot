"""
Úkoly od Radka:
1. V názvech testů/testcasů (ale i d.) nepoužívat proměnný - opravit.
2. Názvy proměnných, klíč. slov ad. mají být popisný - opravit.
"""

*** Settings ***
Documentation    Oproti DÚ_1 jsou tu některé konstanty nahrazeny proměnnými (pro zjednodušení testu),
...              přidány výpisy do logu (všech proměnných a načtených hodnot)
...              a vytvořena klíčová slova.
Test Setup       Setup_DU2
Library          Browser
Test Teardown    Teardown_DU2
# Test Teardown se mi neloguje do log file - nebo ho tam prostě nemůžu najít. A funguje vůbec?!

*** Variables ***
# Zkusit použít v klíč. slovech a test casech proměnný ze seznamů a ze slovníků místo proměnných zapsaných jako skaláry.
# Jestli to bude fungovat..

# Obecné
${poz}          PozitivníTest
${neg}          NegativníTest
# URLs
# @{url}          ${url3}  ${url5}
@{url}           http://testovani.kitner.cz/login_app/       http://testovani.kitner.cz/login_app/welcome.php
# &{url}          "LoginPage"=${url3}  "assert"=${url5}
&{url}          "1"="http://testovani.kitner.cz/login_app/"      "2"="http://testovani.kitner.cz/login_app/welcome.php"
${url1}         http://testovani.kitner.cz/
${url2}         login_app/
${url3}         ${url1}${url2}
${url4}         welcome.php
${url5}         ${url3}${url4}
# Identifikátory (selektory)
# @{selector}         ${selector1}  ${selector2}  ${selector3}  ${selector4}  ${selector5}  ${selector6}
@{selector}          id=inputUsername    id=inputPassword    id=butt     id=logout   id=login_form      text=Login
# &{selector}              "1"=${selector1}     "2"=${selector2}        "3"=${selector3}     "4"=${selector4}    "5"=${selector5}       "6"=${selector6}
&{selector}         "1"="id=inputUsername"  "2"="id=inputPassword"  "3"="id=butt"       "4"="id=logout"        "5"="id=login_form"  "6"="text=Login"
${selector1}         id=inputUsername
${selector2}         id=inputPassword
${selector3}         id=butt
${selector4}         id=logout
${selector5}         id=login_form
${selector6}         text=Login
# Loginy
# @{login}            ${login1}       ${login2}       ${login3}
@{login}            novak       admin        novakova
# &{login}          "1"=${login1}  "2"=${login2}  "3"=${login3}
&{login}           "1"="novak"  "2"="admin"  "3"="novakova"
${login1}         novak
${login2}         admin
${login3}         novakova
# Hesla
# @{password}         ${password1}        ${password2}        ${password3}
@{password}        tajnenovak      tajneadmin     tajnyadmin
# &{password}         "1"=${password1}    "2"=${password2}  "3"=${password3}
&{password}         "1"="tajnenovak"  "2"="tajneadmin"  "3"="tajnyadmin"
${password1}        tajnenovak
${password2}        tajneadmin
${password3}        tajnyadmin
# Texty
# @{text}         ${text1}        ${text2}
@{text}        odhlásit          Kombinace jmena a hesla nesouhlasi!!!
# &{text}          "1"=${text1}        "2"=${text2}
&{text}         "1"="odhlásit"      "2"="Kombinace jmena a hesla nesouhlasi!!!"
${text1}        odhlásit
${text2}        Kombinace jmena a hesla nesouhlasi!!!
# Nastavení sleepů
# @{sleep}            ${sleep0.5}         ${sleep1}       ${sleep2}
# @{sleep}          0.5                 1                2
# &{sleep}            "1"=${sleep0.5}  "2"=${sleep1}  "3"=${sleep2}
# &{sleep}          "1"=0.5             "2"=1        "3"=2
&{sleep}          "0.5"=0.5           "1"=1        "2"=2
${sleep0.5}        0.5
${sleep1}          1
${sleep2}          2
# Nastavení úrovně logování
# @{logLev}           ${logLevT}           ${logLevD}      ${logLevI}
# @{logLev}             trace            debug           info
# &{logLev}           "T"=${logLevT}  "D"=${logLevD}  "I"=${logLevI}
&{logLev}         "T"="trace"      "D"="debug"     "I"="info"
${logLevT}        TRACE
${logLevD}        DEBUG
${logLevI}        INFO
# Nastavení Strict Mode
${strModeF}     False
${strModeT}     True

*** Test Cases ***
Přihlášení${poz}1
    [Tags]                ${poz}
#    New Browser          browser=firefox                               # Nefunguje. A nevím proč.
#    Log Many    Název 1. test casu: ${1_nazev}  Název 2. test casu: ${2_nazev}  Název 3. test casu: ${3_nazev}  Název 4. test casu: ${4_nazev}
    Set Suite Variable    ${1_nazev}                  ${TEST_NAME}
    Log To Console        Název tohoto test casu: ${1_nazev}
    Login                 ${login1}                   ${password1}
#    Click                ${selector6}                           # Nefunguje a nevím proč/kvůli čemu.
    AssertPoz1
    [Teardown]           TeardownPoz

Přihlášení${poz}2
    [Setup]                 none
    [Tags]                  ${poz}
    Set Suite Variable      ${2_nazev}                   ${TEST_NAME}
    Log To Console          ${\n}${\n}Název tohoto test casu: ${2_nazev}
    Login                   ${login2}                    ${password2}
    AssertPoz2
    # Vytvořil bych i jiný (a asi lepší) assert(y), ale nepamatuju si, jak se kombinují css selektory.
    [Teardown]           TeardownPoz

Přihlášení${neg}1
    [Setup]                none
    [Documentation]        Paní Nováková se zkouší přihlásit k účtu manžela (zná jeho heslo).
    [Tags]                 ${neg}
    Set Suite Variable     ${3_nazev}                    ${TEST_NAME}
    Log To Console         ${\n}${\n}Název tohoto test casu: ${3_nazev}
    Login                  ${login3}                     ${password1}
    AssertNeg1
    [Teardown]             TeardownNeg

Přihlášení${neg}2
    [Setup]                none
    [Documentation]        Admin zapomněl svoje heslo a tak to zkouší..
    [Tags]                 ${neg}
    Set Suite Variable     ${4_nazev}                ${TEST_NAME}
    Log To Console         ${\n}${\n}Název tohoto test casu: ${4_nazev}
    Login                  ${login2}                 ${password3}
    AssertNeg2
    [Teardown]             TeardownNeg
    Log    ${\n}Test Teardown> ${\n}${SPACE} Hodnoty Strict Mode a Log Level vráceny do defaultního stavu,${\n}${SPACE} tzn. Strict Mode na ${strModeT}, Log Level na ${logLevI}.    console=true    level=${logLevT}

    Log Many    Název 1. test casu: ${1_nazev}    Název 2. test casu: ${2_nazev}    Název 3. test casu: ${3_nazev}    Název 4. test casu: ${4_nazev}
    # Proč mi to nefunguje, když to dám do Setup nebo Teardown?

*** Keywords ***
Setup_DU2
    ${puvodniHodnotaSM}    Set Strict Mode          ${strModeF}
    ${puvodniHodnotaLL}    Set Log Level            ${logLevT}
    Log To Console         ${\n}Test Setup>${\n}${SPACE} Hodnota Strict Mode změněna z ${puvodniHodnotaSM} (defaultní) na ${strModeF}.${\n}${SPACE} Hodnota Log Level změněna z ${puvodniHodnotaLL} (defaultní) na ${logLevT}.${\n} ------------------
    Log Variables          level=${logLevT}         # Pro zalogování všech proměnných z toho test filu do log file.
#    New Browser            headless=False          # Pro ladění testcasů a pro kontrolu po dokončení celý test. sady.

Login
    [Arguments]          ${login}               ${password}
    New Page             ${url3}
    Type Text            ${selector1}           ${login}                            # Input 'Jméno'.
    Log To Console       ${\n}Login: ${login}
    Type Text            ${selector2}           ${password}                         # Input 'Heslo'.
#    Sleep                ${sleep2}                                                 # Pro ladění testcasů.
    Log To Console       Heslo: ${password}
    Click                ${selector3}                                               # Tlačítko s textem 'Login'.
    Sleep                ${sleep1}              Čekání na přihlášení se do účtu.
    Take Screenshot

AssertPoz1
    Get Url              ==                   ${url5}

AssertPoz2
    Get Text         ${selector4}            ==       ${text1}

AssertNeg1
    Get Text           ${selector5}        *=      ${text2}

AssertNeg2
    Get Url            !=                   ${url5}
# Klíč. slova AssertPoz1, AssertPoz2, AssertNeg1, AssertNeg2 nejsou dobrý klíč. slova. Mají hodně omezenou (přímo malou)
# použitelnost. Jejich použití tady odpovídá spíš acceptance test-driven development (nebo možná i behavior-driven development)

TeardownPoz
    Click           ${selector4}                                          # Tlačítko 'Odhlásit se'.
    Log             ${\n}Provedeno odhlášení v rámci teardown po test casu.${\n}        console=true    level=${logLevT}
    Sleep           ${sleep1}         Čekání na odhlášení se z účtu.
    Close Page

TeardownNeg
    Close Page

Teardown_DU2
    Set Strict Mode    ${strModeT}
    Set Log Level      ${logLevI}
    # Log             Hodnoty Strict Mode a Log Level vráceny do defaultního stavu, tzn. Strict Mode: ${strModeT}; a Log Level: ${logLevI}.        console=true    level=${logLevT}
    # Do console se to nevypíše. A ani do Logu!

    # Log Many    Název 1. test casu: ${Nazev1testCasu}  Název 2. test casu: ${Nazev2testCasu}  Název 3. test casu: ${Nazev3testCasu}  Název 4. test casu: ${Nazev4testCasu}
    # Není vidět v logu.

*** Comments ***