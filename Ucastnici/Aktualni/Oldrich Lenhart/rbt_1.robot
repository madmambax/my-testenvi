
*** Settings ***
Library    String
Library    OperatingSystem

*** Variables ***
${x}    10
${text}    assdasdjksahd

*** Test Cases ***

Prvni test
    ${result} =      run            help dir
    Log              ${result}

    Should Contain   ${result}      Display the list of currently