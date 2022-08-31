*** Settings ***
Library     OperatingSystem


*** Test Cases ***

Prvni test pozitivní
    ${res} =        run     man ls
    log             ${res}
    Should Contain  ${res}  Hmmm


Druhy test negativni
    ${res} =        run     man ahoj
    log             ${res}
    Should Contain  ${res}  No manual entry for aho




























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

