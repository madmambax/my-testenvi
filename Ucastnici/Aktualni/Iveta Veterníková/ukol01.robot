*** Settings ***
Library     OperatingSystem

*** Test Cases ***

# Prvni test pozitivní
#     ${res} =        run     help
#     log             ${res}
#     Should Contain  ${res}  For more information on a specific command, type HELP command-name


# První test pozitivní úkol
#     ${res} =        run     time
#     log             ${res}
#     Should Contain  ${res}  

toto je test
    ${output} =       Run           help
    Log To Console    ${output}


# Druhy test negativni
#     ${res} =        run     help ahoj
#     log             ${res}
#     Should Contain  ${res}  This command is not supported by the help utility.