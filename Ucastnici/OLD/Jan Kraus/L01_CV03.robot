*** Settings ***
Library     OperatingSystem

*** Test Cases ***
#Pozitivní testy
Ping na kitner.cz odesílá i přijímá pakety
    ${result} =         Run         ping -n 4 kitner.cz
    Log                 ${result}
    Log To Console      ${result}
    Should Contain      ${result}   Sent = 4, Received = 4

Help mkdir obsahuje první řádek
    ${result} =         Run         help mkdir
    Log                 ${result}
    Log To Console      ${result}
    Should Contain      ${result}   Creates a directory or subdirectory.