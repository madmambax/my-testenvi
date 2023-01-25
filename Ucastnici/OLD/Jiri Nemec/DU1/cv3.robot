# testovano na macOS

*** Settings ***
Library     OperatingSystem

*** Test Cases ***

Pozitivni test #1
    ${res} =        run     robot --help
    Should Contain  ${res}  A generic automation framework
#    log             ${res}

Pozitivni test #2
    ${rc} =        Run And Return Rc  true
    Should Be Equal As Integers  ${rc}  0



