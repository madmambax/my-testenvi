*** Settings ***
Documentation     Cvičení na klíčová slova
...               Připravte 4 klíčová slova pro kalkulačku


*** Test Cases ***

Sčítání
        ${result}=          Calculate  20  15  +            # use double spaces or tab between arguments
        Should Be Equal     ${result}  ${35}



*** Keywords ***

Calculate
    [Arguments]    ${numberA}    ${numberB}   ${operator}
    Documentation  Klíčové slovo s parametry a návratovou hodnotou
    ${res}=        Evaluate    ${numberA}+${numberB}
    [return]       ${res}
