*** Settings ***
Library   OperatingSystem

*** Test Cases ***
#Pozitivni testy

První
    ${result} =        run          dir C:\
    Log               ${result}
    Should Contain    ${result}     Volume Serial Number is DA5E-249C

Druhý
    ${result} =        run          pip list
    Log               ${result}
    Should Contain    ${result}     robotframework
