*** Settings ***
Library           OperatingSystem

*** Test Cases ***

Prvni pozitivni test
    ${result} =      run            dir D:\OneDrive
    Log             ${result}
    Should Contain  ${result}       Getting started with OneDrive.pdf

Druhy pozitivni test
    ${result} =      run            dir C:\Users
    Log             ${result}
    Should Contain  ${result}       tesne