#
# Cvičení na použití proměných a výstupu do console
#

*** Settings ***
Documentation     Cvičení: práce s promennými
Library           Collections



*** Variables ***
@{prohlizec}    Chrome  Edge    Safari



*** Test Cases ***

#Vypište všechny položky seznamu do logu i do console
Výpis do logu a console
    Log to console  ${prohlizec}
    Log Many        @{prohlizec}


#Vytvořte ověření že položka na pozici 0 v seznamu obsahuje Chrome
Test pro oveření že 0 položka seznamu obsahuje Chrome
    Should Contain   ${prohlizec}[0]    Chrome
    #List Should Contain Value   ${prohlizec}    Chrome






