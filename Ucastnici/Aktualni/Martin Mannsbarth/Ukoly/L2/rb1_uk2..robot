*** Settings ***
Documentation   DU2 part1
Library     OperatingSystem
Library     String


*** Variables ***
# need use double \\ for string check
${cmd_who}                      whoami
${cmd_host}                     hostname
${WHO}                          hp-madmax\\hpzbook
${HOST}                         HP-MadMax

*** Test Cases ***

Run whoami command
    ${result}=   Verify         ${cmd_who}
    log                         ${result}
    Should Be Equal As Strings  ${result}  ${WHO}


Run hostname command
    ${result}=   Verify         ${cmd_host}
    Log                         ${result}
    Should Contain              ${result}   ${HOST}


*** Keywords ***

Verify
     [Arguments]         ${command}
     ${res}=       Run   ${command}
     [Return]            ${res}