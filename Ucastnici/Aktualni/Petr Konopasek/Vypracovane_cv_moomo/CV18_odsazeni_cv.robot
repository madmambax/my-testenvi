# Opravte 5 chyb v odsazení u následujících automatikých testů
# Opraveno moomo
*** Settings ***
Library     OperatingSystem


*** Test Cases ***

Prvni test pozitivní
    ${res} =        run     help dir
    log             ${res}
    Should Contain  ${res}  Dir



Druhy test negativni
    ${res} =        run     help ahoj
    log             ${res}
    Should Contain  ${res}  This command is not supported by the help utility.