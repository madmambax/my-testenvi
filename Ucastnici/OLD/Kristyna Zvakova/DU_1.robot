*** Settings ***
Library    OperatingSystem

*** Test Cases ***

Prvni test pozitivni
    ${res}=         run     echo "123"
    log             ${res}
    Should contain  ${res}  "123"

Druhy test pozitivni
    file should not exist   C:\cesta

Prvni test negativni
    ${res}=         run     help
    log             ${res}
    Should contain  ${res}    Vesele Velikonoce.

Druhy test negativni
    file should exist   C:\cesta