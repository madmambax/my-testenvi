#
# Cvičení na použití proměných a výstupu do console
#

*** Settings ***
Documentation     Cvičení: práce s promennými




*** Variables ***
#vytvořte seznam obsahující názvy prohlížečů
@{PROHLIZECE}   Chrome  Firefox  Brave   Edge

*** Test Cases ***

#Vypište všechny položky seznamu do logu
Test pro vypsani všech položek seznamu do logu
    @{seznam} =     Create List    Chrome    Firefox   Edge
    Log Many        @{seznam}
    Log To Console    ${seznam}[1]
    Should Contain    ${seznam}[0]  Chrome
    # sem je třeba doplnit příkazy


#Vypište druhou položku seznamu na obrazovku (do konzole)
Test pro vypsani jedne polozky ze seznamu
    Log To Console  ${PROHLIZECE}[1]
    Log To Console  %{USERNAME}

#Vytvořte ověření že položka na pozici 0 v seznamu obsahuje Chrome
Test pro oveření že 0 položka seznamu obsahuje Chrome
    Should Contain  ${PROHLIZECE}[0]    Chrome
    #použijte například  Should Contain
    Log To Console    message







