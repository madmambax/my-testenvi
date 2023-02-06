
*** Settings ***
Library    String
Library    OperatingSystem

*** Variables ***
${command1} =     help dir
#@{ver} =          brew --version   python --version   robot --version
${ver} =          python --version

*** Keywords ***
Vypis prikaz
    [Arguments]                 ${prikaz}
    [Documentation]             Vypise do konzole, název spuštěného příkazu.
    Log To Console              ${\n} Spuštěný příkaz je: ${prikaz}

    
*** Test Cases ***

Pozitivní test 1
    ${result} =      Run    ${command1}
    Log                     ${result}
    Should Contain          ${result}      Display the list of currently

Pozitivní test 2
    ${result} =    Run  ${ver}
    Log                 ${result}
    Vypis prikaz        ${ver}
    Log                 Spuštění programu ${ver} zobrazí verzi pythonu.
    Should Contain      ${result}      Python 2.7.16

Negativní test 1
    ${result} =      Run  help ahoj
    Log   ${result}
    Should Contain   ${result}  no help topics match `ahoj'

Negativní test 2
    ${result} =      Run  open /Users/oldrichlenhart/Video/Breeze_170815192130_001.JPG
    Log   ${result}
    Should Contain   ${result}  does not exist



