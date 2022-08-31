*** Settings ***
Library     OperatingSystem


*** Test Cases ***

Prvni test pozitivní
    ${res} =        run     help dir
    log             ${res}
    Should Contain  ${res}  Displays a list of files and subdirectories in a directory.


Druhy test negativni
    ${res} =        run     help ahoj
    log             ${res}
    Should Contain  ${res}  This command is not supported by the help utility.




























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

