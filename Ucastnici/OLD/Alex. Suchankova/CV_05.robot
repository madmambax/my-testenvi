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
        ${result}=          Calculate  30  15  /            # use double spaces or tab between arguments
        Should Be Equal     ${result}  ${2}


*** Keywords ***

Calculate
    [Arguments]    ${No1}    ${No2}   ${Akce}   #nutné doplnit
    ${res}=        Evaluate  ${No1}${Akce}${No2}  #nutné doplnit
    [return]       ${res}
