*** Settings ***
Library     OperatingSystem

*** Variables ***
${file}    noteprd.exe

*** Test Cases ***

Negativní test č1
    ${negativ} =               run          dir c:\\Windowsek
    log                        ${negativ}
    Should Contain             ${negativ}   File Not Found

Negativní test č2
    ${negativ} =                run          dir c:\\Windows
    log                         ${negativ}
    File Should Not Exist       ${negativ}   ${file}