*** Settings ***
Documentation     Cvičení na klíčová slova
...               Připravte klíčové slovo pro kalkulačku


*** Test Cases ***

Sčítání
        ${result}=          Calculate  20  15  +            # use double spaces or tab between arguments
        Should Be Equal     ${result}  ${35}

Odečítání


Násobení


Dělení



*** Keywords ***

Calculate
    [Arguments]    #nutné doplnit
    ${res}=        Evaluate    #nutné doplnit
    [return]       ${res}
