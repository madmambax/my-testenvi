*** Settings ***
Documentation     Cvičení na klíčová slova
...               Připravte klíčové slovo pro kalkulačku


*** Test Cases ***

Sčítání
        ${result}=          Calculate  20  15  +          # use double spaces or tab between arguments
        Should Be Equal     ${result}  ${35}

Odečítání
    ${result}=          Calculate  20  15  -          # use double spaces or tab between arguments
    Should Be Equal     ${result}  ${5}

Násobení
    ${result}=          Calculate  2  15  *          # use double spaces or tab between arguments
    Should Be Equal     ${result}  ${30}

Dělení
    ${result}=          Calculate  20  5  /          # use double spaces or tab between arguments
    Should Be Equal     ${result}  ${4}


*** Keywords ***

Calculate
    [Arguments]    ${numberA}  ${numberB}  ${operator}
    ${res}=        Evaluate  ${numberA} ${operator} ${numberB}
    [return]       ${res}
