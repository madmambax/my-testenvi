#Ukazka prace s promenyma Variables
*** Settings ***
Library    OperatingSystem

*** Variables ***
${Pozdrav}      Ahoj    #nejpoužívanjěší způsob zápisu proměnné
${Jmeno} =      Daniel  # druhý způsob zápisu


${prikaz1}      help
#Seznamy
@{list1}    prvni   druhy   treti
#Slovníky
&{Dict1}    key=value   foo=bar
*** Test Cases ***

Ukazka prace s promennyma
    ${x} =  Set Variable     10
    ${y} =  Set Variable     20
    @{list2} =  Create List     prvni   druhy   treti   ctvrty
    ${v} =  Evaluate    ${x}*${y}  #bez evaluate to nebude fungovat
    Log To Console    ${\n}${v}     # \n nový řádek
    # Log     Hello
    Run     ${prikaz1}
    Log To Console    ${Pozdrav}, ${Jmeno}
   # Log Variables
    Log To Console    ${list1}  #['prvni', 'druhy', 'treti'] vypíše celý seznam   #nepoužívat s @ - Invalid log
        Log To Console    ${list1}[0]   # vypíše - prvni
    @{l} =  Evaluate    ['1', '2', '3', '4'] 
   
    #Slovníky
    &{Dict2} =      Create Dictionary   auto=10     motorka=999
    Log To Console    ${Dict2}[motorka]