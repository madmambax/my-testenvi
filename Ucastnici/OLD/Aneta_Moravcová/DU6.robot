*** Settings ***

Library	    RequestsLibrary
Library     String


*** Variables ***

${url}          http://testovani.kitner.cz/
${app}          /regkurz/formsave.php
${urlapp}       ${url}${app}

#${json}         {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}


*** Test Cases ***

Uspesna registrace
     API Comunication     {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}     200

Registrace bez volby kurzu
     API Comunication     {"targetid":"","kurz":"","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}     500

Registrace bez telefonního čísla
     API Comunication     {"targetid":"","kurz":"1","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}     500

Registrace s příliš dlouhým telefonním číslem
     API Comunication     {"targetid":"","kurz":"1","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"6081231234","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}     500

Registrace s chybným e-mailem
     API Comunication     {"targetid":"","kurz":"1","name":"Jan","surname":"Novak","email":"tohleneniemail.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}     500

Registrace - chybny format JSON (bez klice a hodnoty kurzu)
     API Comunication     {"targetid":"","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"604123123","person":"fyz","adress":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}     500

Registrace - chybny format JSON ("comment":ahoj)
     API Comunication     {"targetid":"","kurz":"1","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"604123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":ahoj,"souhlas":true}     500


*** Keywords ***

API Comunication
     [Arguments]          ${json}          ${error_resp}

     ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8
     ${resp} =          POST     ${urlapp}     data=${json_utf8}     expected_status=${error_resp}
     Log                ${resp.json()}
     Status Should Be   ${error_resp}

API Comunicaication Post on Session
    [Arguments]          ${json}          ${error_resp}

    ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8
    &{header}=         Create Dictionary     Content-Type=application/json     charset=utf-8
    CreateSession      apilogin    ${url}
    ${resp}=           Post on Session     apilogin     ${app}     data=${json_utf8}     headers=${header}     expected_status=Anything
    Status Should Be   ${error_resp}