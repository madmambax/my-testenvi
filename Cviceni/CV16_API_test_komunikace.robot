"""

Tento příklad potřebuje robotframework-requests balíček
instalace:
pip install robotframework-requests

"""


*** Settings ***
Library	 RequestsLibrary
Library	 Collections
Library  String


*** Variables ***
${url}		    http://testovani.kitner.cz/
${app}          /regkurz/formsave.php

#${json}      {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}

*** Test Cases ***

registrace ok
    API Comunicaication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  200

registrace chyba
    API Comunicaication   {"targetid":"","kurz":"","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500

registrace chybny telefon (moc dlouhy)
    API Comunicaication   {"targetid":"","kurz":"1","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"60812312300000000000000","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   400

chybny format JSON (bez kurzu)
    API Comunicaication   {"targetid":"","kurz":,"name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  400

Háčky a carky - problém s českými znaky v Request Library
###    ${str} =      Set Variable     {"targetid":"","kurz":"3","name":"DalsiJanž","surname":"Novak","email":"jan.novak@abc.cz","phone":"777123123","person":"fyz","address":"Brno","ico":"1","count":"1","comment":"nic","souhlas":true}
###    ${JSON} =	Encode String To Bytes	${str}	UTF-8
###    API comunicaication          ${JSON}    200
    API Comunicaication  {"targetid":"","kurz":"3","name":"Janž","surname":"Novak","email":"jan.novak@abc.cz","phone":"777123123","person":"fyz","address":"Brno","ico":"1","count":"1","comment":"nic","souhlas":true}  200







*** Keywords ***

API Comunicaication
    [Arguments]       ${json}     ${error_resp}

   # zapis jako DATA
   ${json_string}=    catenate    ${json}

  #vytoření hlavičky (header) zprávy
  &{header}=          Create Dictionary   Content-Type=application/json

  #vytvoření spojení (session)
  CreateSession       apilogin            ${url}

  # odeslání zprávy a uložení odpovědi do ${resp}
  ${resp} =    Post on Session    apilogin  ${app}    data=${json_string}  headers=${header}       expected_status=Anything

  Status Should Be    ${error_resp}

