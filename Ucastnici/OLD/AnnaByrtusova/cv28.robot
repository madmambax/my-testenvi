*** Settings ***
Documentation     Cvičení na klíčová slova
...               Připravte klíčové slovo pro kalkulačku


*** Test Cases ***

Sčítání
        ${result}=          Calculate  20  15  +            # use double spaces or tab between arguments
        Should Be Equal     ${result}  ${35}
        Log to console      ${\n}Výsledek 20 + 15 = ${result}

Odečítání
        ${result}=          Calculate  20  15  -            # use double spaces or tab between arguments
        Should Be Equal     ${result}  ${5}
        Log to console      ${\n}Výsledek 20 - 15 = ${result}


Násobení
        ${result}=          Calculate  20  15  *            # use double spaces or tab between arguments
        Should Be Equal     ${result}  ${300}
        Log to console      ${\n}Výsledek 20 * 15 = ${result}


Dělení
        ${result}=          Calculate  30  15  /            # use double spaces or tab between arguments
        Should Be Equal     ${result}  ${2}
        Log to console      ${\n}Výsledek 30 + 15 = ${result}


*** Keywords ***

Calculate
    [Arguments]    ${x}     ${y}    ${operator}
    ${res}=        Evaluate     ${x} ${operator} ${y}
    [return]       ${res}
