*** Settings ***
Library     OperatingSystem

*** Variables ***
${file}             notepad.exe
${output_text}      Volume Serial Number is 2029-349C
${output_negative}  File Not Found
${path}             dir c:\\windows
${file_negative}    noteprd.exe
${path_negative}    dir c:\\Windowsek

*** Test Cases ***
Pozitivní test č1
    ${positive} =         run          ${path}
    log                  ${positive}
    Should Contain       ${positive}   ${output_text}

Pozitivní test č.2
    ${positive} =         run          ${path}
    log                  ${positive}
    Should Contain       ${positive}   ${file}

Negativní test č1
    ${negative} =               run          ${path_negative}
    log                        ${negative}
    Should Contain             ${negative}   ${output_negative}

Negativní test č2
    ${negative} =                run          ${path}
    log                         ${negative}
    File Should Not Exist       ${negative}   ${file_negative}
