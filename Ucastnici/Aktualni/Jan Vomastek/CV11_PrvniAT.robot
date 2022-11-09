#*** Settings ***
#Library     OperatingSystem
#
#*** Test Cases ***
#
#Prvni test


#    run     help
#    Log  Ahoj


*** Settings ***
Library           OperatingSystem


*** Test Cases ***

Prvni test
    ${result} =      run            help
    Log             ${result}
    Should Contain  ${result}       For more information on a specific command, type HELP command-name

Druhy test
    ${result} =      run            help ahoj
    Log             ${result}
    Should Contain  ${result}       For more information on a specific command, type HELP command-name

Treti test
    ${result} =      run            help ahoj
    Log             ${result}
    Should not Contain  ${result}       For more information on a specific command, type HELP command-name

Ctvrty test
    ${result} =      run            help ahoj
    Log             ${result}
    Should Contain  ${result}       This command is not supported by the help utility.

#Druhy test
#    ${result} =      run            TASKLIST
#    Should Contain   ${result}      Calculator.exe







































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

