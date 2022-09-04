*** Settings ***
Library     OperatingSystem

*** Test Cases ***

Prvni test negativní
    ${res} =        run        dir
    log                ${res}
    Should notContain  ${res}  Last Written


Druhy test negativní
    ${res} =        run        dir
    log                ${res}
    Should notContain  ${res}  Last Written