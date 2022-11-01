*** Test Cases ***
Prvni test negativní
    Ukazka KS   praha   brno  ostrava

*** Keywords ***
Ukazka KS
    [Arguments]      ${parametr1}   ${parametr2}  ${parametr3}
    @{seznam} =      Create List    ${parametr1}   ${parametr2}   ${parametr3}
    Log Many                  @{seznam}
    Log                       ${seznam}
    Log to Console            ${seznam}[1]


*** Test Cases ***
Prvni test negativní
    ${v} =              scitani        2  2
    Log to console      ${v}

*** Keywords ***
scitani
    [Arguments]     ${a}   ${b}
    ${v} =          Evaluate  ${a}+${b}
    [Return]        ${v}