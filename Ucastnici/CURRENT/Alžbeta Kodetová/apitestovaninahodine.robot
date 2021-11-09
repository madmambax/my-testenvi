*** Settings ***
Library  RequestsLibrary
Library  String             # potřebujeme pro klíčové slovo: Encode String To Bytes

*** Variables ***
${url}    http://testovani.kitner.cz/
${app}    regkurz/formsave.php

*** Test Cases ***


#Prvni API test - registrace na kurz
#    # vytoření JSON zprávy
#    ${json}=  catenate  {"targetid":"","kurz":"2","name":"Havel","surname":"Tester","email":"jan.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
#
#    # vytoření hlavičky (header) zprávy
#    &{header}=   Create Dictionary   Content-Type=application/json
#
#    # vytvoření spojení (session)
#    CreateSession       apilogin            ${url}
#
#    # odeslání zprávy a uložení odpovědi do ${resp}
#    ${resp} =  Post on Session  apilogin  ${app}  data=${json}  headers=${header}   expected_status=Anything
#
#    # vyhodnocení
#    Status Should Be  200

test s použitím klic. slova pozitivní
    API Comunicaication     {"targetid":"","kurz":"3","name":"Cecil","surname":"Tester","email":"cecil.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 212, Praha","ico":"27232433","count":"1","comment":"nic","souhlas":true}    200

test s použitím klíč. slova negativní
    API Comunicaication     {"targetid":"","kurz":"20","name":"Arnošt","surname":"Tester", "phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}   500

*** Keywords ***

API Comunicaication
    [Arguments]       ${json}     ${error_resp}

   #převedení do UTF-8
   ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8          #vyžaduje knihovnu String, takhle zapnout češtinu - na 2 místech

  #vytoření hlavičky (header) zprávy
  &{header}=          Create Dictionary   Content-Type=application/json     charset=utf-8

  #vytvoření spojení (session)
  CreateSession       apilogin            ${url}

  # odeslání zprávy a uložení odpovědi do ${resp}
  ${resp}=   Post on Session   apilogin  ${app}   data=${json_utf8}   headers=${header}   expected_status=Anything

  Status Should Be    ${error_resp}


