*** Settings ***
Library     OperatingSystem

*** Test Cases ***
First positive test
    ${folder} =  run  dir C:\Users
    log  ${folder}
    Should Contain  ${folder}   rosprimova

#Second positive test
#    ${folder} =  run  dir C:\Users\rosprimova
#    log  ${folder}
#    Should Not Contain  ${folder}   Vormicek
#
#    run    cd C:\Users\rosprimova\ && mkdir Vormicek
#
#    ${newFolder} =  run  dir C:\Users\rosprimova
#    log  ${newFolder}
#    Should Contain  ${newFolder}    Vormicek

Second positive test
    ${systemInfo} =  run  systeminfo
    log  ${systemInfo}
    Should Contain  ${systemInfo}   Host Name
    Should Contain  ${systemInfo}   OS Name
    Should Contain  ${systemInfo}   OS Version




