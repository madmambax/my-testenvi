*** Settings ***
Library  RequestsLibrary
Library  String             # potřebujeme pro klíčové slovo: Encode String To Bytes
Library  Collections

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

Pozitivní test čislo kurzu je 1, 2, nebo 3
    API Comunicaication     1  Igor  Lament  jak@se.mas  123456789  fyz  Udolni 212, Praha  27232433  20  nic  true  200
    API Comunicaication     2  Igor  Lament  jak@se.mas  123456789  fyz  Udolni 212, Praha  27232433  20  nic  true  200
    API Comunicaication     3  Igor  Lament  jak@se.mas  123456789  fyz  Udolni 212, Praha  27232433  20  nic  true  200

Negativní test na jméno účastníka
    API Comunicaication     1  12    89*9%"  jak@se.mas  123456789  fyz  Udolni 212, Praha  27232433  20  nic  true  400

Negativní test na email účastníka
    API Comunicaication     1  Igor  Lament  Jak se máš?  123456789  fyz  Udolni 212, Praha  27232433  20  nic  true  200

Negativní test na telefonní číslo účastníka
    API Comunicaication     1  Igor  Lament  jak@se.mas  1234567890  fyz  Udolni 212, Praha  27232433  20  nic  true  200
    API Comunicaication     1  Igor  Lament  jak@se.mas  tel. číslo  fyz  Udolni 212, Praha  27232433  20  nic  true  200

Pozitivní test na prav osobu
# v dokumentaci není, jak má vypadat označení právnícké osoby, domýšlím si, že "prav"
    API Comunicaication     1  Igor  Lament  jak@se.mas  123456789  prav  27232433  20  nic  true  200

Negativní test na fyz/prav osobu
    API Comunicaication     1  Igor  Lament  jak@se.mas  123456789  osoba bez právné subjektivity  27232433  20  nic  true  200
    API Comunicaication     1  Igor  Lament  jak@se.mas  123456789  1                              Udolni 212, Praha  27232433  20  nic  true  200

Negativní test na adresu, když jde o prav osobu
    API Comunicaication     1  Igor  Lament  jak@se.mas  123456789  osoba bez právné subjektivity  Udolni 212, Praha  27232433  20  nic  true  200


*** Keywords ***

API Comunicaication
    [Arguments]       ${course}  ${name}  ${surname}  ${email}  ${phone}  ${person}  ${address}  ${ico}  ${count}  ${comment}  ${souhlas}  ${responce_code}

  # vytvoření těla (body) zprávy
  ${json}=     Catenate      {"targetid":"","kurz":"${course}","name":"${name}","surname":"${surname}","email":"${email}","phone":"${phone}","person":"${person}","address":"${address}","ico":"${ico}","count":"${count}","comment":${comment},"souhlas":${souhlas}}

  #převedení do UTF-8
  ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8          #vyžaduje knihovnu String, takhle zapnout češtinu - na 2 místech

  #vytoření hlavičky (header) zprávy
  &{header}=          Create Dictionary   Content-Type=application/json     charset=utf-8

  #vytvoření spojení (session)
  CreateSession       apilogin            ${url}

  # odeslání zprávy a uložení odpovědi do ${resp}
  ${resp}=   Post on Session   apilogin  ${app}   data=${json_utf8}   headers=${header}   expected_status=Anything

#  Status Should Be    ${error_resp}
  Should Be Equal As Strings	    ${resp.status_code}     ${responce_code}
  Dictionary Should Contain Item	${resp.json()}          response    ${responce_code}



