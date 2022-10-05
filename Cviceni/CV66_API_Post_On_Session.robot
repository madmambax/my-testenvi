
*** Settings ***
Library  RequestsLibrary


*** Variables ***
${url}      http://testovani.kitner.cz/
${app}      regkurz/formsave.php
${urlapp}   ${url}${app}


*** Test Cases ***


#registrace na kurz využívající Post On Session (tedy posílání více zpráv do jedné session)
    # vytoření JSON zprávy


    # vytoření hlavičky (header) zprávy


    # vytvoření spojení (session)


    # odeslání zprávy a uložení odpovědi do ${resp}


    # vyhodnocení











#Prvni API test - registrace na kurz (Post On Session)
#   # vytoření JSON zprávy
#   ${json}=  catenate  {"targetid":"","kurz":"1","name":"Jan","surname":"Tester","email":"jan.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
#
#   # vytoření hlavičky (header) zprávy
#   &{header}=   Create Dictionary   Content-Type=application/json
#
#   # vytvoření spojení (session)
#   CreateSession       apilogin            ${url}
#
#   # odeslání zprávy a uložení odpovědi do ${resp}
#   ${resp} =  Post on Session  apilogin  ${app}  data=${json}  headers=${header}
#
#   Status Should Be  200   # vyhodnocení
#






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
