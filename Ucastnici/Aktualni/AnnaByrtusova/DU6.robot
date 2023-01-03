*** Settings ***
Library	 RequestsLibrary
Library  String

*** Variables ***
${url}		    http://testovani.kitner.cz/
${app}          /regkurz/formsave.php
${urlapp}       ${url}${app}


*** Test Cases ***

registrace ok
    API Comunication   {"targetid":"","kurz":"2","name":"Anna","surname":"Byrtusová","email":"anna.byrtusova@devx.agency","phone":"720123456","person":"fyz","address":"Třinec","ico":"123456789","count":"1","comment":"text","souhlas":true}     200

registrace predvolba u tel.cisla - ok
    API Comunication   {"targetid":"","kurz":"1","name":"Anna","surname":"Byrtusová","email":"anna.byrtusova@devx.agency","phone":"+420 720123456","person":"fyz","address":"Třinec","ico":"123456789","count":"1","comment":"text","souhlas":true}  500

registrace bez volby kurzu
    API Comunication   {"targetid":"","kurz":"","name":"Anna","surname":"Byrtusová","email":"anna.byrtusova@devx.agency","phone":"720123456","person":"fyz","address":"Třinec","ico":"123456789","count":"1","comment":"text","souhlas":true}      500

registrace volby telefonu (prázdný)
    API Comunication   {"targetid":"","kurz":"2","name":"Anna","surname":"Byrtusová","email":"anna.byrtusova@devx.agency","phone":"","person":"fyz","address":"Třinec","ico":"123456789","count":"1","comment":"text","souhlas":true}       500

registrace chybny telefon (moc dlouhy)

    API Comunication   {"targetid":"","kurz":"2","name":"Anna","surname":"Byrtusová","email":"anna.byrtusova@devx.agency","phone":"7201234562136668","person":"fyz","address":"Třinec","ico":"123456789","count":"1","comment":"text","souhlas":true}    500

registrace chybny email (tohleneniemail.cz)

    API Comunication   {"targetid":"","kurz":"2","name":"Anna","surname":"Byrtusová","email":"anna.byrtusovadevx.agency","phone":"720123456","person":"fyz","address":"Třinec","ico":"123456789","count":"1","comment":"text","souhlas":true}  500


registrace chybny format JSON (bez klíče a hodnoty kurzu)

    API Comunication   {"targetid":"","name":"Anna","surname":"Byrtusová","email":"anna.byrtusova@devx.agency","phone":"720648123","person":"fyz","address":"Třinec","ico":"123456789","count":"1","comment":"text","souhlas":true}    500

registrace kurz má hodnotu null
    API Comunication   {"targetid":"","kurz":"null","name":"Anna","surname":"Byrtusová","email":"anna.byrtusova@devx.agency","phone":"720123456","person":"fyz","address":"Třinec","ico":"123456789","count":"1","comment":"text","souhlas":true}  500

registrace chybny format JSON (chybi zavorka)
    API Comunication   "targetid":"","kurz":"1","name":"Anna","surname":"Byrtusová","email":"anna.byrtusova@devx.agency","phone":"720123456","person":"fyz","address":"Třinec","ico":"123456789","count":"1","comment":"text","souhlas":true  500

registrace specialni znaky
    API Comunication   {"targetid":"","kurz":"§","name":"Anna","surname":"Byrtusová","email":"anna.byrtusova@devx.agency","phone":"720123456","person":"fyz","address":"Třinec","ico":"123456789","count":"1","comment":"text","souhlas":true}  500



*** Keywords ***

API Comunication
    [Arguments]         ${json}     ${error_resp}

    #převedení do UTF-8
    ${json_utf8} =      Encode String To Bytes     ${json}     UTF-8

    ${resp} =           POST  ${urlapp}  data=${json_utf8}  expected_status=${error_resp}

    Log                 ${resp.json()}
    Status Should Be    ${error_resp}



