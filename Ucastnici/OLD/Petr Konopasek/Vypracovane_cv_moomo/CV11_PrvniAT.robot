*** Test Cases ***

Prvni test
    Log             Ahoj, já, jsem stroj!!! Chci, aby se mě ovládl.
    Log To Console    ${\n}${\n}Ahoj, já, jsem stroj!!!${\n}Chci, aby se mě ovládl.${\n}Číslo 5 stále žije${\n}Řekni to mé ruce!!${\n}




























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

