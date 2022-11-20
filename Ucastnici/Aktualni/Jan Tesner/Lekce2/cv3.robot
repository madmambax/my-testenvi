*** Settings ***
Documentation     Cvičení na klíčová slova
...               Připravte klíčové slovo pro kalkulačku


*** Test Cases ***

Sčítání
        ${result}=          Calculate  20  15  +            # use double spaces or tab between arguments
        Should Be Equal     ${result}  ${35}

Odečítání
        ${result}=          Calculate  20  15  -            # use double spaces or tab between arguments
        Should Be Equal     ${result}  ${5}

Násobení
        ${result}=          Calculate  20  15  *            # use double spaces or tab between arguments
        Should Be Equal     ${result}  ${300}

Dělení
        ${result}=          Calculate  20  15  /            # use double spaces or tab between arguments
        Should Be Equal As Integers     ${result}  ${1}


*** Keywords ***

Calculate
    [Arguments]    ${x}  ${y}  ${operator}
    ${res}=        Evaluate  ${x}${operator}${y}    #nutné doplnit
    [return]       ${res}
