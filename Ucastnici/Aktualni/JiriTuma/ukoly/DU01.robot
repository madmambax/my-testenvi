*** Settings ***
Library     OperatingSystem


*** Test Cases ***

Prvni test pozitivní
    ${res} =        run     help dir
    log             ${res}
    Should Contain  ${res}  Display the thousand separator in file sizes.

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