*** Settings ***
Library     OperatingSystem

*** Variables ***

${Info1}    For more information on a specific command, type HELP command-name
${Info2}    Display the thousand separator in file sizes.
${Info3}    This command is not supported by the help utility.
${Info4}    is not recognized as an internal or external command,

*** Test Cases ***

Prvni test pozitivní
    ${res} =        run     help
    log             ${res}
    Should Contain  ${res}  ${Info1}

Druhý test pozitivní
    ${res} =        run     help dir
    log             ${res}
    Should Contain  ${res}  ${Info2}

Třetí test negativni
    ${res} =        run     help ahoj
    log             ${res}
    Should Contain  ${res}  ${Info3}

Čtvrtý test negativní
    ${res} =        run     help123
    log             ${res}
    Should Contain  ${res}  ${Info4}

Test klíče
    ${vysledek}     Vypocet  15   9  -
    Log To Console  ${vysledek}
*** Keywords ***

Vypocet
   [Arguments]     ${number1}   ${number2}  ${znamenko}
   ${vysledek}     Evaluate        ${number1}${znamenko}${number2}
   [return]        ${vysledek}