# testovano na macOS

*** Settings ***
Library     OperatingSystem

*** Test Cases ***

Negativni test #1
    ${res} =        run     man 42
    Should Contain  ${res}  No manual entry for
    log             ${res}

Negativni test #2
    ${rc} =        Run And Return Rc  cat /Applications/Neexistujici_aplikace
    Should Not Be Equal As Integers  ${rc}  0
    log             ${rc}



