*** Settings ***
Library     OperatingSystem

*** Variables ***
${RESULT}


*** Keywords ***
Run OS Command
    [Arguments]     ${command}     ${expected}
    ${RESULT} =     run     ${command}
    Log             Command result is: ${RESULT}
    Should Contain  ${RESULT}  ${expected}


*** Test Cases ***

Positive01
    Run OS Command     ipconfig    Windows IP Configuration

Positive02
    Run OS Command     git    These are common Git commands used in various situations:

Negative01
    Run OS Command     help foo    This command is not supported by the help utility.

Negative02
    Run OS Command     hg    'hg' is not recognized as an internal or external command