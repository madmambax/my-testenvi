*** Settings ***
Library           OperatingSystem

*** Test Cases ***

Prvni negativni test
    ${result} =      run            dir E:\Windows
    Log             ${result}
    Should Contain  ${result}       File Not Found

Druhy negativni test
    ${result} =      run            dir D:\DriveOne
    Log              ${result}
    Should Contain   ${result}      File Not Found