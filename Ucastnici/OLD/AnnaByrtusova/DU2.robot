*** Settings ***
Library           OperatingSystem


*** Variables ***
${OUTPUT_TEXT1}=        For more information on a specific command, type HELP command-name
${OUTPUT_TEXT2}=        Displays a list of files and subdirectories in a directory.
${OUTPUT_TEXT3}=        'test' is not recognized as an internal or external command
#globální proměnné zapisujeme velkými písmeny

*** Keywords ***

Vypis_poz
    Log To Console    ${\n}pozitivní test case

*** Test Cases ***

Pozitivni test1
    ${result} =      run            help
    Log             ${result}
    Should Contain  ${result}       ${OUTPUT_TEXT1}
    Log             ${OUTPUT_TEXT1}
    Vypis_poz

Negativni test1
    ${res} =        run             help ahoj
    Log             ${res}
    Should Contain  ${res}          ${OUTPUT_TEXT1}
    Log             ${OUTPUT_TEXT1}

Pozitivni test2

    ${result} =      run            help dir
    Log             ${result}
    Should Contain  ${result}       ${OUTPUT_TEXT2}
    Log             ${OUTPUT_TEXT2}
    Vypis_poz

Negativni test2
    ${nesmyslny_parametr}=      Set variable    help dir nesmysl
    ${res} =                    run             ${nesmyslny_parametr}
    log                         ${res}
    Should Contain              ${res}  ${OUTPUT_TEXT2}
    Log                         ${OUTPUT_TEXT2}

Pozitivní test3
    ${res} =        run     test
    Log             ${res}
    Should Contain  ${res}  ${OUTPUT_TEXT3}
    Log             ${OUTPUT_TEXT3}
    Vypis_poz

Negativní test3

    ${res} =        run     testování
    Log             ${res}
    Should Contain  ${res}  ${OUTPUT_TEXT3}
    Log             ${OUTPUT_TEXT3}






