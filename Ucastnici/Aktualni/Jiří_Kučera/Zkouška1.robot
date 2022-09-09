
*** Settings ***
Documentation     Cvičení: práce s promennými




*** Variables ***
#vytvořte seznam obsahující názvy prohlížečů
${chrome}       Chrome
${brave}        Brave
${explorer}     Explorer

*** Test Cases ***

#Vypište všechny položky seznamu do logu
Test pro vypsani všech položek seznamu do logu
    # sem je třeba doplnit příkazy
    @{seznam} =     Create List        chrome   brave   explorer
    Log To Console    ${seznam}

#Vypište druhou položku seznamu na obrazovku (do konzole)
Test pro vypsani jedne polozky ze seznamu
    @{seznam} =     Create List        chrome   brave    explorer
    Log Many          @{seznam}
    Log               ${seznam}
    Log To Console    ${seznam}[1]

#Vytvořte ověření že položka na pozici 0 v seznamu obsahuje Chrome
Test pro oveření že 0 položka seznamu obsahuje Chrome
    #použijte například  Should Contain
    @{seznam} =     Create List        chrome   brave   explorer
    Log To Console    ${seznam}
    Should Contain      ${seznam}     chrome