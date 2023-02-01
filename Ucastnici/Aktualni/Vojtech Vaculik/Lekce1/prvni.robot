*** Settings ***
Library    String
Library    OperatingSystem

*** Variables ***

*** Keywords ***

*** Test Cases ***
Pozitivní test
        ${result} =  Run               help dir
        Log    ${result}
        Should Contain    ${result}    Displays a list of files and subdirectories in a directory.

Negativní test
        ${result} =  Run               help blabla
        Log    ${result}
        Should Contain    ${result}    This command is not supported by the help utility.