#
# Cvičení na použití proměných a výstupu do console
#

*** Settings ***
Documentation     Cvičení: práce s promennými
Library	Collections

*** Variables ***
#vytvořte seznam obsahující názvy prohlížečů
@{list} =      Google_Chrome    Safari    Edge

*** Test Cases ***

#Vypište všechny položky seznamu do logu i do console
Výpis do logu a console
    # sem je třeba doplnit příkazy
    #@{list} =   Create List      Google_Chrome    Safari    Edge
    Log to console  ${list}
    Log Many    @{list}

#Vytvořte ověření že položka na pozici 0 v seznamu obsahuje Chrome
Test pro oveření, že 0 položka seznamu obsahuje Chrome
    #použijte například  Should Contain
    Log     ${list}[0] 'Google_Chrome'
    Should Contain      ${list}[0]       Google_Chrome

Test pro oveření položky v seznamu
    Should Contain Any  ${list}     Edge
    List Should Contain Value   ${list}  Safari