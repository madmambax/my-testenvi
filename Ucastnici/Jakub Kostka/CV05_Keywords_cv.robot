*** Settings ***
Documentation     Cvičení na klíčová slova
...               Připravte 4 klíčová slova pro kalkulačku


*** Test Cases ***

Sčítání
        ${result}=  Secti  20  15  +            # use double spaces or tab between arguments
        Should Be Equal  ${result}  ${35}
        Log To Console  Vysledek je ${result}
Odečítání
        ${result}=  Odecti  20  15  -
        Should Be Equal  ${result}  ${5}
        Log To Console  Vysledek je ${result}
Násobení
        ${result}=  Nasob  20  15  *
        Should Be Equal  ${result}  ${300}
        Log To Console  Vysledek je ${result}
Dělení
        ${result}=  Del  20  15  /
        Should Be Equal  ${result}  ${1.3333333333333333}
        Log To Console  Vysledek je ${result}


*** Keywords ***

Secti
    [Arguments]  ${NUMBERA}  ${NUMBERB}  ${+}
    [Documentation]
    Log To Console  Hotovo
    ${res}=  Evaluate  ${NUMBERA}+${NUMBERB}
    [return]  ${res}

Odecti
    [Arguments]  ${NUMBERA}  ${NUMBERB}  ${-}
    ${res}=  Evaluate  ${NUMBERA}-${NUMBERB}
    [return]  ${res}

Nasob
    [Arguments]  ${NUMBERA}  ${NUMBERB}  ${*}
    ${res}=  Evaluate  ${NUMBERA}*${NUMBERB}
    [return]  ${res}

Del
    [Arguments]  ${NUMBERA}  ${NUMBERB}  ${/}
    ${res}=  Evaluate  ${NUMBERA}/${NUMBERB}
    [return]  ${res}