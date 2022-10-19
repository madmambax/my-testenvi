*** Settings ***
Library  RequestsLibrary
Library  Collections

*** Variables ***
${url}    http://testovani.kitner.cz/
${app}    regkurz/formsave.php

*** Test Cases ***
bonus test
   GET     https://www.google.com
   Status Should Be    200

Prvni API test - registrace na kurz
   # vytoření JSON zprávy
   ${json}=  catenate  {"targetid":"","kurz":"1","name":"Jan","surname":"Tester","email":"jan.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}

   # vytoření hlavičky (header) zprávy
   &{header}=   Create Dictionary   Content-Type=application/json

   # vytvoření spojení (session)
   CreateSession       apilogin            ${url}

   # odeslání zprávy a uložení odpovědi do ${resp}
   ${resp} =  Post on Session  apilogin  ${app}  data=${json}  headers=${header}   expected_status=Anything

   Status Should Be  200   # vyhodnocení

    Log To Console  ${resp}
    Log To Console  ${resp.status_code}
    Log To Console  ${resp.reason}
    Log To Console  ${resp.json()}

   #VYHODNOCENÍ: status code na request (dotaz) - verze 2
   Should Be Equal As Strings        200  ${resp.status_code}
   #VYHODNOCENÍ: celý JSON
   &{JSON_expected}=   Create Dictionary    response=200  kurz=1  name=Jan  surname=Tester  email=jan.tester@data.cz  phone=777123132  person=fyz  address=Udolni 21, Brno  ico=27232433  count=1  comment=nic  souhlas=${TRUE}
   Dictionaries Should Be Equal      ${JSON_expected}    ${resp.json()}
   #VYHODNOCENÍ: klíč v JSONu
   Dictionary Should Contain Key    ${resp.json()}      email
   #VYHODNOCENÍ: klíč s konkrétní hodnotou  v JSONu
   Dictionary Should Contain Item    ${resp.json()}      email    jan.tester@data.cz

