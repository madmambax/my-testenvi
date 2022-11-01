*** Settings ***
Library     OperatingSystem

*** Test Cases ***

prvni test
    ${result} =     run             dir neznamy_adresar
    log             ${result}
    Should Contain  ${result}       Directory of C:\

druhy test
    ${result} =     run             dir neznamy_adresar
    log             ${result}
    Should Contain  ${result}       File Not Found
















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

