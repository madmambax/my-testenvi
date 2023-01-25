#
# Cvičení na použití proměných a výstupu do console
#
*** Settings ***
Documentation     Cvičení: práce s promennými

*** Variables ***
@{seznam} =     Create List    Chrome    Firefox   Edge

#vytvořte seznam obsahující názvy prohlížečů

*** Test Cases ***

#Vypište všechny položky seznamu do logu
Test pro vypsani všech položek seznamu do logu
    Log Many        @{seznam}
    # sem je třeba doplnit příkazy


#Vypište druhou položku seznamu na obrazovku (do konzole)
Test pro vypsani jedne polozky ze seznamu
    Log To Console    ${seznam}[1]

#Vytvořte ověření že položka na pozici 0 v seznamu obsahuje Chrome
Test pro oveření že 0 položka seznamu obsahuje Chrome
    Should Contain    ${seznam}[0]  Chrome
    #použijte například  Should Contain







