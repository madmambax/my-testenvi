*** Settings ***
Library	 RequestsLibrary
Library  String             # potřebujeme pro klíčové slovo: Encode String To Bytes
#Library	 Collections


*** Variables ***
${url}		    http://testovani.kitner.cz/
${app}          /regkurz/formsave.php
${urlapp}       ${url}${app}

#${json}      {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}

*** Test Cases ***

registrace ok
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  200

registrace ok (tel. format +420)
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"+420608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  200

registrace ok (tel. format 0042)
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"00420608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  200

registrace ok (email:testmail@háčkyčárky.cz)
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"testmail@háčkyčárky.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  200

#Negativní testy
registrace bez volby kurzu
    API Comunication   {"targetid":"","kurz":"","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500

registrace volby telefonu (prázdný)
    API Comunication   {"targetid":"","kurz":"1","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500

registrace chybny telefon (moc dlouhy)
    API Comunication   {"targetid":"","kurz":"1","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"16081277887753123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500

registrace chybny email (tohleneniemail.cz)
    ${resp} =       POST  ${urlapp}
    ${email}     Set Variable  tohleneniemail.cz
    Should Contain    ${email}    ${resp.json()}   email

registrace chybny format JSON (bez klíče a hodnoty kurzu, tedy)
    API Comunication   {"targetid":"","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500

BONUS: registrace chybny format JSON (vymyslet jinou chybu JSON dat)
    API Comunication   {"targetid":"","kurz":"2","jmeno":"Jan","Příjmení":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500

registrace jméno 31 znaků (Hraniční hodnota30)
    API Comunication   {"targetid":"","kurz":"2","name":"qwertzuiopqwertzuiopqwertzuiopq","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500

registrace chybný email
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"x@xcz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500

*** Keywords ***

API Comunication
    [Arguments]       ${json}     ${error_resp}

    #převedení do UTF-8
    ${json_utf8} =      Encode String To Bytes     ${json}     UTF-8          #vyžaduje knihovnu String

    ${resp} =           POST  ${urlapp}  data=${json_utf8}  expected_status=${error_resp}

    Log                 ${resp.json()}

    Status Should Be    ${error_resp}


API Comunicaication Post on Session
    [Arguments]       ${json}     ${error_resp}

   #převedení do UTF-8
   ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8          #vyžaduje knihovnu String

  #vytoření hlavičky (header) zprávy
  &{header}=          Create Dictionary   Content-Type=application/json     charset=utf-8

  #vytvoření spojení (session)
  CreateSession       apilogin            ${url}

  # odeslání zprávy a uložení odpovědi do ${resp}
  ${resp}=   Post on Session   apilogin  ${app}   data=${json_utf8}   headers=${header}   expected_status=Anything

  Status Should Be    ${error_resp}
