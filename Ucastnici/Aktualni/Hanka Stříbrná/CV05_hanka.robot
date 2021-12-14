*** Settings ***
Documentation     Cvičení na klíčová slova
...               Připravte klíčové slovo pro kalkulačku


*** Test Cases ***

Sčítání
        ${result}=          Calculate  20  15   +        # use double spaces or tab between arguments
        Should Be Equal     ${result}  ${35}

Odečítání
        ${result}=          Calculate   20  15  -
        Should Be Equal     ${result}   ${5}

Násobení
        ${result}           Calculate  20   15  *
        Should Be Equal     ${result}   ${300}

Dělení
        ${result}            Calculate  20   15  /
        Log To Console      ${result}
        Should Contain      ${result}   1



*** Keywords ***

Calculate
    [Arguments]    ${numberA}      ${numberB}       ${akce}
    ${res}=        Evaluate        ${numberA}${akce}${numberB}
    [return]       ${res}
