*** Settings ***
Library     OperatingSystem

*** Variables ***
${valid_path} =   C:\\Users\\42077\\Test
${invalid_path} =   C:\\Users\\42077\\:

*** Test Cases ***


Pozitivní test 1
     Remove Directory               ${valid_path}
     ${res} =               run     md ${valid_path}
     Make Log               ${res}
     Log To Console                 \nPath of folder is ${valid_path}
     Directory Should Exist         ${valid_path}


Pozitivní test 2
     ${res} =        run      md/?
     Make Log        ${res}
     Should Contain  ${res}   MKDIR [drive:]path

Negativní test 1
    Create Directory             ${valid_path}
    ${res} =        run          md ${valid_path}
    Make Log        ${res}
    Should Contain  ${res}      A subdirectory or file ${valid_path} already exists.

Negativní test 2
    ${res} =                    run      md ${invalid_path}
    Make Log                    ${res}
    Directory Should Not Exist           ${invalid_path}

*** Keywords ***

Make Log
     [Arguments]    ${text}
     Log            ${text}