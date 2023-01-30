*** Settings ***
Library    String
Library    OperatingSystem

*** Test Cases ***

Prvni test - pozitvni
    ${result} =      run            dir
    Log              ${result}

    Should Contain   ${result}      Cviceni

Druhy test - pozitivni
    ${result} =      run            help DATE
    Log              ${result}

    Should Contain   ${result}      Displays or sets the date.

Prvni test - negativni
    ${result} =      run            dir C:\Wonderland
    Log              ${result}

    Should Contain   ${result}       File Not Found

Druhy test - negativni
    ${result} =      run            helpme
    Log              ${result}

    Should Contain   ${result}      'helpme' is not recognized as an internal or external command