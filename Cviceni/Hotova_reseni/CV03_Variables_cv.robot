#
# Cvičení na použití proměných a výstupu do console
#

*** Settings ***
Documentation     Cvičení: práce s promennými




*** Variables ***
#vytvořte seznam obsahující názvy prohlížečů
@{list} =	Chrome  IE  Safari

*** Test Cases ***

#Vypište všechny položky seznamu do logu
Test pro vypsani položek seznamu do logu
    # sem je třeba doplnit příkazy
#    @{list} =	Create List	    a	b	c
    Log To Console  ${list}[0]
    Log Many        @{list}

    Log Many        &{dictionary}

#Vypište druhou položku seznamu na obrazovku (do konzole)
Test pro vypsani jedne polozky ze seznamu


#Vytvořte ověření že položka na pozici 0 v seznamu obsahuje Chrome
Test pro oveření že 0 položka seznamu obsahuje Chrome
    #použijte například  Should Contain







