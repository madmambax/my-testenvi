*** Settings ***
Library	 RequestsLibrary
Library	 Collections
Library  String


*** Variables ***
${url}		    http://testovani.kitner.cz
${app}          /regkurz/formsave.php

#${json}      {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}

*** Test Cases ***

bonus test
    GET     https://www.imdb.com/
    Status Should Be    200

registrace ok
    API Comunicaication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  200

registrace chyba
    API Comunicaication   {"targetid":"","kurz":"","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500

registrace chybny telefon (moc dlouhy)
    API Comunicaication   {"targetid":"","kurz":"1","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"60812312300000000000000","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   400

chybny format JSON (bez kurzu)
    API Comunicaication   {"targetid":"","kurz":"","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  400

prazdna_pole
    API Comunicaication   {"targetid":"","kurz":"","name":"","surname":"","email":"","phone":"","person":"","address":"","ico":"","count":"","comment":null,"souhlas":true}  400

specialni_znak_ve_jmene
    API Comunicaication   {"targetid":"","kurz":"1","name":"-+-/§.´","surname":"Radostická","email":"a.nonymous@example.com","phone":"000000000","person":"fyz","address":"Praha","ico":"25596641","count":"10","comment":null,"souhlas":true}  400





*** Keywords ***

API Comunicaication
    [Arguments]       ${json}     ${error_resp}

   #převedení do UTF-8
   ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8          #vyžaduje knihovnu String

  #vytoření hlavičky (header) zprávy
  &{header}=          Create Dictionary   Content-Type=application/json     charset=utf-8

  #vytvoření spojení (session)
  CreateSession       apilogin            ${url}

  # odeslání zprávy a uložení odpovědi do ${resp}
  ${resp} =    Post on Session    apilogin  ${app}    data=${json_utf8}  headers=${header}       expected_status=Anything

  Status Should Be    ${error_resp}


 @{list1} =      Create List    first    second    third

  Log Many            @{list}