*** Settings ***
Library	 RequestsLibrary
Library  String             # potřebujeme pro klíčové slovo: Encode String To Bytes
#Library	 Collections


*** Variables ***
${url}		    http://testovani.kitner.cz/
${app}          /regkurz/formsave.php

#${json}      {"targetid":"pip ","kurz":"2","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}

*** Test Cases ***
pozitivni - kontrola content-type v hlavicce
    ${resp} =   API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  200
    should be equal    ${resp.headers}[content-type]    application/json;charset=utf-8

pozitivni - kontrola JSON odpovedi
    ${resp} =   API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  200
    should be true     ${resp.json()} == {'response': '200', 'kurz': '2', 'name': 'Jan', 'surname': 'Novak', 'email': 'jan.novak@abc.cz', 'phone': '608123123', 'person': 'fyz', 'address': 'Brno', 'ico': '234563234', 'count': '1', 'comment': None, 'souhlas': True}

negativni - pismeno v count
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"a","comment":null,"souhlas":true}  500

negativni - neplatny email
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"jan.novakabc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500

negativni - prazdny kurz
    API Comunication   {"targetid":"","kurz": null,"name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500

negativni - vynechany kurz
    ${resp} =   API Comunication   {"targetid":"","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500
    log to console  ${resp.json()}

*** Keywords ***

API Comunication
    [Arguments]       ${json}     ${error_resp}

  #převedení do UTF-8
  ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8          #vyžaduje knihovnu String

  #vytoření hlavičky (header) zprávy
  &{header} =          Create Dictionary   Content-Type=application/json     charset=utf-8

  #vytvoření spojení (session)
  CreateSession       apilogin            ${url}

  # odeslání zprávy a uložení odpovědi do ${resp} + kontrola, ze http status je stejny jako v JSON odpovedi
  ${resp} =   Post on Session   apilogin  ${app}   data=${json_utf8}   headers=${header}   expected_status=Anything
  should be equal    ${resp.json()}[response]   ${error_resp}
  Status Should Be    ${error_resp}
  [return]  ${resp}