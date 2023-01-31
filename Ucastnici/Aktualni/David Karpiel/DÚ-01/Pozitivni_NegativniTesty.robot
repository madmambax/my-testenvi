*** Settings ***
Library    String
Library    OperatingSystem

*** Test Cases ***
První pozitivní test
        ${result} =  Run               help dir
        Log    ${result}
        Should Contain    ${result}    Displays a list of files and subdirectories in a directory.

Druhý pozitivní test
        ${result} =  Run               help
        Log    ${result}
        Should Contain    ${result}    For more information on a specific command, type HELP command-name

První negativní test
        ${result} =  Run               help dar
        Log    ${result}
        Should Contain    ${result}    This command is not supported by the help utility.

Druhý negativní test
        ${result} =  Run               help1
        Log    ${result}
        Should Contain    ${result}    'help1' is not recognized as an internal or external command