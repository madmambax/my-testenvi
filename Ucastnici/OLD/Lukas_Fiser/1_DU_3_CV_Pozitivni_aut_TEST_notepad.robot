*** Settings ***
Library     OperatingSystem
Library     OperatingSystem

*** Test Cases ***

Prvni test pozitivní
    ${res} =        run     dir c:\Windows
    log             ${res}
    Should Contain  ${res}  notepad.exe

Druhy test pozitivni
    ${res} =        run     ipconfig
    Log             ${res}
    Should Contain  ${res}  IPv4 Address

