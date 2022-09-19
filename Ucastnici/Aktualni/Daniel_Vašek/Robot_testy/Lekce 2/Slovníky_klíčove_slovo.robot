*** Settings ***
Library     OperatingSystem

*** Test Cases ***

Prvni test seznamy
        Ukazka KS   nevim   ahoj   dan

        &{slov} =   Create Dictionary       login=karel     heslo=adaad3        #hodnota je login a klíč je karel
        log many                             &{slov}
        log                                  ${slov}
        #Should Contain                       ${seznam}[0]   první

*** keywords ***

Ukazka KS
        [Arguments]  ${parametr1}       ${parametr2}   ${parametr3}
        @{seznam} =  Create list        ${parametr1}   ${parametr2}   ${parametr3}
        log many                        @{seznam}
        log                             ${seznam}
        log to console                  ${seznam}[2]