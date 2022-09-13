*** Settings ***
Library     OperatingSystem

*** Test Cases ***

Prvni test negativní
    ${res} =        run         dir adr_ktery_neexistuje
    log console         ${res}
    Should Contain      ${res}  File Not Found
