*** Settings ***
Documentation

*** Variables ***
${VAR}  Hello

*** Test Cases ***
prvni
    Log  Ahoj
    Moje prvni
    Moje prvni
    Moje prvni
    Moje prvni
    
KS s parametrem
    Pozdrav  Karle

KS s navratovou hodnotou
    ${vysledek} = Secti  5  8
    Log Variables

*** Keywords ***
Moje prvni
    Log To Console    Test

Pozdrav
    [Arguments]  ${jmeno}
    Log To Console    Ahoj ${jmeno}

Secti
    [Arguments]  ${x}  ${y}
    ${v} =  Evaluate  ${x} + ${y}
    [Return]  ${v}




















#*** Test Cases ***
#Promenne
#    ${var2} =  Set Variable  3.14
#    Log To Console    ${var2}
#    Log To Console    ${VAR}
#
#Seznamy
#    @{zbozi} =  Create List  kolo  auto  motorka  balon
#    Log To Console    ${zbozi}[1]
#    Log Many  @{zbozi}
#
#Slovniky
#    &{ceny} =  Create Dictionary  jablko=55  pomeranc=65  maliny=80
#    Log To Console    ${ceny.maliny}
#    Log To Console    ${ceny}[jablko]
#    Log Many  &{ceny}
#
#Promenne prostredi
#    Log To Console    %{USERNAME}