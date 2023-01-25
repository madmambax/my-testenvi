*** Settings ***

Documentation       Klicove slovo


*** Variables ***
${GREET1}     Jasas
${GREET2}     Kalimera
${GREET3}     Kalispera

*** Test Cases ***
    Log     ${GREET2}
    Moje first
    Moje first
    Moje first


KS S parametrem
    Pozdrav  Karle
    Pozdrav  Honzo


*** Keywords ***

Moje first
    Log To Console    Cago Belo

Pozdrav
    [Arguments]  ${jmeno}

    Log To Console    Ahoj  ${jmeno}


Secti
   [Arguments]    ${x}   ${y}