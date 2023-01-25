*** Settings ***
Library    String
Library    OperatingSystem

*** Variables ***
${x}    10
${text}    assdasdjksahd

*** Test Cases ***

Prvni test
    ${result} =      run            help dir
    Log              ${result}

    Should Contain   ${result}      Displays a list of files and subdirectories in a directory

Druhy test
    ${result} =      run            help tohlejespatne
    Log              ${result}

    Should Contain   ${result}      This command is not supported by the help utility.