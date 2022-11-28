"""
První robot z první lekce.
Dávat si bach an a to chci vyhodnocovat, aby
pozitivní test byl opravdu pozitivní
a negativní byl opravdu negativní !!!!!

"""

*** Settings ***
Library           OperatingSystem

*** Test Cases ***

Prvni test
    ${result} =      run            ipconfig
    Log             ${result}
    Should Contain  ${result}       Windows IP Configuration

Druhý test negativní  #
    ${result} =      run            cls
    Log             ${result}
    Should Contain  ${result}       Kalimera