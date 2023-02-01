##CV23_Variables.robot, CV28_Keywords_cv.robot

*** Settings ***
Library    OperatingSystem
#*** Settings ***
#Library    OperatingSystem
#
#*** Variables ***
#${Pozdrav}  Ahoj
#${Jmeno}    Jirka
#${Text}     Toto je zkouška proměnné
#
#${prikaz}   dir
#
#@{list1}    první   druhý   třetí        #seznam
#
#*** Test Cases ***
#
#Ukazka prace s proměnnýma
#    ${x} =  Set Variable  10
#    ${y} =  Set Variable  20
#    ${list2} =  Create List     první   druhá   třetí  #vytvoření seznamu v testcasu
#    ${v} =  Evaluate  ${x}*${y}
#    Log To Console    ${\n}${x}
#    Log  Hello
##    Run  ${prikaz}
##    Log To Console    ${Pozdrav}, ${Jmeno}
##    Log Variables
#    Log To Console    ${list1}  # výpis položek seznamu do logu
#    Log To Console    ${list1}[0]  #vypíše konkrétní prvek ze seznamu
#
#
#Ukázka2
#    Log To Console    ${Text}
#
#---------------------------------
#
#*** Variables ***
#
##vytvořte seznam obsahující názvy prohlížečů
#
#@{prohlizece}    chrome  firefox  safari  edge
#
#
#*** Test Cases ***
#
##Vypište všechny položky seznamu do logu
#Test pro vypsani všech položek seznamu do logu
#    # sem je třeba doplnit příkazy
#    Log To Console    ${prohlizece}
#
#
##Vypište druhou položku seznamu na obrazovku (do konzole)
#Test pro vypsani jedne polozky ze seznamu
#    Log To Console    ${prohlizece}[1]
#
#
##Vytvořte ověření že položka na pozici 0 v seznamu obsahuje Chrome
#Test pro oveření že 0 položka seznamu obsahuje Chrome
#    #použijte například  Should Contain
#    Should Contain  ${prohlizece}[0]  chrome
#
#-----------------------------------
#
##vytvoření slovníku v sekci Variables
#&{dictionary}   key=value  foo=bar
#
#Ukazka prace s promenyma
#    &{Dict2} =	    Create Dictionary	auto=10	 motorka=999
#    Log To Console  ${Dict2}[motorka]
#    Should Contain    ${JSON}[motorka]    999
    

#---------------

#*** Test Cases ***
#
#Ukazka prace s KS
#    Log   Zaciname
#    Moje prvni KS   Honzo
#    ${vysledek}=  Secti  2  5
#    Log To Console    ${vysledek}
#
#
#
#*** Keywords ***
#
#Moje prvni KS
#    [Arguments]       ${Jmeno}
#    Log To Console    Dobrý den, ${Jmeno}
#
#
#Secti
#    [Arguments]         ${A}  ${B}
#    ${v} =              Evaluate  ${A}+${B}
#    [Return]            ${v}


#--------------


*** Settings ***
Documentation     Cvičení na klíčová slova
...               Připravte klíčové slovo pro kalkulačku


*** Test Cases ***

Sčítání
        ${result}=          Calculate  20  15  +      # pozor je nutné pro oddělení parametrů používat min 2 mezery
        Should Be Equal     ${result}  ${35}

Odečítání


Násobení


Dělení



*** Keywords ***

Calculate
    [Arguments]    #nutné doplnit
    ${res}=        Evaluate    #nutné doplnit
    [return]       ${res}