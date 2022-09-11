*** Settings ***
Library     OperatingSystem

*** Test Cases ***

Prvni test negativní
    ${res} =        run         dir adr_ktery_neexistuje
    log                 ${res}
    Should Contain      ${res}  File Not Found

Druhý test negativní
    ${res} =        run         dir adr_ktery_neexistuje
    log                 ${res}
    Should Contain      ${res}  File Not Found