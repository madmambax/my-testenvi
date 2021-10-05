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

*** Test Cases ***


registrace ok
    API Comunication  {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  200

registrace chyba
    API Comunication  {"targetid":"","kurz":"","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500

registrace diakritika
    API Comunication  {"targetid":"","kurz":"1","name":"Přemyšlena","surname":"Čířilová","email":"jan.novak@abc.cz","phone":"111111111","person":"fyz","address":"Brno","ico":"234563234","count":"5","comment":"Komentář v čestině ěščřžýáíé","souhlas":false}  200

registrace chyba email
    API Comunication   {"targetid":"","kurz":"1","name":"Jan","surname":"Novak","email":"jan.novak.abc","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   400

registrace chyba telefon
    API Comunication   {"targetid":"","kurz":"1","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123608123123608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   400


*** Keywords ***

API Comunication
    [Arguments]         ${json}    ${error_resp}

   # zapis jako DATA
   ${json_string}=    catenate    ${json}
   ${bytes} = 	Encode String To Bytes 	${json_string} 	UTF-8


  #vytoření hlavičky (header) zprávy
  &{header}=          Create Dictionary   Content-Type=application/json

  #vytvoření spojení (session)
  CreateSession       apilogin            ${url}

  # odeslání zprávy a uložení odpovědi do ${resp}
  ${resp} =    Post on Session    apilogin  ${app}    data=${bytes}  headers=${header}    expected_status=Anything

  Status Should Be    ${error_resp}

















