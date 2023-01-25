*** Settings ***
Library    String
Library    OperatingSystem

*** Variables ***

*** Keywords ***

*** Test Cases ***
Pozitivní test
<<<<<<< HEAD
        ${result} =      Run            help dir
=======
        ${result} =     Run            help dir
>>>>>>> c9c197b (První přidání do Gitu)
        Log    ${result}
        Should Contain    ${result}    Displays a list of files and subdirectories in a directory.

Negativní test
<<<<<<< HEAD
        ${result} =       Run           help dar
=======
        ${result} =      Run           help dar
>>>>>>> c9c197b (První přidání do Gitu)
        Log    ${result}
        Should Contain    ${result}    This command is not supported by the help utility.