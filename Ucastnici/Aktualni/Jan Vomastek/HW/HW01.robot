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

Prvni test - pozitivni
    ${result} =      run            help
    Log             ${result}
    Should Contain  ${result}       For more information on a specific command, type HELP command-name

Druhy test - pozitivni
    ${result} =      run            help echo
    Log             ${result}
    Should Contain  ${result}      Displays messages, or turns command-echoing on or off.

Treti test - negativni
    ${result} =      run            help ahoj
    Log             ${result}
    Should not Contain  ${result}       For more information on a specific command, type HELP command-name

Ctvrty test - negativni
    ${result} =      run            cau
    Log             ${result}
    Should Contain  ${result}       is not recognized as an internal or external command

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

