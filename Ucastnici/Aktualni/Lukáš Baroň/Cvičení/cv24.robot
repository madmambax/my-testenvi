#
# Cvičení na použití proměných a výstupu do console
#

*** Settings ***
Documentation     Cvičení: práce s promennými




*** Variables ***

@{list}  Chrome  Opera  IE

*** Test Cases ***

#Vypište všechny položky seznamu do logu
Test pro vypsani všech položek seznamu do logu
    Log     ${list}


#Vypište druhou položku seznamu na obrazovku (do konzole)
Test pro vypsani jedne polozky ze seznamu
    Log     ${list}[1]


#Vytvořte ověření že položka na pozici 0 v seznamu obsahuje Chrome
Test pro oveření že 0 položka seznamu obsahuje Chrome
    Should Contain    ${list}[0]    Chrome
