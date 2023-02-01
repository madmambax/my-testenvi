*** Settings ***
Documentation     Cvičení na klíčová slova
...               Připravte klíčové slovo pro kalkulačku


*** Test Cases ***

Sčítání
        ${result}=          Calculate  20  15  +      # pozor je nutné pro oddělení parametrů používat min 2 mezery
        Should Be Equal     ${result}  ${35}

Odečítání
        ${result}=          Calculate  20  15  -
        Should Be Equal     ${result}  ${5}
Násobení
        ${result}=          Calculate  20  15  *
        Should Be Equal     ${result}  ${300}

Dělení
        ${result}=          Calculate  20  15  /
        Should Be Equal As Numbers       ${result}  ${1.3}


*** Keywords ***

Calculate
    [Arguments]    ${cislo1}    ${cislo2}   ${akce}
    ${result}=        Evaluate    ${cislo1}${akce}${cislo2}
    [return]       ${result}
