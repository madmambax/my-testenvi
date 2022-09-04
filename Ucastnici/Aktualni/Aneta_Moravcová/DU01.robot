*** Settings ***
Library     OperatingSystem


*** Test Cases ***

Prvni test pozitivni
    ${res} =         run     echo "Ahoj, jak se mas?"
    log              ${res}
    Should Be True   ${res}   "Ahoj, jak se mas?"


Druhy test pozitivni
    ${res} =        run     systeminfo
    log             ${res}
    Should Contain  ${res}  OS Name


Prvni test negativni
    ${res} =             run     ssteminfo
    log                  ${res}
    Should Not Contain   ${res}  OS Name

Druhy test negativni
    ${res} =             run     echo "Ahoj!"
    log                  ${res}
    Should Not End With  ${res}  "?"