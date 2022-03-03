
*** Settings ***
Library	 RequestsLibrary
Library  String             # potřebujeme pro klíčové slovo: Encode String To Bytes
Library	 Collections


*** Variables ***
${url}		    http://testovani.kitner.cz/
${app}          /regkurz/formsave.php

#${json}      {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}

*** Test Cases ***

registrace ok
    API Comunicaication  200  {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  

Hranicni hodnoty - phone
    API Comunicaication  500  {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608125758767773123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  

Hranicni hodnoty - name a surname (musí projít 80 znaků - fiktivní teoretický požadavek)
    API Comunicaication  200     {"targetid":"","kurz":"2","name":"AAAAAaaaaaBBBBBbbbbbAAAAAaaaaaBBBBBbbbbbAAAAAaaaaaBBBBBbbbbb","surname":"AAAAAaaaaaBBBBBbbbbbAAAAAaaaaaBBBBBbbbbbAAAAAaaaaaBBBBBbbbbb","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  

Prazdny string - name
    API Comunicaication  500     {"targetid":"","kurz":"2","name":"","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  

Hodnoty null - name
    API Comunicaication  500     {"targetid":"","kurz":"2","name":null,"surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  

Chybejici PK (povinne klice)
    API Comunicaication   500    {"targetid":"","kurz":"","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  

Chybny format JSON - chybne id klice 
    API Comunicaication  500     {"targetid":"","kurz":"2","naaaaame":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  


Specialni znaky - kladný test
    API Comunicaication  200    {"targetid":"","kurz":"2","name":"Janěščřžýáíé","surname":"Novakěščřžýáíé","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brnoěščřžýáíé","ico":"234563234","count":"1","comment":"ěščřžýáíé@#$%^&*()_+-*/,./';\][","souhlas":true}  

Specialni znaky - negativní test mail
    API Comunicaication  400    {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"ěščřžýáíé.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment"bez komentu","souhlas":true}  

Specialni znaky - negativní test phone
    API Comunicaication  400    {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"ěščřžýáíé","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment"bez komentu","souhlas":true}  

*** Keywords ***

API Comunicaication
    [Arguments]       ${error_resp}      ${json} 

   #převedení do UTF-8
   ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8          #vyžaduje knihovnu String

  #vytoření hlavičky (header) zprávy
  &{header}=          Create Dictionary   Content-Type=application/json     charset=utf-8

  #vytvoření spojení (session)
  CreateSession       apilogin            ${url}

  # odeslání zprávy a uložení odpovědi do ${resp}
  ${resp}=   Post on Session   apilogin  ${app}   data=${json_utf8}   headers=${header}   expected_status=Anything

  Status Should Be    ${error_resp}
