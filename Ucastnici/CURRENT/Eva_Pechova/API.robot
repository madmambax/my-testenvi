*** Settings ***
Library  RequestsLibrary

*** Variables ***
${url}    http://testovani.kitner.cz/
${app}    regkurz/formsave.php

*** Test Cases ***

Prvni API test - registrace na kurz

    ${json}=  catenate  {"targetid":"","kurz":"1","name":"Jan","surname":"Tester","email":"jan.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
    ${json}=  catenate  {"targetid":"","kurz":"1","name":"Radim","surname":"Kalina","email":"radim.kalina@gamil.com","phone":"777582132","person":"fyz","address":"Belehradska", Praha","ico":"27285233","count":"1","comment":"nic","souhlas":true}
    &{header}=   Create Dictionary   Content-Type=application/json

    # vytvoření spojení (session)
    CreateSession       apilogin            ${url}

    ${resp} =  Post on Session  apilogin  ${app}  data=${json}  headers=${header}   expected_status=Anything

    # odeslání zprávy a uložení odpovědi do ${resp}
    ${resp} =  Post on Session  apilogin  ${app}  data=${json}  headers=${header}

    # vyhodnocení
    Status Should Be  200

 #VYHODNOCENÍ: status code na request (dotaz) - verze 2
   Should Be Equal As Strings        200  ${resp.status_code}
   #VYHODNOCENÍ: celý JSON
   &{JSON_expected}=   Create Dictionary    response=200  kurz=1  name=Jan  surname=Tester  email=jan.tester@data.cz  phone=777123132  person=fyz  address=Udolni 21, Brno  ico=27232433  count=1  comment=nic  souhlas=${TRUE}
   Dictionaries Should Be Equal      ${JSON_expected}    ${resp.json()}
   #VYHODNOCENÍ: klíč v JSONu
   Dictionary Should Contain Key    ${resp.json()}      email
   #VYHODNOCENÍ: klíč s konkrétní hodnotou  v JSONu
   Dictionary Should Contain Item    ${resp.json()}      email    jan.tester@data.cz