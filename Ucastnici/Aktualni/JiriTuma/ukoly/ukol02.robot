
*** Settings ***
Library     OperatingSystem

*** Variables ***
${DIR_COMMAND}      dir

*** Keywords ***
Run Help Ahoj
    ${value} =  Run    help ahoj
    RETURN      ${value}

*** Test Cases ***

Prvni test pozitivní
    ${res} =        run     help ${DIR_COMMAND}
    Should Contain  ${res}  Displays a list of files and subdirectories in a directory.

Druhy test pozitivní
    ${res} =        run     ${DIR_COMMAND}
    Should Contain  ${res}  Directory of


Prvni test negativni
    ${res} =        Run Help Ahoj
    Should Contain  ${res}  This command is not supported by the help utility.

Druhy test negativni
    ${res} =        run     man
    Should Contain  ${res}  'man' is not recognized as an internal or external command