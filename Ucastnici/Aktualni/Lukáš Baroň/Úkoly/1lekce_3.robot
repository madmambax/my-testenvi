*** Settings ***
Library     OperatingSystem

*** Variables ***
${file}       notepad.exe

*** Test Cases ***
Pozitivní test č1
    ${pozitiv} =         run          dir c:\\windows
    log                  ${pozitiv}
    Should Contain       ${pozitiv}   Volume Serial Number is 2029-349C

Pozitivní test č.2
    ${pozitiv} =         run          dir c:\\windows
    log                  ${pozitiv}
    Should Contain       ${pozitiv}   ${file}