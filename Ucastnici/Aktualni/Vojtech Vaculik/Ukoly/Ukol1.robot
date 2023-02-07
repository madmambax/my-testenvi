*** Settings ***
Library     OperatingSystem
Library     String


*** Test Cases ***
# První dva pozitivní test
Run dir command
    ${result} =  Run  dir
    Log  ${result}
    Should Contain  ${result}    log  report.html

Run whoami command
    ${result} =  Run  whoami
    Log  ${result}
    Should Contain  ${result}    vojta

# Nehativní test

Run hostname command
    ${result} =  Run  hostname
    Log  ${result}
    Should Contain  ${result}    Jon Doe


Run ipconfig command
    ${result} =  Run  ipconfig
    Log  ${result}
    Should Contain  ${result}    0.0.0.0

