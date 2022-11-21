*** Settings ***
Library           OperatingSystem

*** Variables ***
${NOT_SUPPORTED_COMMAND}            This command is not supported by the help utility.
${INCORRECT_SYNTAX}                 The syntax of the command is incorrect.
${NO_FILE}                          File not found

*** Test Cases ***

Negativni test 1
    ${result} =      Run            help neznamy
    Log             ${result}
    Should Contain  ${result}       ${NOT_SUPPORTED_COMMAND}
    Log             ${NOT_SUPPORTED_COMMAND}
    Neplatny prikaz  help neznamy

Negativni test 2
    ${result} =      Run            rmdir
    Log             ${result}
    Should Contain  ${result}       ${INCORRECT_SYNTAX}
    Log             ${INCORRECT_SYNTAX}
    Neplatny prikaz  rmdir

Negativni test 3
    ${result} =      Run            xcopy neexistujici
    Log             ${result}
    Should Contain  ${result}       ${NO_FILE}
    Log             ${NO_FILE}
    Neplatny prikaz  xcopy neexistujici

Negativni test 4
    ${result} =      Run            help asd
    Log             ${result}
    Should Contain  ${result}       ${NOT_SUPPORTED_COMMAND}
    Log             ${NOT_SUPPORTED_COMMAND}
    Neplatny prikaz  help asd

*** Keywords ***
Neplatny prikaz
    [Arguments]     ${prikaz}
    [Documentation]  Vypise do konzole, ze zadany prikaz neni platny.
    Log To Console  ${\n}Prikaz ${prikaz} neni platny!!!
    