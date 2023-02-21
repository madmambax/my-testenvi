# Domácí úkol - lekce 02

*** Settings ***
Library     String
Library     OperatingSystem

*** Variables ***
${text1}  help cls
${POZPARAM1}  Wireless LAN adapter
${NEGPARAM1}  The syntax of the command is incorrect.
${prikaz}  open negativnitest.txt
@{prikaz_overeni}  is not recognized as an internal or external command   wi-fi   lan

*** Test Cases ***

První pozitivní automatický test
    ${res} =        Sprint     ${text1}
    log             Information about "${text1}": ${res}
    Should Contain  ${res}  Clears the screen.


Druhý pozitivní automatický test
    ${res} =        Sprint     ipconfig
    log             Windows IP Configuration: ${res}
    Should Contain  ${res}  ${POZPARAM1}


První negativní automatický test
    ${res} =        Sprint     mkdir
    log             ${res}
    Should Contain  ${res}  ${NEGPARAM1}


Druhý negativní automatický test
    ${res} =        Sprint     ${prikaz}
    log             ${res}
    Should Contain  ${res}  ${prikaz_overeni}[0]


*** Keywords ***
Sprint
   [Arguments]    ${command}
   ${res}=        Run    ${command}
   [return]       ${res}
