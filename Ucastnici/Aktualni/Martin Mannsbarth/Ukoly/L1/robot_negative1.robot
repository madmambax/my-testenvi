*** Settings ***
Library     OperatingSystem
Library     String

*** Test Cases ***

Run whoami command
    ${res} =  run                                whoami
    log                             ${res}
    Should Not Be Equal As Strings  ${res}       hpzbook

Run hostname command
    ${res} =  run                                 hostname
    Log                              ${res}
    Should Not Contain               ${res}       LosTester