*** Settings ***
Library     OperatingSystem


*** Variables ***
${GREET}  Hello
${NAME}   Daniel

*** Test Cases ***

Prvni test seznamy
        @{seznam} =  Create list        první   druhý    třetí
        log many                        @{seznam}
        log                             ${seznam}
        log to console                  ${seznam}[1]

        &{slov} =   Create Dictionary       login=karel     heslo=adaad3        #hodnota je login a klíč je karel
        log many                             &{slov}
        log                                  ${slov}
        Should Contain                       ${seznam}[0]   první
