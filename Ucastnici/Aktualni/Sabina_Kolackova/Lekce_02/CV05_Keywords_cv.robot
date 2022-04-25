*** Settings ***
Documentation     Cvičení na klíčová slova
...               Připravte klíčové slovo pro kalkulačku


*** Test Cases ***

Sčítání
        ${result}=          Calculate  20   15  +
        Should Be Equal     ${result}  ${35}

Odečítání
        ${result}=          Calculate  20   15  -
        Should Be Equal     ${result}  ${5}

Násobení
        ${result}=          Calculate  20   15  *
        Should Be Equal     ${result}  ${300}

Dělení
        ${result}=          Calculate  20   10  /
        Should Be Equal     ${result}  ${2}


*** Keywords ***

Calculate
    [Arguments]    ${num1}      ${num2}     ${operace}
    ${res}=        Evaluate     ${num1}${operace}${num2}
    [return]       ${res}
