*** Settings ***
Documentation     Cvičení na klíčová slova
...               Připravte klíčové slovo pro kalkulačku


*** Test Cases ***

Sčítání
        ${result}=          Calculate  20  15   +             # use double spaces or tab between arguments
        Should Be Equal     ${result}  ${35}

Odečítání
        ${result}=           Odecti  20  15   -           # use double spaces or tab between arguments
         Should Be Equal     ${result}  ${5}

Násobení
        ${result}=           Nasob  20  15   *           # use double spaces or tab between arguments
         Should Be Equal     ${result}  ${300}


Dělení
         ${result}=           Del  20  15   /           # use double spaces or tab between arguments
         Should Be Equal     ${result}   ${1.3333333333333333}




*** Keywords ***

Calculate
    [Arguments]     ${cislo1}   ${cislo2}   ${+}
    ${res}=          Evaluate      ${cislo1}${+}${cislo2}
    [return]         ${res}

Odecti
    [Arguments]     ${cislo1}   ${cislo2}   ${-}
    ${res}=          Evaluate      ${cislo1}${-}${cislo2}
    [return]         ${res}

Nasob
    [Arguments]     ${cislo1}   ${cislo2}   ${*}
    ${res}=          Evaluate      ${cislo1}${*}${cislo2}
    [return]         ${res}

Del
    [Arguments]     ${cislo1}   ${cislo2}   ${/}
    ${res}=          Evaluate      ${cislo1}${/}${cislo2}
    [return]         ${res}