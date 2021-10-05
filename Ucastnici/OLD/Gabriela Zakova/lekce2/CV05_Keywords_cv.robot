*** Settings ***
Documentation     Cvičení na klíčová slova
...               Připravte klíčové slovo pro kalkulačku


*** Test Cases ***

Sčítání
        ${vysledek}=          Calculate  20  15  +            # use double spaces or tab between arguments
        Should Be Equal     ${vysledek}  ${35}

Odečítání
        ${vysledek}=          Calculate  20  15  -            # use double spaces or tab between arguments
        Should Be Equal     ${vysledek}  ${5}

Násobení
        ${vysledek}=          Calculate  20  15  *            # use double spaces or tab between arguments
        Should Be Equal     ${vysledek}  ${300}

Dělení
        ${vysledek}=           Calculate  210  15  /            # use double spaces or tab between arguments
        Should Be Equal     ${vysledek}  ${14}


*** Keywords ***

Calculate
    [Arguments]    ${cislo1}  ${cislo2}  ${operator}    #nutné doplnit
    ${vysledek}=        Evaluate    ${cislo1}${operator}${cislo2}    #nutné doplnit
    [return]       ${vysledek}
