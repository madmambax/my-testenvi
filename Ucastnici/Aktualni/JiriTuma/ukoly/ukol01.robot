*** Settings ***
Library     OperatingSystem


*** Test Cases ***

Prvni test pozitivní
    ${res} =        run     help dir
    Should Contain  ${res}  Displays a list of files and subdirectories in a directory.

Druhy test pozitivní
    ${res} =        run     dir
    Should Contain  ${res}  Directory of


Prvni test negativni
    ${res} =        run     help ahoj
    Should Contain  ${res}  This command is not supported by the help utility.

Druhy test negativni
    ${res} =        run     man
    Should Contain  ${res}  'man' is not recognized as an internal or external command, operable program or batch file.