#
# Cvičení na použití proměných a výstupu do console
#

*** Settings ***
Documentation     Cvičení: práce s promennými




*** Variables ***

@{list1}    Chrome  Explorer    Firefox




*** Test Cases ***

#Vypište všechny položky seznamu do logu i do console
Výpis do logu a console
    # sem je třeba doplnit příkazy
    #log Many @{list1}
    Log ${list}[1]
    Log ${list}[2]
    Log ${list}[3]


#Vytvořte ověření že položka na pozici 0 v seznamu obsahuje Chrome
Test pro oveření že 0 položka seznamu obsahuje Chrome
    #použijte například  Should Contain
    Should contain      {list}[1]   Chrome







