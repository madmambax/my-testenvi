*** Comments ***

*** Settings ***
Documentation   Klicova slova pro API komunikaci
Library  RequestsLibrary
Library  String

*** Variables ***
${url}      http://testovani.kitner.cz/
${app}      regkurz/formsave.php
${urlapp}   ${url}${app}

*** Test Cases ***

API case #1
    [Documentation]    Registrace ok
    [Tags]              Funkční
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  200

API case #2
    [Documentation]    Registrace bez volby kurzu
    [Tags]              Funkční
    API Comunication   {"targetid":"","kurz":"","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500

*** Keywords ***

API Comunication
    [Arguments]       ${json}     ${error_resp}
    # vytoření JSON zprávy
    # ${json}=  catenate  {"targetid":"","kurz":"","name":"Jan","surname":"Tester","email":"jan.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}

    # odeslání zprávy a uložení odpovědi do ${resp}  (POST dotaz)
    ${resp} =       POST  ${urlapp}  data=${json}   expected_status=${error_resp}




