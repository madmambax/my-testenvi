*** Settings ***

*** Variables ***
${nadpis}       Ahoj        # používat spíše tento
${nadpis2} =    Ahoj
@{list2}        3   5   7   9
*** Test Cases ***

Ukazka kličové slovo
    Log     asdf
    Moje prvni
    KS S Paramentrem    sgdfhdh
    Log     vypocet
    ${r}    Vypocet     2 3
Test na promene
    ${nadpis3}   Set Variable    Dobrý den
    ${x}    Set Variable    2
    ${y}    Set Variable    4

    Log     ${nadpis}
    Log     ${nadpis2}
    Log     ${nadpis3}
    ${v}    Evaluate    ${y} + ${x}
    Should Be Equal As Integers   ${v}        6

    Log To Console  ${v}                #vypíše v konzoli rovnou výsledek

    @{list}     Create List     1   4   8    10      #vytvoření listu
    Log To Console      ${list}[1]
    Log Many            @{list}

    &{dict}     Create Dictionary     rum=100   vodka=20      #vytvoření slovníku
    Log To Console      ${dict.rum}
    Log Many            &{dict}


   Should Be Equal     ${x}        2

*** Keywords ***
Moje prvni
    Log To Console   Ahoj

KS S paramentrem
    [Arguments]     ${prvni}
    Log To Console  ${prvni}

Vypocet
    [Arguments]     ${prvni}
    ${v}        Evaluate    ${x} + ${y}
    Log To Console          ${prvni}
    [Return]                ${v}