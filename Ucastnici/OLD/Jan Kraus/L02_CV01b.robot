*** Settings ***
Library    OperatingSystem

*** Test Cases ***
#Negativní testy
Zadání příkazu ping s překlepem
    ${result} =       Run           pingg kitner.cz
    Log To Console    ${result}
    Log               ${result}
    Should Contain    ${result}     command not found

Spuštění neexistujícího skriptu
#    ${result} =       Run           robot ../Radek\ Kitner/pokuss.robot
#    Log To Console    ${result}
#    Log               ${result}
#    Should Contain    ${result}     File or directory to execute does not exist.
     Spustit skript    'Radek Kitner'     pokuss.robot

*** Keywords ***
Spustit skript
    [Documentation]    Spustí skript konkrétního člověka
    [Arguments]        ${person}      ${filename}
    ${result}=         Run    python -m robot ../${person}/${filename}
    Log                ${result}
    Should Contain     ${result}        File or directory to execute does not exist.