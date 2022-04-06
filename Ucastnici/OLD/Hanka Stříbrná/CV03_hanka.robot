#
# Cvičení na použití proměných a výstupu do console
#

*** Settings ***
Documentation     Cvičení: práce s promennými




*** Variables ***
#vytvořte seznam obsahující názvy prohlížečů
@{list1}    chrome      firefox      edge


*** Test Cases ***
první test
    Log          ${list1}

druhý test
    Log to console  ${list1}

třetí test

    Log  ${list1}
    Should Contain  ${list1}[0]    chrome


#Vytvořte ověření že položka na pozici 0 v seznamu obsahuje Chrome
#Test pro oveření že 0 položka seznamu obsahuje Chrome
    #použijte například  Should Contain







