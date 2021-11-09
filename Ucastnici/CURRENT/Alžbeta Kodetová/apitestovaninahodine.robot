*** Settings ***
Library  RequestsLibrary


*** Variables ***
${url}    http://testovani.kitner.cz/
${app}    regkurz/formsave.php

*** Test Cases ***


Prvni API test - registrace na kurz
    # vytoření JSON zprávy
    ${json}=  catenate  {"targetid":"","kurz":"2","name":"Havel","surname":"Tester","email":"jan.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}

    # vytoření hlavičky (header) zprávy
    &{header}=   Create Dictionary   Content-Type=application/json

    # vytvoření spojení (session)
    CreateSession       apilogin            ${url}

    # odeslání zprávy a uložení odpovědi do ${resp}
    ${resp} =  Post on Session  apilogin  ${app}  data=${json}  headers=${header}   expected_status=Anything

    # vyhodnocení
    Status Should Be  200