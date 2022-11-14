*** Settings ***
Library           OperatingSystem


*** Test Cases ***

Pozitivni test
    ${result} =      run            help mkdir
    Log             ${result}
    Should Contain  ${result}       Creates a directory.

Negativni test
    ${result} =      run            help jshg
    Should Contain   ${result}      This command is not supported by the help utility.
