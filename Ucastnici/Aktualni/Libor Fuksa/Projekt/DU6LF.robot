
*** Settings ***
Library	 RequestsLibrary
Library  String             # potřebujeme pro klíčové slovo: Encode String To Bytes
Library	 Collections


*** Variables ***
${url}		    http://testovani.kitner.cz/
${app}          /regkurz/formsave.php
${urlapp}       ${url}${app}
${hodneznaku}   VlidkůlfgjdsklghjkerVlidkůlfgjdsklghjkerVlidkůlfgjdsklghjkerVlidkůlfgjdsklghjkerVlidkůlfgjdsklghjkerVlidkůlfgjdsklghjkerVlidkůlfgjdsklghjkerVlidkůlfgjdsklghjkerVlidkůlfgjdsklghjkerVlidkůlfgjdsklghjkerVlidkůlfgjdsklghjkerVlidkůlfgjdsklghjkerVlidkůlfgjdsklghjkerVlidkůlfg
*** Test Cases ***

registrace OK
  API Comunication      200     200     {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}
registrace NOK - "kurz" s hodnotou 0
  API Comunication      500     500     {"targetid":"","kurz":"0","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}
registrace NOK - "kurz" mimo hodnoty 1-3 (hodnota 4)
  API Comunication      200     500     {"targetid":"","kurz":"4","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}
registrace NOK - "kurz" prazdne
  API Comunication      500     500     {"targetid":"","kurz":"","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}
registrace NOK - "name" prázdné
  API Comunication      500     500     {"targetid":"","kurz":"2","name":"","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}
registrace OK - "name" 1000 znaků
  API Comunication      200     200     {"targetid":"","kurz":"2","name":"${hodneznaku}","surname":"MujTestTRINACT","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}
registrace OK - "name" s mezerou
  API Comunication      200     200     {"targetid":"","kurz":"2","name":"Tomas Franta Pepa","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}
registrace NOK - "surname" prázdný
  API Comunication      500     500     {"targetid":"","kurz":"2","name":"Jan","surname":"","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}
registrace OK - "surname" 1000 znaků
  API Comunication      200     200     {"targetid":"","kurz":"2","name":"Tomáš","surname":"${hodneznaku}","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}
registrace OK - "e-mail" krátký
  API Comunication      200     200     {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"a@b.z","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}
registrace NOK - "e-mail" chybí část před doménou
  API Comunication      500     500     {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"@ab.z","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}
registrace NOK - "e-mail" chybí zavináč
  API Comunication      500     500     {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"ab.z","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}
registrace NOK - "e-mail" chybí tečka
  API Comunication      500     500     {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"a@bz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}
registrace NOK - "e-mail" chybí doménová přípona
  API Comunication      500     500     {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"a@bz.","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}
registrace OK - "phone" s předvolbou +420
  API Comunication      200     200     {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"+420608153123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}
registrace NOK - "phone" 13 číslic
  API Comunication      500     500     {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"0420608153123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}
registrace NOK - "phone" 8 číslic
  API Comunication      500     500     {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"60812312","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}
registrace NOK - "phone" 10 číslic
  API Comunication      500     500     {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"6081231235","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}
registrace NOK - "phone" písmeno
  API Comunication      500     500     {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"6081k3123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}
registrace NOK - "phone" prázdné
  API Comunication      500     500     {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}
registrace NOK - "person" not fyz or pra
  API Comunication      500     500     {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"6081k3123","person":"kla","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}
registrace NOK - "person" prázdné
  API Comunication      500     500     {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"6081k3123","person":"","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}
registrace NOK - "address" prázdné
  API Comunication      500     500     {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"pra","address":"","ico":"234563234","count":"1","comment":null,"souhlas":true}
registrace OK - "address" dlouhá 1000 znaků
  API Comunication      200     200     {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"${hodneznaku}","ico":"234563234","count":"1","comment":null,"souhlas":true}
registrace OK - "ICO" prazdne + "person" fyz
  API Comunication      200     200     {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"","count":"1","comment":null,"souhlas":true}
registrace NOK - "ICO" prazdne + "person" pra
  API Comunication      500     500     {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"pra","address":"Brno","ico":"","count":"1","comment":null,"souhlas":true}
registrace NOK - "ICO" pismeno
  API Comunication      500     500     {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"23h56323","count":"1","comment":null,"souhlas":true}
registrace NOK - "ICO" spec znak (+)
  API Comunication      500     500     {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"23+56323","count":"1","comment":null,"souhlas":true}
registrace NOK - "count" nevyplnen
  API Comunication      500     500     {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"","comment":null,"souhlas":true}
registrace NOK - "count" 0
  API Comunication      500     500     {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"0","comment":null,"souhlas":true}
registrace NOK - "count" písmeno
  API Comunication      500     500     {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"h","comment":null,"souhlas":true}
registrace NOK - "count" spec znak _
  API Comunication      500     500     {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"_","comment":null,"souhlas":true}
registrace NOK - "count" spec znak " "
  API Comunication      500     500     {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":" ","comment":null,"souhlas":true}
registrace OK - "souhlas" false
  API Comunication      200     200     {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":false}
registrace NOK - "souhlas" prazdny
  API Comunication      500     500     {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":}
registrace NOK - "souhlas" False
  API Comunication      500     500     {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":False}
registrace NOK - chybny JSON - nekompletni JSON (chybějící klíč i hodnota "name")
  API Comunication      500     500     {"targetid":"","kurz":"2","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}
registrace NOK - chybny JSON - neuzavřený }
  API Comunication      500     500     {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true
registrace NOK - chybny JSON - chybi v klici kurz "
  API Comunication      500     500     {"targetid":"",kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true
registrace NOK - chybny JSON - chybi v hodnote klice kurz "
  API Comunication      500     500     {"targetid":"","kurz":"2,"name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true
registrace NOK - chybny JSON - chybi v u klice kurz :
  API Comunication      500     500     {"targetid":"","kurz""2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true
registrace NOK - chybny JSON - pridany klic a hodnota
  API Comunication      500     500     {"novy klic":"hoj","targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"pokus153.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}
registrace NOK - chybny JSON - zdvojeny klic a hodnota "name"
  API Comunication      500     500     {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"teset1877.novak@abc.cz","phone":"608123123","name":"Franta","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}


*** Keywords ***

API Comunication
    [Arguments]      ${error_resp}     ${body_response}  ${json}

    #převedení do UTF-8
    ${json_utf8} =      Encode String To Bytes     ${json}     UTF-8          #vyžaduje knihovnu String

    ${resp} =           POST  ${urlapp}  data=${json_utf8}  expected_status=${error_resp}
    Log                 ${resp.json()}
    Log                 ${resp.json()}[response]
    Status Should Be    ${error_resp}
    Should Be Equal     ${resp.json()}[response]    ${body_response}

