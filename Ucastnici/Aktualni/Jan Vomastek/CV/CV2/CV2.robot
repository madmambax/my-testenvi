*** Variables ***
${AHOJ1}=    Ahoj

*** Test Cases ***
Promenne

#    @{zbozi}=   Create List    Jablko  Hruska  Redkev
#    Log To Console  ${AHOJ1}
#    Log To Console  @{zbozi}
#    Log To Console  ${zbozi}[0]
#    Log To Console  ${zbozi}[2]
    Key1
    Klicove slovo 2  Karle
    ${v}=  Secti    5    8
    Klicove slovo 2    ${v}
    

*** Keywords ***

Key1   
    Log To Console    ${\n}Ahoj
    Log To Console    ${\n}Cau

Klicove slovo 2
    [Arguments]     ${jmeno}
    Log To Console    ${\n}Cus Bus ${jmeno}
Secti
    [Arguments]     ${x}  ${y}
    ${vysledek}     Evaluate    ${x} + ${y}
    [Return]    ${vysledek}