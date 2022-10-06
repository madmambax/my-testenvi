*** Settings ***
Library     OperatingSystem


*** Test Cases ***

Prvni test negativní
    ${res} =        run     dir neznamy_adresar
    log             ${res}  # Znakem dolaru se definuje proměnná.
    Should Contain  ${res}  File Not Found

Druhy test negativní
    ${res} =        run     help tes
    Log             ${res}
    Should Contain  ${res}  Try "tes /?".

# Znak pro komentář