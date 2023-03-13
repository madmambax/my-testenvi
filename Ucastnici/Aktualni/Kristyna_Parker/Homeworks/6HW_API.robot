*** Settings ***
Library     RequestsLibrary
Library     String

*** Variables ***
${url}      http://testovani.kitner.cz/
${app}      /regkurz/formsave.php
${urlapp}   ${url}${app}

#${json}
#{
#"targetid":"",
#"kurz":"2",       číslo kurzu - 1 (Jak se stát testerem), 2 (Testování v agilním prostředí), 3 (Základy testování softwaru)
#"name":"Kristyna",
#"surname":"Parker",
#"email":"kristy.parker@abc.cz",
#"phone":"741852963",
#"person":"fyz",            fyz/pra
#"address":"Brno",
#"ico":"234563234",
#"count":"1",
#"comment":null,
#"souhlas":true
#}
#Informační 100 – 199
#Úspěch 200 – 299
#Přesměrování 300 – 399
#Chyba klienta 400 – 499
#Chyba serveru 500 – 599


*** Test Cases ***
#200
Registrace OK
    API Communication    {"targetid":"","kurz":"2","name":"Kristyna","surname":"Parker","email":"kristy.parker@abc.cz","phone":"741852963","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}    200
#500
Registrace nevyplněný kurz
    API Communication    {"targetid":"","kurz":"","name":"Kristyna","surname":"Parker","email":"kristy.parker@abc.cz","phone":"741852963","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}    500
#500
Registrace nevyplěné jméno
    API Communication    {"targetid":"","kurz":"2","name":"","surname":"Parker","email":"kristy.parker@abc.cz","phone":"741852963","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}    500
#500
Registrace nevyplěné příjmení
    API Communication    {"targetid":"","kurz":"2","name":"Kristyna","surname":"","email":"kristy.parker@abc.cz","phone":"741852963","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}    500
#500
Registrace nevyplěný email
    API Communication    {"targetid":"","kurz":"2","name":"Kristyna","surname":"Parker","email":"","phone":"741852963","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}    500
#500
Registrace nevyplěný telefon
    API Communication    {"targetid":"","kurz":"2","name":"Kristyna","surname":"Parker","email":"kristy.parker@abc.cz","phone":"","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}    500
#500
Registrace - nevybraný typ osoby
    API Communication    {"targetid":"","kurz":"2","name":"Kristyna","surname":"Parker","email":"kristy.parker@abc.cz","phone":"741852963","person":"","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}    500
#500
Registrace nevyplěný počet osob
    API Communication    {"targetid":"","kurz":"2","name":"Kristyna","surname":"Parker","email":"kristy.parker@abc.cz","phone":"741852963","person":"fyz","address":"Brno","ico":"234563234","count":"","comment":null,"souhlas":true}    500
#500
Registrace nevyplěná adresa
    API Communication    {"targetid":"","kurz":"2","name":"Kristyna","surname":"Parker","email":"kristy.parker@abc.cz","phone":"741852963","person":"fyz","address":"","ico":"234563234","count":"1","comment":null,"souhlas":true}    500
#500
Registrace nevyplněné IČO
    API Communication    {"targetid":"","kurz":"2","name":"Kristyna","surname":"Parker","email":"kristy.parker@abc.cz","phone":"741852963","person":"pra","address":"Brno","ico":"","count":"1","comment":null,"souhlas":true}    500
#200
Registrace nezaškrtnutý souhlas
    API Communication    {"targetid":"","kurz":"2","name":"Kristyna","surname":"Parker","email":"kristy.parker@abc.cz","phone":"741852963","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":false}    200
#500
Registrace - příliš dlouhé telefonní číslo
    API Communication    {"targetid":"","kurz":"2","name":"Kristyna","surname":"Parker","email":"kristy.parker@abc.cz","phone":"7418522225521512963","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}    500
#500
Registrace - email bez zavináče
    API Communication    {"targetid":"","kurz":"2","name":"Kristyna","surname":"Parker","email":"kristy.parkerabc.cz","phone":"741852963","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}    500
#500
chybný formát JSON - neuzavřená závorka
    API Communication    {"targetid":"","kurz":"2","name":"Kristyna","surname":"Parker","email":"kristy.parker@abc.cz","phone":"741852963","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true    500
#500
chybný formát JSON - bez kurzu
    API Communication    {"targetid":"","name":"Kristyna","surname":"Parker","email":"kristy.parker@abc.cz","phone":"741852963","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}    500
#500
Registrace - znaky v telefonním čísle
    API Communication    {"targetid":"","kurz":"2","name":"Kristyna","surname":"Parker","email":"kristy.parker@abc.cz","phone":"7#[]<63@8","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}    500
#400
Registrace - příliš dlouhé jméno
    API Communication    {"targetid":"","kurz":"2","name":"KristynaKristynaKristynaKristynaKristynaKristynaKristynaKristyna"Kristyna"Kristyna"Kristyna"","surname":"Parker","email":"kristy.parker@abc.cz","phone":"741852963","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}    400

#500 - test projde s 200, ale já bych očekávala 500
Registrace - záporné číslo počtu osob
    API Communication    {"targetid":"","kurz":"2","name":"Kristyna","surname":"Parker","email":"kristy.parker@abc.cz","phone":"741852963","person":"fyz","address":"Brno","ico":"234563234","count":"-1","comment":null,"souhlas":true}    500
#200
JSON bez targetid
    API Communication    {"kurz":"2","name":"Kristyna","surname":"Parker","email":"kristy.parker@abc.cz","phone":"741852963","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}    200
#400
Registrace - prázdná pole
    API Communication    {"targetid":"","kurz":"","name":"","surname":"","email":"","phone":"","person":"","address":"","ico":"","count":"","comment":,"souhlas":}    400


*** Keywords ***

API Communication
    [Arguments]     ${json}      ${error_response}

    #převedení do UTF-8
   ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8          #vyžaduje knihovnu String

  #vytoření hlavičky (header) zprávy
  &{header}=          Create Dictionary   Content-Type=application/json     charset=utf-8

  #vytvoření spojení (session)
  CreateSession       apilogin            ${url}

  # odeslání zprávy a uložení odpovědi do ${resp}
  ${resp}=   Post on Session   apilogin  ${app}   data=${json_utf8}   headers=${header}   expected_status=Anything

  Status Should Be    ${error_response}