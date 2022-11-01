*** Settings ***
Library  RequestsLibrary
Library  RequestsLibrary

*** Variables ***
${url}      http://testovani.kitner.cz/
${app}      regkurz/formsave.php
${urlapp}   ${url}${app}

*** Test Cases ***
Registrace na kurz
    ${json}=  Catenate  { "targetid":"","kurz":"1","name":"Honza","surname":"Tester","email":"jan.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
    ${response}=  POST  ${urlapp}  data=${json}
    Status Should Be    200
    Should Be Equal As Strings   200   ${response.json()}[response]

Registrace na kurz chybny format
    ${json}=  Catenate  { "targetid:"","kurz":"1","name":"Honza",