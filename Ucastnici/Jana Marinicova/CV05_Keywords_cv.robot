*** Settings ***
Documentation     Cvičení na klíčová slova
...               Připravte 4 klíčová slova pro kalkulačku


*** Test Cases ***

Sčítání
        ${result}=          Calculate  20  15  +            # use double spaces or tab between arguments
        Should Be Equal     ${result}  ${35}

Odečítání
        ${odec}=            Calculate   20  9   -
        Should Be Equal     ${odec}     ${11}

Násobení
        ${nasob}            Calculate   5   4   *
        Should Be Equal     ${nasob}  ${20}

Dělení
        ${del}              Calculate   8   2   /
        Should Be Equal     ${del}      ${4}

*** Keywords ***

Calculate
    [Arguments]    ${num1}  ${num2}  ${operator}
    ${res}=        Evaluate    ${num1}${operator}${num2}
    [return]       ${res}
