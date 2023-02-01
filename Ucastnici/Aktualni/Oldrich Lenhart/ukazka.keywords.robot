*** Settings ***
Library    OperatingSystem

*** Variables ***
${Pozdrav}   Ahoj


*** Test Cases ***

Ukazka prace s KS
    Log   Zaciname
    Moje prvni KS   Honzo
    ${vysledek}=  Secti  2  5
    Log To Console    ${vysledek}



*** Keywords ***

Moje prvni KS
    [Arguments]       ${Jmeno}
    Log To Console    Dobrý den, ${Jmeno}


Secti
    [Arguments]         ${A}  ${B}
    ${v} =              Evaluate  ${A}+${B}
    [Return]            ${v}