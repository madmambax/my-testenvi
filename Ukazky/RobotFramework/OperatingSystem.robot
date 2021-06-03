#
# OS
#


*** Settings ***
Library           OperatingSystem



*** Variables ***



*** Test Cases ***
Test Ping
    ${output} =     Run     ping 8.8.8.8
    Log             ${output}


*** Keywords ***

OS
    [Arguments]     ${numberA}    ${numberB}   ${operator}
    Log to console  Parametr1: ${numberA} Parametr2: ${numberB} Parametr3: ${operator}