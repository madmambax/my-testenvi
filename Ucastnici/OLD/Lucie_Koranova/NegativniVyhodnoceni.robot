*** Settings ***
Library     OperatingSystem


*** Test Cases ***

Prvni test negativní
    ${res} =        run     ipconfig -all
    log             ${res}
    Should Contain  ${res}  Media disconnected


Druhy test negativní
    ${res} =        run    help neznamy
    Log             ${res}
    Should Contain  ${res}  This command is not supported by the help utility.