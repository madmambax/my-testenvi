*** Settings ***
Documentation     Používání klíčových slov


*** Test Cases ***

Ukázka práce s KS
     Log To Console    Zaciname
     Moje první KS   Karle
     ${vysledek} =  Secti      2   5
     Log To Console    ${vysledek}

*** Keywords ***

Moje první KS
    [Arguments]         ${Jmeno}
    Log to console      Dobrý den, ${Jmeno}

Secti
    [Arguments]         ${A}    ${B}
    ${v} =  Evaluate    ${A}+${B}
    [Return]            ${v}