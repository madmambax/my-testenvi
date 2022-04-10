*** Settings ***
Library     OperatingSystem


*** Test Cases ***

Prvni test pozitivní
    ${res} =        run     help
    log             ${res}
    Should Contain  ${res}  For more information on a specific command, type HELP command-name

Druhý test pozitivní
    ${res} =        run     help dir
    log             ${res}
    Should Contain  ${res}  Display the thousand separator in file sizes.

Třetí test negativni
    ${res} =        run     help ahoj
    log             ${res}
    Should Contain  ${res}  This command is not supported by the help utility.

Čtvrtý test negativní
    ${res} =        run     help123
    log             ${res}
    Should Contain  ${res}  is not recognized as an internal or external command,