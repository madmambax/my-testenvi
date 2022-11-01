# Cvičení na použití proměných a výstupu do console)
*** Settings ***
Library     OperatingSystem


*** Variables ***
@{GREET}   Chrome  Opera  Internet  ME  Safari    #vytvořte seznam obsahující názvy prohlížečů


*** Test Cases ***

1. Vypsání všech položek do logu                    #Vypište všechny položky seznamu do logu
    log to console                                  ${GREET}


2. Test pro vypsani jedne polozky ze seznamu        #Vypište druhou položku seznamu na obrazovku (do konzole)
        log many                        @{GREET}
        log                             ${GREET}
        log to console                  ${GREET}[1]


3. Test pro oveření že 0 položka seznamu obsahuje Chrome  #Vytvořte ověření že položka na pozici 0 v seznamu obsahuje Chrome

        log many                        @{GREET}
        log                             ${GREET}
        Should Contain                  ${GREET}[0]    Chrome   #Pokud dochází k porovnání je potřeba nastavit co s čím porovnat







