*** Settings ***
Documentation     Cvičení na klíčová slova
...               Připravte 4 klíčová slova pro kalkulačku


*** Test Cases ***

Sčítání
        ${result}=          Calculate  20  15  +            # use double spaces or tab between arguments
        Should Be Equal     ${result}  ${35}
        Log to console      ${\n}Výsledek odečítání 20 + 15 = ${result}
        #Log to console      ${\n}Výsledek sčítání     ${x} ${operator} ${y} = ${result}   #NEFUNKČNÍ!!! Nejsou to proměnnné, ale keywords...

Odečítání
        ${result}=          Calculate  20  15  -            # use double spaces or tab between arguments
        Should Be Equal     ${result}  ${5}
        Log to console      ${\n}Výsledek odečítání 20 - 15 = ${result}

Násobení
        ${result}=          Calculate  20  15  *            # use double spaces or tab between arguments
        Should Be Equal     ${result}  ${300}
        Log to console      ${\n}Výsledek násobení 20 * 15 = ${result}

Dělení
        ${result}=          Calculate  30  15  /            # use double spaces or tab between arguments
        Should Be Equal     ${result}  ${2}
        Log to console      ${\n}Výsledek dělení 30 + 15 = ${result}


*** Keywords ***

Calculate
    [Arguments]    ${x}     ${y}    ${operator}
    ${res}=        Evaluate     ${x} ${operator} ${y}
    [return]       ${res}
