#
# Cvičení na použití proměných a výstupu do console
#

*** Settings ***
Documentation     Cvičení: práce s promennými




*** Variables ***
#vytvořte seznam obsahující názvy prohlížečů
@{prohlizece} =     Chrome  Firefox   Explorer




*** Test Cases ***

#Vypište všechny položky seznamu do logu i do console
Výpis do logu a console
    @{list} =   Create List     Chrome   Firefox   Explorer
    Log to console   Prohlizece @{list}


#Vytvořte ověření že položka na pozici 0 v seznamu obsahuje Chrome
Test pro oveření že 0 položka seznamu obsahuje Chrome
    @{list} =   Create List     Chrome   Firefox   Explorer
    Log many    @{list}\[0]

