*** Settings ***
Documentation     Cvičení na klíčová slova
...               Připravte klíčové slovo pro kalkulačku


*** Test Cases ***

Sčítání
        ${result}=          Calculate  20  15  +            # use double spaces or tab between arguments
        Should Be Equal     ${result}  ${35}

Odečítání
        ${result}=          Secti       20  5  -              # use double spaces or tab between arguments
        Should Be Equal     ${result}   ${15}


Násobení
        ${result}=          Secti       5  5  *
        Should Be Equal     ${result}   ${25}

Dělení
        ${result}=          Secti       20  2  /
        Should Be Equal     ${result}   ${10}


*** Keywords ***

Calculate
    [Arguments]    ${a} ${b} ${operator}
    ${res}=        Evaluate     ${a}${operator}${b}
    [return]       ${res}
