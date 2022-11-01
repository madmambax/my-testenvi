*** Settings ***
Library     OperatingSystem


*** Test Cases ***

Prvni test pozitivní
    ${res} =        run     ipconfig -all
    log             ${res}
    Should Contain  ${res}  Windows IP Configuration


Druhy test pozitivni
    ${res} =        run    ipconfig -all
    Log             ${res}
    Should Contain  ${res}  Wireless LAN