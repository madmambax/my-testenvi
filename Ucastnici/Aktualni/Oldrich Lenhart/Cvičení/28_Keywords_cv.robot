*** Settings ***
Documentation     Cvičení na klíčová slova
...               Připravte klíčové slovo pro kalkulačku


*** Test Cases ***

Sčítání
        ${result}=          Calculate  20  15  +      # pozor je nutné pro oddělení parametrů používat min 2 mezery
        Should Be Equal     ${result}  ${35}

Odečítání
        ${result}=          Calculate  20  15  -      # pozor je nutné pro oddělení parametrů používat min 2 mezery
        Should Be Equal     ${result}  ${5}

Násobení
        ${result}=          Calculate  20  15  *      # pozor je nutné pro oddělení parametrů používat min 2 mezery
        Should Be Equal     ${result}  ${300}

Dělení
        ${result}=          Calculate  20  15  /      # pozor je nutné pro oddělení parametrů používat min 2 mezery
        Should Be Equal As Numbers     ${result}  ${1.3333333333333333}


*** Keywords ***

Calculate
    [Arguments]    ${A}  ${B}  ${C}
    ${res}=        Evaluate    ${A}${C}${B}
    [return]       ${res}
