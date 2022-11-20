*** Settings ***
Library           OperatingSystem
Documentation

*** Variables ***
${output_text}  File Not Found

*** Test Cases ***

Prvni pozitivni test
    ${result} =      run            dir D:\OneDrive
    Log             ${result}
    Should Contain  ${result}       Getting started with OneDrive.pdf

Druhy pozitivni test
    ${result} =      run            dir C:\Users
    Log             ${result}
    Should Contain  ${result}       tesne

Prvni negativni test
    ${result} =      run            dir E:\Windows
    Log             ${result}
    Should Contain  ${result}       ${output_text}

Druhy negativni test
    ${result} =      run            dir D:\DriveOne
    Log              ${result}
    Should Contain   ${result}      ${output_text}

Vypis promenne
    Vypis

*** Keywords ***
Vypis
    Log Variables