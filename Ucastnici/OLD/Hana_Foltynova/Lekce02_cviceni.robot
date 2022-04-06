*** Settings ***
Library     OperatingSystem
Library	    Collections


*** Variables ***
#1. způsob zápisu
${URL}     https://www.kosik.cz/

#2. způsob zápisu
${URL2} =  https://www.kosik.cz/




*** Test Cases ***
Ukázka práce s \${URL}
    Log to console  ${\n}Testujeme ${URL}!!


Ukázka práce nastavení proměnné
    ${rohlik} =          Set Variable                                        https://www.rohlik.cz/
    ${kosik} =           Set Variable                                        https://www.kosik.cz/
    Log   ${\n}${rohlik} nebo ${kosik}

KW - Hi!
  Pekne pozdrav


*** Keywords ***

Pekne pozdrav
  [Documentation]     Klíčové slovo bez parametru
  Log    Ahoooooooooooj!!!

