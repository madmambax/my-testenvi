*** Test Cases ***

Prvni test negativní
    ${v} =              scitani        2  2
    Log to console      ${v}

*** Keywords ***

scitani
    [Arguments]     ${a}   ${b}
    ${v} =          Evaluate   ${a}+${b}
    [Return]        ${v}