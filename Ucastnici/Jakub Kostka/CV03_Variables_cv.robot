#
# Cvičení na použití proměných a výstupu do console
#

*** Settings ***




*** Variables ***
#vytvořte seznam obsahující názvy prohlížečů
@{list1}    Chrome  Mozilla  Edge

*** Test Cases ***

#Vypište všechny položky seznamu do logu i do console
Výpis do logu a console

    # sem je třeba doplnit příkazy
    Log  ${list1}[0]
    Log  ${list1}[1]
    Log  ${list1}[2]
#Vytvořte ověření že položka na pozici 0 v seznamu obsahuje Chrome
Test pro oveření že 0 položka seznamu obsahuje Chrome
    #použijte například  Should Contain
    Should Contain  ${list1}[0]  Chrome





