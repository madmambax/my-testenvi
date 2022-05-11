
*** Settings ***
Library  RequestsLibrary


*** Variables ***
${url}      http://testovani.kitner.cz/
${app}      regkurz/formsave.php
${urlapp}   ${url}${app}


*** Test Cases ***

Chybny format dat místo DATA pouzit JSON
    ${json}=  catenate  {"targetid":"","kurz":"1","name":"Jan","surname":"Tester","email":"jan.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
    POST    ${urlapp}   json=${json}  expected_status=500

Vše OK
    ${json}=        catenate  {"targetid":"","kurz":"1","name":"Jan","surname":"Tester","email":"jan.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
    ${response}=    POST    ${urlapp}   data=${json}  expected_status=200
    log to console  ${response.json()}[response]


Chybné číslo kurzu
    ${json}=  catenate  {"targetid":"","kurz":"5","name":"Jan","surname":"Tester","email":"jan.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
    ${response}=  POST    ${urlapp}   data=${json}  expected_status=200

    #Pozor na psani a nepsaní kulatých závorek
#    log to console  ${response.json}
    log to console  ${response.json()}
    log to console  ${response.json()}[response]
    log to console  ${response.json()}[reason]
#    log to console  ${response.text}





Prvni API test - registrace na kurz (Post On Session)
   # vytoření JSON zprávy
   ${json}=  catenate  {"targetid":"","kurz":"1","name":"Jan","surname":"Tester","email":"jan.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}

   # vytoření hlavičky (header) zprávy
   &{header}=   Create Dictionary   Content-Type=application/json

   # vytvoření spojení (session)
   CreateSession       apilogin            ${url}

   # odeslání zprávy a uložení odpovědi do ${resp}
   ${resp} =  Post on Session  apilogin  ${app}  data=${json}  headers=${header}

   Status Should Be  200   # vyhodnocení









#Prvni API test - registrace na kurz
    # vytoření JSON zprávy


    # vytoření hlavičky (header) zprávy


    # vytvoření spojení (session)


    # odeslání zprávy a uložení odpovědi do ${resp}


    # vyhodnocení





















#bonus test
#    GET     https://www.google.com
#    Status Should Be    200



#Prvni API test - registrace na kurz
#    # vytoření JSON zprávy
#    ${json}=  catenate  {"targetid":"","kurz":"1","name":"Jan","surname":"Tester","email":"jan.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
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
#    Status Should Be  200   # vyhodnocení
#
#    #VYHODNOCENÍ: status code na request (dotaz) - verze 2
#    Should Be Equal As Strings        200  ${resp.status_code}
#
#    #VYHODNOCENÍ: celý JSON
#    &{JSON_expected}=   Create Dictionary    response=200  kurz=1  name=Jan  surname=Tester  email=jan.tester@data.cz  phone=777123132  person=fyz  address=Udolni 21, Brno  ico=27232433  count=1  comment=nic  souhlas=${TRUE}
#    Dictionaries Should Be Equal      ${JSON_expected}    ${resp.json()}
#
#    #VYHODNOCENÍ: klíč v JSONu
#    Dictionary Should Contain Key	  ${resp.json()}      email
#
#    #VYHODNOCENÍ: klíč s konkrétní hodnotou  v JSONu
#    Dictionary Should Contain Item    ${resp.json()}      email    jan.tester@data.cz
#
