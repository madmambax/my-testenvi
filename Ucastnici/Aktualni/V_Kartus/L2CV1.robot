*** Settings ***
Library     OperatingSystem

*** Variables ***
${result1}  dir C:
${result2}  dir neznamy_adresar
${prvni_test_variable}  Volume Serial Number is 2623-74EF
${druhy_test_variable}  vojtechkartus
${druhy_neg_test variable}  File Not Found


*** Test Cases ***
#pozitivni
prvni poz test
    ${result} =     run             ${result1}
    log             ${result}
    Should Contain  ${result}       ${prvni_test_variable}
#cv2 log
    log             adresar: ${result1} musí obsahovat: ${prvni_test_variable}

druhy poz test
    ${result} =     run             ${result1}
    log             ${result}
    Should Contain  ${result}       ${druhy_test_variable}
#cv3 *** Keywords ***
    KeyLog

#negativni
prvni neg test
    ${result} =     run             ${result2}
    log             ${result}
    Should Contain  ${result}       ${prvni_test_variable}
    log             adresar: ${result} musí obsahovat: ${prvni_test_variable}

druhy neg test
    ${result} =     run             ${result2}
    log             ${result}
    Should Contain  ${result}       ${druhy_neg_test variable}
    log             adresar: ${result2} musí obsahovat: ${druhy_neg_test variable}


*** Keywords ***
KeyLog
    log             adresar: ${result1} musí obsahovat: ${druhy_test_variable}