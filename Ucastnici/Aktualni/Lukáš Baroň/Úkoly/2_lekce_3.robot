*** Settings ***
Library     OperatingSystem

*** Variables ***
${file}             notepad.exe
${output_positive}  Volume Serial Number is 2029-349C
${output_negative}  File Not Found
${path}             dir c:\\windows
${file_negative}    noteprd.exe
${path_negative}    dir c:\\Windowsek

*** Test Cases ***
Pozitivní test č1
    TEST   ${path}  ${output_positive}

Pozitivní test č.2
    TEST  ${path}  ${file}

Negativní test č1
    TEST  ${path_negative}  ${output_negative}

Negativní test č2
    TEST  ${path}  ${file_negative}

*** Keywords ***
TEST
    [Arguments]          ${path_arg}  ${file_arg}
    ${test}              run          ${path_arg}
    log                  ${test}
    Should Contain       ${test}   ${file_arg}

