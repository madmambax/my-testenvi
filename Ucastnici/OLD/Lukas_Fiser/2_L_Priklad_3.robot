*** Test Cases ***

Prvni test negativní
    Ukazka KS   praha   brno  ostrava

*** Keywords ***
# KLÍČOVÉ SLOVO:
Ukazka KS
    [Arguments]      ${parametr1}   ${parametr2}  ${parametr3}
    @{seznam} =      Create List    ${parametr1}   ${parametr2}   ${parametr3}
    Log Many                  @{seznam}
    Log                       ${seznam}
    Log to Console            ${seznam}[1]