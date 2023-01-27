*** Settings ***
Library     OperatingSystem
Library     String

*** Test Cases ***
# need use double \\ for string check
Run whoami command
    ${res} =  run                       whoami
    log                         ${res}
    Should Be Equal As Strings  ${res}  hp-madmax\\hpzbook


Run hostname command
    ${res} =  run                        hostname
    Log                         ${res}
    Should Contain              ${res}   HP-MadMax
