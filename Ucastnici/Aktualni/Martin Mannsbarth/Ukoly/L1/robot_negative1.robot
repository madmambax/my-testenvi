*** Settings ***
Library     OperatingSystem
Library     String

*** Test Cases ***

Run whoami command
    ${res} =  run                                whoami blbost
    log                             ${res}
    Should Contain  ${res}          ERROR: Invalid argument/option - 'blbost'

Run hostname command
    ${res} =  run                                 hostname
    Log                              ${res}
    Should Not Contain               ${res}       LosTester