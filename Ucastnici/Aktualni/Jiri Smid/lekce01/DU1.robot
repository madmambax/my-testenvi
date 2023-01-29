# Domácí úkol - lekce 01

*** Settings ***
Library     String
Library     OperatingSystem

*** Variables ***
${NEGPARAM1}  The syntax of the command is incorrect.

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
    Should Contain  ${res}  ${NEGPARAM1}


Druhý negativní automatický test
    ${res} =        run     open negativnitest.txt
    log             ${res}
    Should Contain  ${res}  is not recognized as an internal or external command