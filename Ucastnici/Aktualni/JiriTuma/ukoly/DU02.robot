*** Settings ***
Library     OperatingSystem

*** Variables ***
${helpDir}          help dir
${message}          Display the thousand separator in file sizes.

*** Test Cases ***

Prvni test pozitivní
    ${res} =        run     ${helpDir}  
    log             ${res}
    Should Contain  ${res}  ${message} 

Druhy test pozitivní
    ${res} =        run     dir
    log             ${res}
    Should Contain  ${res}  Volume Serial Number is


Prvni test negativni
    ${res} =        run     just now
    log                 ${res}
    Should Contain  ${res}  just now.

Druhy test negativni
    ${res} =        run     ver
    log             ${res}
    Should Not Contain  ${res}  Version

*** Keywords ***
Verify
     [Arguments]         ${command}
     ${res}=       Run   ${command}
     [Return]            ${res}