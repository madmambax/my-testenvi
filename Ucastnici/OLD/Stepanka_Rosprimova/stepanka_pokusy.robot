#*** Settings ***
#Documentation    Simple example using Browser Library
#Library Browser Library
#
#*** Variables ***
#${LOGIN URL}     https://www.jezdectvi.org/
#${BROWSER}       Microsoft Edge
#
#*** Test Cases ***
#Valid login
#    Open Browser To Login Page
#    Input Username  stepanka.rosprimova
#    Input Password  Vorman1793
#    Submit Credentials
#    Welcome Page Should Be Open
#    [Teardown]  Close Browser
#
#*** Keywords ***
#Open Browser To Login Page
#    Open Browser    ${LOGIN URL}   ${BROWSER}
#    Title Should Be     CJF|Jezdecky informacni system
#
#Input Username
#[Arguments]     ${username}
#Input Text  username_field      ${USERNAME}
#
#Input Username
#[Arguments]     ${password}
#Input Text  password_field      ${PASSWORD}
#
#Submit Credentials
#    Click Button    Login_button
#
#Welcome Page Should Be Open
#    Title Should Be     Welcome Page


*** Test Cases ***


#Test úspěšného přihlášení
#   [Documentation]    Uspesne prihlaseni s navratovym kodem po akci
#   ${data}=   Login   			novak       tajnenovak
#   Dictionary Should Contain Value    ${data}     200


Test proměnných

    ${matematika}=   Secti    5     6
    ${SCALAR}=   Set Variable   ahoy jak se
    @{LIST}=     Create List    first    second  third  fourth  fifth   sixth
    &{DICT}=     Create Dictionary    login=frantatrabant    password=vzducholod

#    Log Many          ${SCALAR} @{LIST} &{DICT}
#    Log               ${SCALAR} @{LIST} &{DICT}
    Log                ${dict.login}
    Log                ${dict}[login]
    Log                %{OS}
    Log                ${\n}Jakou má hodnotu proměnná \${SCALAR}: ${SCALAR}
    Log                ${matematika}

#   pozn.:
#scalar  - jednoduchá proměnná (1 hodnota)
#list    - seznam hodnot (2 a více)
#dict    - seznam hodnot (klíč + hodnota)

*** Keywords ***

Secti
   [Arguments]    ${numberA}    ${numberB}
   [Documentation]  Klíčové slovo s parametry a návratovou hodnotou
   Log To Console    ${\n}${numberA}
   ${soucet}=        Evaluate    ${numberA}+${numberB}
   [return]          ${soucet}

#Poznámky: fce secti se vstupními argumenty (number A,B), spočítá součet a vrátí výslednou hodnotu