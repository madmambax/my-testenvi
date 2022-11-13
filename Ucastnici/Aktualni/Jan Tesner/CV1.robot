*** Settings ***
Library           OperatingSystem

*** Test Cases ***

Prvni test
    ${result} =      run            help copy
    Log             ${result}
    Should Contain  ${result}       Copies one or more files to another location

Druhy test
    ${result} =      run            help me
    Log              ${result}
    Should Contain   ${result}      This command is not supported by the help utility


















#*** Test Cases ***
#
#Prvni test
#    Log  Ahoj






























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

