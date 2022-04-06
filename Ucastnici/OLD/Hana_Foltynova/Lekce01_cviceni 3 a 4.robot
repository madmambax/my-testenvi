*** Settings ***
Library     OperatingSystem

*** Test Cases ***
Prvni test pozitivní
    ${res} =        run     help
    log             ${res}
    Should Contain  ${res}  For more information on a specific command, type HELP command-name
    
Druhy test pozitivní
    ${res} =        run     npm -h
    log             ${res}
    Should Contain  ${res}  Usage
    
Prvni test negativni
    ${res} =        run     help nesmysl
    log             ${res}
    Should Contain  ${res}  This command is not supported by the help utility.
    
Druhy test negativni
    ${res} =        run     helpp
    log             ${res}
    Should Contain  ${res}  'helpp' is not recognized as an internal or external command,
