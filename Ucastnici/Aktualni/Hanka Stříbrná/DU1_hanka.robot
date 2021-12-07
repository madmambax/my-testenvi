*** Settings ***
Library     OperatingSystem


*** Test Cases ***


Prvni test pozitivní
    ${res} =        run     help
    log             ${res}
    Should Contain  ${res}  For more information on a specific command, type HELP command-name


Druhy test negativni
    ${res} =        run     help ahoj
    log             ${res}
    Should Contain  ${res}  This command is not supported by the help utility.

Třetí test pozitivní
    ${output}       Run     Dir
    Log             ${output}
    Should Contain  ${output}   report

Čtvrtý test pozitivní
    ${output}       Get File  text.txt
    log             ${output}
    Should Contain  ${output}   ahoj

Pátý text negativní
    ${output}       Get File  text.txt
    Log             ${output}
    Should not Contain  ${output}   čau

















