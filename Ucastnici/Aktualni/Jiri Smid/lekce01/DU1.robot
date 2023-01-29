*** Settings ***
Library     OperatingSystem

*** Test Cases ***

První pozitivní automatický test
    ${res} =        run     help cls
    log             ${res}
    Should Contain  ${res}  Clears the screen.


Druhý pozitivní automatický test
    ${res} =        run     ipconfig
    log             ${res}
    Should Contain  ${res}  Wireless LAN adapter

První negativní automatický test
    ${res} =        run     mkdir
    log             ${res}
    Should Contain  ${res}  The syntax of the command is incorrect.


Druhý negativní automatický test
    ${res} =        run     negativnitest.txt
    log             ${res}
    Should Contain  ${res}  is not recognized as an internal or external command