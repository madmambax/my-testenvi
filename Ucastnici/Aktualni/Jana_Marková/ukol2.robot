*** Settings ***
Library     OperatingSystem

*** Variables ***
${VypisAdresare}		        dir
${VypisAdresareNeex}		    dir x
${Hodnota1}                     Directory of
${Hodnota2}                     File Not Found
*** Test Cases ***

Test pozitivni upraveno z předchozího cvičení
    Spusť příkaz        ${VypisAdresare}            ${Hodnota1}

Test negativni upraveno z předchozího cvičení
    Spusť příkaz        ${VypisAdresareNeex}        ${Hodnota2}

*** Keywords ***
Spusť příkaz
    [Arguments]                 ${Prikaz}           ${KontrolniHodnota}
    Log To Console              ${\n}Bude spuštěn příkaz: ${Prikaz}
    Log To Console              Kontrola - výstup obsahuje text: ${KontrolniHodnota}
    ${output} =                 run                 ${Prikaz}
    Should Contain              ${output}           ${KontrolniHodnota}
    Log                         Výstup: ${output}


