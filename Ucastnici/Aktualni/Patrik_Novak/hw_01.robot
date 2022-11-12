*** Settings ***
Library           OperatingSystem

*** Variables ***
${TEST_FILE}    test.txt

*** Keywords ***
Get Video Driver Info
    ${value} =  Run    lspci -k | rg -i -A 4 vga
    RETURN      ${value}

*** Test Cases ***

Positive1
    Run                         man bash > ${TEST_FILE}
    File Should Not Be Empty    ${TEST_FILE}
    Run                         rm ${TEST_FILE}
    File Should Not Exist       ${TEST_FILE}

Positive2  # check that correct video driver is used
    ${driver} =     Get Video Driver Info
    Should Contain  ${driver}   Kernel driver in use: i915

Negative1
    ${result} =     Run         make homework
    Log             ${result}
    Should Contain  ${result}   No rule to make target 'homework'

Negative2
    ${result} =     Run         sleep at_night
    Log             ${result}
    Should Contain  ${result}   sleep: invalid time interval ‘at_night’


