
*** Settings ***
Library	 RequestsLibrary
Library  String



*** Variables ***
${url}		    http://testovani.kitner.cz/
${app}          /regkurz/formsave.php
${urlapp}       ${url}${app}

*** Test Cases ***

registrace ok
    API Comunication  {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   200

registrace hranicni hodnoty dlouhe jmeno
    API Comunication    {"targetid":"","kurz":"2","name":"aaaaaaaaaaaaJaaaaaaaaaaaaaaJaaaaaaaaaaaaaaaaaaanJaaaaaaaaaaaaaaaaaaanJaaaJaaaaaaaaaaaaaaJaaaaaaaaaaaaaaaaaaanJaaaaaaaaaaaaaaaaaaanJaaaJaaaaaaaaaaaaaaJaaaaaaaaaaaaanJaaaaaaaaaaaaaaaaaaanJaaaaaaaaaaaaaaaaaaanJaaaaaaJaaaaaaaaaaaaaaJaaaaaaaaaaaaaaaaaaanJaaaaaaaaaaaanJaaaaaaaaaaaaaaaaaaanaaaaan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500
    Log To Console     "nejsou nastaveny horni hranicni hodnoty pro jmeno"
#nejsou nastaveny horni hranicni hodnoty pro jmeno

registrace hranicni hodnoty prazdne jmeno
    API Comunication   {"targetid":"","kurz":"2","name":"","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500

registrace hranicni hodnoty kratke jmeno
    API Comunication   {"targetid":"","kurz":"2","name":"J","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   200

registrace hranicni hodnoty dlouhe prijmeni
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšadsfghfdhtrhbggbvergergegbvrthtezhrefgbegfffffffffffffffffffffffffffffffffffffffffggggggggggggggggggggggggíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500
    Log To Console    "nejsou nastaveny horni hranicni hodnoty pro prijmeni"
#nejsou nastaveny horni hranicni hodnoty pro prijmeni

registrace hranicni hodnoty prazdne prijmeni
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500

registrace hranicni hodnoty kratke prijmeni
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"N","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   200

registrace na kurz prazda hodnota (kurz, telefon)
    API Comunication   {"targetid":"","kurz":"","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500

registrace na kurz prazda hodnota (adresa)
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"","ico":"234563234","count":"1","comment":null,"souhlas":true}   500

spatne napsany pozadavek (bez klicoveho slova email)
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů",:"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500

spatne napsany pozadavek (bez klicoveho slova kurz)
    API Comunication   {"targetid":"",:"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500

chyba v JSON formatu (true)
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608131234","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":truee}   500
    Log To Console     "simulace chyby"
#simulace chyby

chyba v JSON formatu (null chybi)
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.nov@akabc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":,"souhlas":true}   500
    Log To Console     "simulace chyby"
#simulace chyby

specialni znaky jmeno (spatny format)
    API Comunication   {"targetid":"","kurz":"2","name":"Ja#&@[]n","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500
    Log To Console     "akceptuje specialni znaky v name"
#akceptuje specialni znaky v name

specialni znaky tel cislo
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"60#123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500

Vynechan klic a hodnota (phone)
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500



*** Keywords ***

API Comunication
    [Arguments]       ${json}     ${error_resp}

    ${json_utf8} =      Encode String To Bytes     ${json}     UTF-8

    ${resp} =           POST  ${urlapp}  data=${json_utf8}  expected_status=${error_resp}

    Log                 ${resp.json()}

    Status Should Be    ${error_resp}




