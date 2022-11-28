*** Settings ***
Library           OperatingSystem

*** Variables ***
${PROGRAM}      help

*** Test Cases ***

Prvni test - pozitivni
    ${result} =      run            ${PROGRAM}
    Log             ${result}
    Log             This is the run program: ${PROGRAM}
    Should Contain  ${result}       For more information on a specific command, type HELP command-name

Druhy test - pozitivni
    ${prog_args}  Set Variable    echo
    ${result} =      RunApp       ${PROGRAM}  ${prog_args}
    Should Contain  ${result}      Displays messages, or turns command-echoing on or off.

Treti test - negativni
    ${prog_args}  Set Variable    ahoj
    ${result} =      RunApp       ${PROGRAM}  ${prog_args}
    Should not Contain  ${result}       For more information on a specific command, type HELP command-name

Ctvrty test - negativni
    ${program}  Set Variable    cau
    ${result} =      RunApp      ${program}  ${null}
    Should Contain  ${result}       is not recognized as an internal or external command


*** Keywords ***

RunApp
    [Arguments]     ${app_name}     ${app_args}
    ${result} =      run    ${app_name} ${app_args}
    Log             Program name: ${app_name}
    Log             Program arguments: ${app_args}
    Log             ${result}
    [Return]    ${result}