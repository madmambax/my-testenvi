*** Comments ***

*** Settings ***
Documentation     Cvičení na klíčová slova
...               Připravte klíčové slovo pro kalkulačku    # Co znamenaj ty 3 tečky na začátku řádku?

*** Test Cases ***
1. Sčítání
    [Documentation]    Klíč. slovo na sčítání 2 čísel
    [Tags]              nefunguje
    ${result}=          Calculate  20  10  +           # Use double spaces or 'tab' between arguments.
    Should Be Equal     ${result}  ${30}

2. Odečítání
    [Documentation]    Klíč. slovo na odečítání 2 čísel
    [Tags]              nefunguje
     ${result}=      Calculate  20  10  -
    Should Be Equal  ${result}  ${10}

3. Násobení
    [Documentation]    Klíč. slovo na násobení 2 čísel
    [Tags]              nefunguje
    ${result}=      Calculate  20  10  *
    Should Be Equal  ${result}  ${200}

4. Dělení
    [Documentation]    Klíč. slovo na dělení 2 čísel
    [Tags]               nefunguje
    ${result}=       Calculate  20  10  /
    Should Be Equal  ${result}  ${2}

*** Keywords ***
Calculate
    [Arguments]  ${numberA}  ${numberB}  ${operand}
    ${res}=  Evaluate  ${numberA}+${numberB}
    [return]  ${res}
