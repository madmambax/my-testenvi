*** Settings ***
Library     OperatingSystem


*** Variables ***
@{NazevSouboru}     text.txt

*** Keywords ***
Moje první klíčové slovo
        Create File     @{NazevSouboru}        Ahoj, toto je pokus o vytvoření souboru
        ${output} =     Get File                @{NazevSouboru}
        Log To Console  ${OUTPUT}               @{NazevSouboru}

Práce s txt
        ${output} =     Get file    @{NazevSouboru}
        Log             ${output}


*** Test Cases ***


Prvni test pozitivní
    ${res} =        run     help
    log             ${res}
    Should Contain  ${res}  For more information on a specific command, type HELP command-name

Druhy test negativni
    ${res} =        run     help ahoj
    log             ${res}
    Should Contain  ${res}  This command is not supported by the help utility.

Třetí test pozitivní
    ${output} =      Run        Dir
    Log             ${output}
    Should Contain  ${output}   report

Čtvrtý test pozitivní
    Create File     text.txt        Ahoj, toto je pokus o vytvoření souboru
    ${output} =     Get File        text.txt
    log             ${output}
    Should Contain  ${output}       Ahoj

Pátý text negativní
    ${output} =     Get File  @{NazevSouboru}
    Log             ${output}
    Should not Contain  ${output}   čau

Klíčové slovo
    Moje První Klíčové Slovo

Ověření obsahu
    Práce S Txt
    Should Contain  ${output}   Ahoj































