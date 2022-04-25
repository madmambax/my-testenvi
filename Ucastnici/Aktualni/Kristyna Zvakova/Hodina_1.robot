*** Settings ***
Library    OperatingSystem

*** Test Cases ***

Prvni test pozitivni
    ${res}=         run     help dir
    log             ${res}
    Should contain  ${res}    For more information on a specific command, type HELP command-name.

Druhy test negativni
    ${res}=         run     help ahoj
    log             ${res}
    Should contain  ${res}    This command is not supported by the help utility.