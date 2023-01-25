
*** Settings ***
Library  RequestsLibrary
Library  String


*** Variables ***
${url}      http://testovani.kitner.cz/
${app}      regkurz/formsave.php
${urlapp}   ${url}${app}


*** Test Cases ***

registrace ok
    API Comunication   {"targetid":"","kurz":"1","name":"Petr","surname":"Kono","email":"p_kono@moomo.cz","phone":"777123321","person":"fyz","address":"nám. Dr. E. Beneše 559/28, Liberec","ico":"27232433","count":"1","comment":"test1_moomo","souhlas":true}  200



registrace bez volby kurzu
    API Comunication   {"targetid":"","kurz":"","name":"Petr","surname":"Kono","email":"p_kono@moomo.cz","phone":"777123321","person":"fyz","address":"nám. Dr. E. Beneše 559/28, Liberec","ico":"27232433","count":"1","comment":"test1_moomo","souhlas":true}   500


*** Keywords ***

API Comunication
    [Arguments]            ${json}     ${error_resp}
    ${json}=     Catenate  ${json}
    ${json} =    Encode String To Bytes     ${json}     UTF-8
    ${response} =       POST  ${urlapp}  data=${json}   expected_status=${error_resp}

    Should Be Equal As Integers    ${response.json()}[response]    ${error_resp}
    Should Be Equal As Integers    ${response.status_code}             ${error_resp}
    # odeslání zprávy a uložení odpovědi do ${resp}  (POST dotaz)
    #${response} =       POST  ${urlapp}  data=${json}   expected_status=${error_resp}




*** Comments ***
#Quick Get A JSON Body Test
#      ${response}=    GET  https://jsonplaceholder.typicode.com/posts/1
#      Should Be Equal As Strings    1  ${response.json()}[id]
#      Log To Console    ${response}
#      Log To Console    reason: ${response.reason}
#      Log to Console    ${response.headers}
#      Should Be Equal As Strings    1  ${response.json()}[userId]
#      Should Be Equal As Strings    1  ${response.json()}[id]

Registrace na kurz
${json} =   Catenate  {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}

      ${response}=    POST  ${urlapp}  data=${json}  expected_status=200

      Should Be Equal As Strings    ${response.json()}[response]   200


