# Cvičení na použití proměných a výstupu do console
*** Settings ***
Library     OperatingSystem

*** Variables ***
${seznam}       Chrome      IE      Safari      Opera   Mozila      ME

*** Test Cases ***
Test pro vypsani všech položek seznamu do logu
#Vypište všechny položky seznamu do logu

    @{seznam} =      Create List                    Chrome  IE  Safari  Opera  Mozila  ME
    Log Many                  @{seznam}
    Log                       ${seznam}
    Log to Console            ${seznam}[0]
    Log to Console            ${seznam}[1]
    Log to Console            ${seznam}[2]
    Log to Console            ${seznam}[3]
    Log to Console            ${seznam}[4]
    Log to Console            ${seznam}[5]

*** Test Cases ***
Test pro vypsani jedne polozky ze seznamu
#Vypište druhou položku seznamu na obrazovku (do konzole)

    @{seznam} =      Create List                    Chrome  IE  Safari  Opera  Mozila  ME
    Log Many                  @{seznam}
    Log                       ${seznam}
    Log to Console            ${seznam}[1]


*** Test Cases ***
Test pro oveření že 0 položka seznamu obsahuje Chrome
#Vytvořte ověření že položka na pozici 0 v seznamu obsahuje Chrome
#použijte například  Should Contain

    &{slov} =            Create Dictionary           Chrome  IE  Safari  Opera  Mozila  ME
    Log Many                  &{slov}
    Log                       ${slov}
    Should Contain            ${seznam}[0]          Chrome







