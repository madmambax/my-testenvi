*** Settings ***
Library     OperatingSystem


*** Test Cases ***

Test
    Log To Console  Ahoj, čau

Prvni test pozitivní
    ${res} =        run     help dir
    log             ${res}
    Should Contain  ${res}  Displays a list of files and subdirectories in a directory.


Druhy test negativni
    ${res} =        run     help ahoj
    log             ${res}
    Should Contain  ${res}  This command is not supported by the help utility.