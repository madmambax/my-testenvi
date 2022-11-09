*** Settings ***
Library           OperatingSystem



*** Test Cases ***

Prvni test pozitivni
    ${result} =      run            help cd
    Log             ${result}
    Should Contain  ${result}       Type CD without parameters to display the current drive and directory.

Druhy test negativni
    ${result} =      run            helpcd
    Log             ${result}
    Should Contain  ${result}       This command is not supported by the help utility.