*** Settings ***
Library    OperatingSystem

*** Variables ***
${Pozdrav}   Ahoj
${Jmeno} =   Daniel

${prikaz1}   help
@{list1}     prvni  druhy  treti

*** Test Cases ***

Ukazka prace s promenyma
    ${x} =  Set Variable  10
    ${y} =  Set Variable  20
    @{list2} =  Create List   prvni  druhy  treti  ctvrty
    ${v} =  Evaluate  ${x}*${y}
    Log To Console    ${\n}${v}
    Run    ${prikaz1}
    Log To Console  ${list1}
    Log To Console  ${list1}[0]
    Zpracuj Seznam  @{list1}
