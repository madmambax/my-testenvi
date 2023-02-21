*** Settings ***
Library    String
Library    OperatingSystem

*** Variables ***
${result}
${output}           Displays or sets the date.
${program1}         dir
${program2}         help


*** Test Cases ***

Prvni test - pozitvni
    ${result} =      run            ${program1}
    Log                             ${result}
    Vypis                           ${program1}
    Log                             Spuštění programu ${program1} zobrazí složky v adresáři jak_automatizovat_testy
    Should Contain                  ${result}      Cviceni


Druhy test - pozitivni
    ${result} =      run            ${program2} DATE
    Log                             ${result}
    Vypis                           ${program2} DATE
    Log                             Funkce help DATE: ${output}
    Should Contain                  ${result}      ${output}

Prvni test - negativni
    ${result} =      run            ${program1} C:\Wonderland
    Log                             ${result}
    Vypis                           ${program1} C:\Wonderland
    Should Contain                  ${result}       File Not Found


Druhy test - negativni
    ${result} =      run            ${program2}me
    Log                             ${result}
    Vypis                           ${program2}me
    Should Contain                  ${result}      '${program2}me' is not recognized as an internal or external command



*** Keywords ***
Vypis
    [Arguments]                 ${program_name}
    [Documentation]             Vypise do konzole, název spuštěného příkazu.
    Log To Console              ${\n} Spuštěný příkaz je: ${program_name}
