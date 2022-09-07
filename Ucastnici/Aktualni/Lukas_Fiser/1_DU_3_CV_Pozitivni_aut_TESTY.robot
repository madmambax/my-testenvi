*** Settings ***
Library     OperatingSystem


*** Test Cases ***

Prvni test pozitivní
    ${res} =        run     echo
    log             ${res}
    Should Contain  ${res}  ECHO is on.

Druhy test pozitivni
    ${res} =        run     ipconfig
    Log             ${res}
    Should Contain  ${res}  IPv4 Address

