#DÚ 06 Testování API

*** Settings ***
Documentation  API testování - test komunikace
Library	 RequestsLibrary
Library  String             # potřebujeme pro klíčové slovo: Encode String To Bytes


*** Variables ***
${url}		    http://testovani.kitner.cz/
${app}          /regkurz/formsave.php
${urlapp}       ${url}${app}

#${json}      {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}


*** Test Cases ***

Registrace na kurz vse ok
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  200

Registrace ptazdna hodnota telefonu
    API Comunication   {"targetid":"","kurz":"","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500

Registrace chybny telefon (moc dlouhy)
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123608123123608123123608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500

Registrace chybny email (chybnyemail.cz)
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"chybnyemail.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500

Registrace chybny format JSON (bez povinneho klice kurz)
    API Comunication   {"targetid":"","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500

Registrace chybejici hodnota kurzu
    API Comunication   {"targetid":"","kurz":"","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500

Registrace chybny format JSON (schazejici uvozovky u souhlas)
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null, souhlas:true}  500

Registrace chybny format JSON (schazejici slozene zavorky)
    API Comunication   "targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null, "souhlas":true  500

Registrace moc dlouhe jmeno
    API Comunication   {"targetid":"","kurz":"2","name":"Jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaannnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  200
    Log To Console     Dlouhe jmeno je OK, nejsou nastaveny horni hranicni hodnoty

Registrace kratke jmeno
    API Comunication   {"targetid":"","kurz":"2","name":"J","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  200
    Log To Console     Kratke jmeno je OK, neni nastavena dolni hranicni hodnota

Registrace nevyplnene jmeno
    API Comunication   {"targetid":"","kurz":"2","name":"","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500

Registrace ciselne znaky jmeno
    API Comunication   {"targetid":"","kurz":"2","name":"007","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  200
    Log To Console     Jmeno pouze z ciselnych znaku OK

Registrace specialni znaky jmeno
    API Comunication   {"targetid":"","kurz":"2","name":"J@n#","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  200
    Log To Console     Specialni znaky v name OK

Registrace specialni znaky phone
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608#23!2@","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500

Registrace specialni znaky adress
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"B#n@","ico":"234563234","count":"1","comment":null,"souhlas":true}  200
    Log To Console     Adress akceptuje specialni znaky

Registrace bez povinného klice surname
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500

Registrace vysoky pocet osob (999999999999999999)
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"999999999999999999","comment":null,"souhlas":true}  200
    Log To Console     Registraci prochazi i vysoky pocet osob

Registrace souhlas false
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":false}  200

Registrace comment "xyz"
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":"xyz","souhlas":true}  200

Registrace spatny format ico (XcZ54UJkj569gvfvD5D)
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"XcZ54UJkj569gvfvD5D","count":"1","comment":null,"souhlas":true}  200
    Log To Console     Formular dovoluje registraci i s nespravnym formatem hodnoty ico


*** Keywords ***

API Comunication
    [Arguments]       ${json}     ${error_resp}

    #převedení do UTF-8
    ${json_utf8} =      Encode String To Bytes     ${json}     UTF-8          #vyžaduje knihovnu String

    ${resp} =           POST  ${urlapp}  data=${json_utf8}  expected_status=${error_resp}

    Log                 ${resp.json()}

    Status Should Be    ${error_resp}