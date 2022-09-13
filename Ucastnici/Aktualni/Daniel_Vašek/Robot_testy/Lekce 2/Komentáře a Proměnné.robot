*** Settings ***
Library     OperatingSystem

*** Variables ***

${Greet}    Hello
${Name}     Daniel

*** Test Cases ***
# Komentáře k tomu se používají křížek

Prvni test negativní
    ${cislo} =      Set Variable    10
    ${dc} =         Set Variable    10.23232
    ${r} =          Set Variable    ahoj
    ${res} =        run             dir adr_ktery_neexistuje
    log             ${res}
    ${v}            Evaluate       ${dc} * 2
    Log to Console                  ${v}
    Log to console                  ${cislo}
    Log to console                  ${dc}
    Log to console                  ${r}
    Should Contain   ${res}      File Not Found


*** Test Cases ***

Drzuy test negativni
    ${cislo} =      Set Variable    10
    ${dc} =         Set Variable    10.23232
    ${res} =        run     dir neznamy_adresar
    log             ${res}  # Znakem dolaru se definuje proměnná.
    ${v} =          Evaluate  ${dc} * ${cislo}
    Log To Console  ${v}
    Log To Console  ${GREET}  ${NAME}
    Should Contain  ${res}  File Not Found

