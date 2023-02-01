*** Settings ***
Library    OperatingSystem

*** Variables ***
${Pozdrav}  Ahoj
${Jmeno}    Jirka
${Text}     Toto je zkouška proměnné

${prikaz}   dir

@{list1}    první   druhý   třetí        #seznam

*** Test Cases ***

Ukazka prace s proměnnýma
    ${x} =  Set Variable  10
    ${y} =  Set Variable  20
    ${list2} =  Create List     první   druhá   třetí  #vytvoření seznamu v testcasu
    ${v} =  Evaluate  ${x}*${y}
    Log To Console    ${\n}${x}
    Log  Hello
#    Run  ${prikaz}
#    Log To Console    ${Pozdrav}, ${Jmeno}
#    Log Variables
    Log To Console    ${list1}
    Log To Console    ${list1}[0]  #vypíše konkrétní prvek ze seznamu


Ukázka2
    Log To Console    ${Text}