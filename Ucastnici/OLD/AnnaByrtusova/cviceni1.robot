*** Settings ***
Library           OperatingSystem



*** Test Cases ***


Pozitivni test1
    ${result} =      run            help
    Log             ${result}
    Should Contain  ${result}       For more information on a specific command, type HELP command-name

Negativni test1
    ${res} =        run     help ahoj
    log             ${res}
    Should Contain  ${res}  For more information on a specific command, type HELP command-name

Pozitivni test2

    ${result} =      run            help dir
    Log             ${result}
    Should Contain  ${result}       Displays a list of files and subdirectories in a directory.

Negativni test2
    ${res} =        run     help dir nesmysl
    log             ${res}
    Should Contain  ${res}  Displays a list of files and subdirectories in a directory.

Pozitivní test3
    ${res} =        run     test
    log             ${res}
    Should Contain  ${res}  'test' is not recognized as an internal or external command

Negativní test3
    ${res} =        run     testování
    log             ${res}
    Should Contain  ${res}  'test' is not recognized as an internal or external command





