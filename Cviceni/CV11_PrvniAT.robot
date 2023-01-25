*** Settings ***
Library    String

*** Variables ***
${x}    10

*** Test Cases ***

Prvni test
    Log               Ahoj
    Should Contain    Ahoj    ho
    Should Be True    10 > 1
    


















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

