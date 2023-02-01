*** Settings ***
Documentation     Cvičení na klíčová slova
...               Připravte klíčové slovo pro kalkulačku


*** Test Cases ***

Sčítání
        ${result}=          Calculate  20  15  +      # pozor je nutné pro oddělení parametrů používat min 2 mezery
        Should Be Equal     ${result}  ${35}

Odečítání


Násobení


Dělení
#    Should Be Equal As Numbers


*** Keywords ***

Calculate
    [Arguments]    #nutné doplnit
    ${res}=        Evaluate    #nutné doplnit
    [return]       ${res}
