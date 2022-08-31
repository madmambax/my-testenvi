#Opravte 5 chyb v odsazení u následujících automatikých testů

*** Settings ***
Library     OperatingSystem


*** Test Cases ***

Prvni test  pozitivní
${res} =        run     help dir
log             ${res}
Should Contain  ${res}  DIR


Druhy test negativni
    ${res}          = run     help ahoj
    log             ${res}
    Should Contain  ${res}  This command is not supported by the help utility.