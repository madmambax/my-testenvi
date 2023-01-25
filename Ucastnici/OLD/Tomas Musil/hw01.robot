*** Settings ***
Library     OperatingSystem


*** Test Cases ***

Positive01
    ${res} =        run     ipconfig
    Should Contain  ${res}  Windows IP Configuration

Positive02
    ${res} =        run     git
    Should Contain  ${res}  These are common Git commands used in various situations:

Negative01
    ${res} =        run     help foo
    Should Contain  ${res}  This command is not supported by the help utility.

Negative02
    ${res} =        run     hg
    Should Contain  ${res}  'hg' is not recognized as an internal or external command