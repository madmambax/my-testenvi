#
# Cvičení na použití proměných a výstupu do console
#

*** Settings ***
Documentation     Cvičení: práce s promennými


*** Variables ***
#vytvořte seznam obsahující názvy prohlížečů
@{prohlizece}   Chrome  Edge    Mozilla


*** Test Cases ***

#Vypište všechny položky seznamu do logu i do console
Výpis do logu a console
    # sem je třeba doplnit příkazy
    Log                 ${prohlizece}
    Log to console      ${prohlizece}

#Vytvořte ověření že položka na pozici 0 v seznamu obsahuje Chrome
Test pro oveření že 0 položka seznamu obsahuje Chrome
    #použijte například  Should Contain
    Should Contain      ${prohlizece}[0]   Chrome






