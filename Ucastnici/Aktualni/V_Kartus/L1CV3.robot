*** Settings ***
Library     OperatingSystem

*** Test Cases ***

prvni test
    ${result} =     run             dir C:
    log             ${result}
    Should Contain  ${result}       02/09/2022  17:53               745 pokus.robot


druhy test
    ${result} =     run             dir C:
    log             ${result}
    Should Contain  ${result}       vojtechkartus






















#    Should Be Equal   ahoj              ahoj
#    Should Contain    ahoj dobrý den    ahoj
#    Should Be True    ${x}  < 100































#*** Settings ***
#Library           OperatingSystem
#
#
#*** Test Cases ***
#
#Prvni test
#    ${result} =      run            help
#    Log             ${result}
#    Should Contain  ${result}       For more information on a specific command, type HELP command-name
#
#Druhy test
#    ${result} =      run            TASKLIST
#    Should Contain   ${result}      Calculator.exe

