*** Settings ***
Library     OperatingSystem

*** Variables ***
${GREET}  File Not Found

*** Test Cases ***

Negativní test
    Ukazka KS1   229C-FC94
    ${res} =            run                       dir adr_ktery_neexistuje
    log to console      ${res}
    Should Contain      ${res}                    ${GREET}

*** keywords ***
Ukazka KS1
        [Arguments]  ${parametr1}
        @{seznam} =  Create list        ${parametr1}
        log many                        @{seznam}
        log                             ${seznam}
        log to console                  ${seznam}