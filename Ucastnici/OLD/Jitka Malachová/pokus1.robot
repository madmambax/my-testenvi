*** Settings ***
Library     OperatingSystem


*** Test Cases ***


Prvni test pozitivní
    ${res} =        run     systeminfo
    log             ${res}
    Should Contain  ${res}   Microsoft Windows 10 Home

Druhy test pozitivní
    ${res} =        run  ver
    log             ${res}
    Should Contain  ${res}  Microsoft Windows [Version 10.0.19043.1348]

Prvni test negativni
    ${res} =        run     systeminfo
    log             ${res}
    Should Contain  ${res}  This command is supported by the help utility.

Druhy test negativni
    ${res} =        run     ver
    log             ${res}
    Should Contain  ${res}  Microsoft Windows [Version 10.0.19043.1347]
