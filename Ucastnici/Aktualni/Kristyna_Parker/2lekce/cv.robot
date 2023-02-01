#Ukazka prace s promenyma Variables
*** Settings ***
Library    OperatingSystem

*** Variables ***
${Pozdrav}      Ahojky    #nejpoužívanjěší způsob zápisu proměnné
${Dotaz}        Jak se máš?
*** Test Cases ***

Ukazka prace s promennyma
     Log To Console    ${Pozdrav}, ${Dotaz}
     ${x} =  Set Variable     24
     Log To Console    ${\n}${x}

     ${a} =  Set Variable     24
     ${b} =  Set Variable     4
     ${c} =  Evaluate    ${a}*${b}
