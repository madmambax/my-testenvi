*** Settings ***
Documentation     Cvičení na klíčová slova
...               Připravte klíčové slovo pro kalkulačku


*** Test Cases ***

Sčítání
        ${result}=          Calculate  20  15  +            # use double spaces or tab between arguments
        Should Be Equal     ${result}  ${35}

Odečítání
        ${result}=          Calculate  20  15  -            # use double spaces or tab between arguments
        Should Be Equal     ${result}  ${20-15}

Násobení
        ${result}=          Calculate  20  15  *            # use double spaces or tab between arguments
        Should Be Equal     ${result}  ${20*15}

Dělení
        ${result}=          Calculate  100  0.15  /            # use double spaces or tab between arguments
        Should Be Equal     ${result}  ${100/0.15}


*** Keywords ***

Calculate
    [Arguments]    ${x}     ${y}    ${operator}     #nutné doplnit
    ${res}=        Evaluate  ${x} ${operator} ${y}  #nutné doplnit
    [return]       ${res}
