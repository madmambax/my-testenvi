*** Settings ***
Library     OperatingSystem
Library    OperatingSystem

*** Variables ***
${manual} =         mkdir

*** Test Cases ***
#Pozitivní testy
Ping odesílá i přijímá pakety
    Ping    5   kitner.cz

Help ${manual} obsahuje první řádek
    ${result} =         Run         man ${manual}
    Log                 ${result}
    Should Contain      ${result}   Creates a directory or subdirectory.


*** Keywords ***
Ping
    [Arguments]       ${packets}    ${website}
    ${result}=        Run     ping -n ${packets} ${website}
    Log               ${result}
    Should Contain    ${result}     Sent = ${packets}, Received = ${packets}