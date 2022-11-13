*** Settings ***
Library           OperatingSystem



*** Test Cases ***

Pozitivni test 0
    ${result} =      run            help cd
    Log             ${result}
    Should Contain  ${result}       Type CD without parameters to display the current drive and directory.

Pozitivni test 1
    ${result} =      run            dir
    Log             ${result}
    Should Contain  ${result}       jak_automatizovat_testy

Pozitivni test 2
    ${result} =      run            cd
    Log             ${result}
    Should Contain  ${result}       PycharmProjects

Negativni test 0
    ${result} =      run            help neznamy
    Log             ${result}
    Should Contain  ${result}       This command is not supported by the help utility.

Negativni test 1
    ${result} =      run            rmdir
    Log             ${result}
    Should Contain  ${result}       The syntax of the command is incorrect.

Negativni test 2
    ${result} =      run            xcopy neexistujici
    Log             ${result}
    Should Contain  ${result}       File not found