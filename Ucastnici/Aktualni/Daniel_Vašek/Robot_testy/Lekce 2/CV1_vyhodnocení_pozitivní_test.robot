*** Settings ***
Library     OperatingSystem

*** Test Cases ***

Prvni test pozitivní
    ${res} =        run     help dir
    log console     ${res}
    Should Contain  ${res}  Specifies drive, directory, and/or files to list.


Druhy test pozitivní
    ${res} =        run     dir
    log console     ${res}
    Should Contain  ${res}  Volume in drive C is Windows