*** Settings ***
Library     OperatingSystem

*** Test Cases ***

Prvni test seznamy
        Login       dsadsad@sdas.cz                     dasdas                      Přihlásit
        &{slov} =   Create Dictionary       login=karel     heslo=adaad3        #hodnota je login a klíč je karel
        log many                             &{slov}
        log                                  ${slov}
        #Should Contain                       ${seznam}[0]   první

*** keywords ***
Login
    [Arguments]                ${pemail}      ${pheslo}     ${pnastane}
    @{seznam} =  Create list   ${pemail}      ${pheslo}     ${pnastane}
    log                        ${pemail}
    log                        ${pheslo}
    log                        ${pnastane}