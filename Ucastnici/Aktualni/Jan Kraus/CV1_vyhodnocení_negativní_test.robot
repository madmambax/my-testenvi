
*** Settings ***
Library     OperatingSystem

*** Variables ***
${GREET}  File Not Found
${NAME}   is not recognized as an internal or external command

*** Test Cases ***

Prvni test negativní
    ${res} =            run                       dir adr_ktery_neexistuje
    log to console      ${res}
    Should Contain      ${res}                    ${GREET}



Druhý test negativní
    ${res} =            run                       dva
    log to console      ${res}
    Should Contain      ${res}                    ${NAME}