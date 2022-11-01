*** Settings ***
Library     OperatingSystem

*** Variables ***
${GREET}    Hello
${NAME}     Daniel

*** Test Cases ***

Prvni test negativni
    ${cislo} =      Set Variable    10
    ${dc} =         Set Variable    10.23232
    ${res} =        run     dir neznamy_adresar
    log             ${res}  # Znakem dolaru se definuje proměnná.
    ${v} =          Evaluate  ${dc} * ${cislo}
    Log To Console  ${v}
    Log To Console  ${GREET} ${NAME}
    Should Contain  ${res}  File Not Found