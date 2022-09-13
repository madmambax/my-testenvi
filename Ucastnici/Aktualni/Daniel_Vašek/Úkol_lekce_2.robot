# Cvičení na použití proměných a výstupu do console
*** Settings ***
Library     OperatingSystem


*** Variables ***
${GREET}   Chrome  Opera  Internet  ME  Safari    #vytvořte seznam obsahující názvy prohlížečů


*** Test Cases ***

1. Vypsání všech položek do logu                    #Vypište všechny položky seznamu do logu
    ${GREET} =             Set variable             ${GREET}
    log to console                                  ${GREET}


2. Test pro vypsani jedne polozky ze seznamu        #Vypište druhou položku seznamu na obrazovku (do konzole)
    ${Seznam} =  Create list            Chrome  Opera  Internet  ME  Safari
        log many                        ${Seznam}
        log                             ${Seznam}
        log to console                  ${Seznam}[1]


3. Test pro oveření že 0 položka seznamu obsahuje Chrome  #Vytvořte ověření že položka na pozici 0 v seznamu obsahuje Chrome

    @{seznam} =  Create list   Chrome   Opera   Internet    ME    Safari
        log many                        @{seznam}
        log                             ${seznam}
        Should Contain                  ${seznam}[0]    Chrome   #Pokud dochází k porovnání je potřeba nastavit co s čím porovnat







