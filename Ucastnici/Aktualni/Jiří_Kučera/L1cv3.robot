*** Settings ***
Library   OperatingSystem

*** Test Cases ***
#Prvni pozitivni test

První
    ${result}         run           dir C:\Programy
    Log               ${result}
    Should Contain    ${result}     Volume Serial Number is DA5E-249C

Druhý
    ${result}         run           pip list
    Log               ${result}
    Should Contain    ${result}     robotframework
