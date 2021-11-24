*** Settings ***
Library                 OperatingSystem

*** Variables ***
${napoje} =             https://www.rohlik.cz/c300108000-napoje
${pivo} =               https://www.rohlik.cz/c300108052-pivo
${nealkoholicka} =      https://www.rohlik.cz/c300108063-nealkoholicka
${lezaky} =             https://www.rohlik.cz/c300108054-lezaky
${spravna} =            Toto je spravna adresa
${porovnavani} =        Toto by melo spolu souhlasit, ale nesouhlasi!!!



*** Test Cases ***

Prvni test - pozitivni
    #Zkusi proklik na rohlik.cz - odkaz - napoje
    Log                 ${spravna}: ${napoje}
    Should Contain      ${porovnavani}: ${napoje}           https://www.rohlik.cz/c300108000-napoje  

Druhy test - pozitivni
    #Zkusi proklik na rohlik.cz - odkaz - pivo    
    Log                 ${spravna}: ${pivo}
    Should Contain      ${porovnavani}: ${pivo}             https://www.rohlik.cz/c300108052-pivo

Treti test - negativni
    #Zkusi proklik na rohlik.cz - odkaz - nealkoholicka
    Log                 ${spravna}: ${nealkoholicka}
    Should Contain      ${porovnavani}: ${nealkoholicka}    https://www.rohlik.cz/c300108063-nealkooooo
 
Ctvrty test - negativni
    #Zkusi proklik na rohlik.cz - odkaz - lezaky
    Log                 ${spravna}: ${lezaky}
    Should Contain      ${porovnavani}: ${lezaky}           https://www.rohlik.cz/c300108054-lezakyyyyyy


    
    






