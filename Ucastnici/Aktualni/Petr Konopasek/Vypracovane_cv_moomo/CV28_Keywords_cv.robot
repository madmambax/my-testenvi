# vyplněno 16.11.2022 - moomo1976@gmail.com CV v Lekci č.2.

*** Settings ***
Documentation     Cvičení na klíčová slova
...               Připravte klíčové slovo pro kalkulačku


*** Test Cases ***

Sčítání
        ${res}=          Calculate  20  15  +
        Should Be Equal     ${res}  ${35}

Odečítání
        ${res}=          Calculate  20  15  -
        Should Be Equal     ${res}  ${5}

Násobení
        ${res}=           Calculate  20  15  *
        Should Be Equal     ${res}  ${300}

Dělení
        ${res}=           Calculate  210  15  /
        Should Be Equal     ${res}  ${14}


*** Keywords ***

Calculate
    [Arguments]    ${x}  ${y}  ${operator}            # Přidana třetí proměnná operátor
    ${res}=        Evaluate    ${x} ${operator} ${y}  # $x     Přidana třetí proměnná $operátor    $y
    [return]       ${res}

# vyplněno 16.11.2022 - moomo1976@gmail.com CV v Lekci č.2.