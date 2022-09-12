*** Settings ***
Library     OperatingSystem

*** Variables ***
${GREET}    Specifies drive, directory, and/or files to list.
${HELPDIR}  Specifies drive

*** Test Cases ***

Pozitivní test
    Ukazka KS                          Press any key to continue
    ${res} =        run                help dir
    log to console             ${res}
    Should Contain             ${res}              ${GREET}        # Proměná pro identifikaci help dir
    Should Contain             ${res}              ${HELPDIR}      # Proměná pro identifikaci help dir

*** keywords ***

Ukazka KS
        [Arguments]  ${parametr1}
        @{seznam} =  Create list        ${parametr1}
        log many                        @{seznam}
        log                             ${seznam}
        log to console                  ${seznam}