*** Settings ***

Library    RequestsLibrary
Library    String
Library    Collections


*** Variables ***
${url}                http://testovani.kitner.cz/
${app}                regkurz/formsave.php
${urlapp}             ${url}${app}


*** Test Cases ***

registrace ok
    API Comunication   {"targetid":"","kurz":"2","name":"Jauptz","surname":"No1ltreíů","email":"jantr.no282vak@abc.cz","phone":"608287123","person":"fyz","address":"Brno","ico":"62560131","count":"1","comment":null,"souhlas":true}  200

registrace phone cuountry ok
    API Comunication   {"targetid":"","kurz":"2","name":"Janek","surname":"Novarllrů","email":"jan.no2vak@abc.cz","phone":"+420777222555","person":"fyz","address":"Brno","ico":"235563234","count":"1","comment":null,"souhlas":true}  200

registrace empty course
    API Comunication   {"targetid":"","kurz":"","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500

registration long phone number
    API Comunication   {"targetid":"","kurz":"1","name":"Jan","surname":"ZRokycan","email":"jan.novak@abc.cz","phone":"608123123235694","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500

registration prefix phone invalid format
    API Comunication   {"targetid":"","kurz":"1","name":"Jan","surname":"ZRokycan","email":"jan.novak@abc.cz","phone":"+420 777587479","person":"pra","ico":"62560131","count":"1","comment":null,"souhlas":true}   500

registration empty phone field
    API Comunication   {"targetid":"","kurz":"2","name":"Andre","surname":"Brabec","email":"alik@jjo.cz","phone":"","person":"fyz","address":"Opava","ico":"123456789","count":"1","comment":"text","souhlas":true}    500

registration invalid email
    API Comunication   {"targetid":"","kurz":"2","name":"Andre","surname":"Brabec","email":"alik.jjo.cz","phone":"777444888","person":"fyz","address":"Opava","ico":"123456789","count":"1","comment":"text","souhlas":true}    500

registration missing course key
    API Comunication   {"targetid":"","name":"Andre","surname":"Brabec","email":"alik@jjo.cz","phone":"777444888","person":"fyz","address":"Opava","ico":"123456789","count":"1","comment":"text","souhlas":true}    500

registration course with special character
    API Comunication   {"targetid":"","kurz":"#","name":"Andre","surname":"Brabec","email":"alik@jjo.cz","phone":"777444888","person":"fyz","address":"Opava","ico":"123456789","count":"1","comment":"text","souhlas":true}    500

*** Keywords ***

API Comunication
# 3rd argument -- expected error
    [Arguments]       ${json}     ${error_resp}
    #transformation to UTF-8
    ${json_utf8} =      Encode String To Bytes     ${json}     UTF-8

    #POST query
    ${resp} =           POST  ${urlapp}  data=${json_utf8}  expected_status=${error_resp}

    #Save responce to log
    Log                             ${resp.json()}
    #Verify result
    Status Should Be                ${error_resp}