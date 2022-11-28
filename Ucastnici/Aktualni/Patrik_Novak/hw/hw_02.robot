*** Settings ***
Library           OperatingSystem
Library    String

*** Variables ***
${TEST_FILE}      myuniquedummytestfile.txt
${TEST_FILE_2}    uniquedummytestfile.txt

*** Keywords ***
Get Video Driver Info
    ${value} =  Run    lspci -k | rg -i -A 4 vga
    RETURN      ${value}

File Exists
    [Arguments]        ${file_name}
    ${found_files}     Run             fd ${file_name}
    @{found_files_list}  Split String  ${found_files}  \n
    Log Many           @{found_files_list}
    Should Not Be Empty  @{found_files_list}


*** Test Cases ***

Positive1
    Run                         man bash > ${TEST_FILE}
    File Exists                 ${TEST_FILE}
    File Should Not Be Empty    ${TEST_FILE}
    Run                         man bash > ${TEST_FILE_2}
    File Exists                 ${TEST_FILE_2}
    Run                         rm ${TEST_FILE} ${TEST_FILE_2}
    File Should Not Exist       ${TEST_FILE_2}*

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

Inspect all variables
    Log Variables

