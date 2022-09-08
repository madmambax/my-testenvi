*** Settings ***
Library     OperatingSystem

*** Test Cases ***
First negative test
    ${folder} =  run  dir C:\Users
    log  ${folder}
    Should Contain  ${folder}   Vormicek

Second negative test
    ${systemInfo} =  run  systeminfo
    log  ${systemInfo}
    Should Not Contain  ${systemInfo}   Host Name
