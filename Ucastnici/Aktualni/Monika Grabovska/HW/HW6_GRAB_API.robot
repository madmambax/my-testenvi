*** Settings ***

Library    RequestsLibrary
Library    String


*** Variables ***
${url}                http://testovani.kitner.cz/
${app}                regkurz/formsave.php
${urlapp}             ${url}${app}
${format_phone}       Enter in format: +420xxxxxxxxx

#${json}         {"targetid":"","kurz":"1","name":"Nunca","surname":"Nunca","email":"nunca@nada.cz","phone":"777777777","person":"fyz","address":"Brno","ico":null,"count":"1","comment":"bla","souhlas":true}
*** Test Cases ***

registration ok
    API Comunication   {"targetid":"","kurz":"1","name":"Nunca","surname":"Nunca","email":"nunca@nada.cz","phone":"777777777","person":"fyz","address":"Brno","ico":null,"count":"1","comment":"bla","souhlas":true}  200

registration phone cuountry ok
    API Comunication   {"targetid":"","kurz":"1","name":"Nunca","surname":"Nada","email":"nunca@nada.cz","phone":"+420777777777","person":"fyz","address":"Brno","ico":null,"count":"1","comment":"bla","souhlas":true}  200

registration empty agreement
    API Comunication   {"targetid":"","kurz":"1","name":"Nunca","surname":"Nunca","email":"nunca@nada.cz","phone":"777777777","person":"fyz","address":"Brno","ico":null,"count":"1","comment":"bla","souhlas":}   500

registration phone no incorrect format
    API Comunication   {"targetid":"","kurz":"1","name":"Nunca","surname":"Nunca","email":"nunca@nada.cz","phone":"nikdy","person":"fyz","address":"Brno","ico":null,"count":"1","comment":"bla","souhlas":true}   500
    Log To Console    ${format_phone}
registration prefix phone invalid format
    API Comunication  {"targetid":"","kurz":"1","name":"Nunca","surname":"Nunca","email":"nunca@nada.cz","phone":"+410 777777777","person":"fyz","address":"Brno","ico":null,"count":"1","comment":"bla","souhlas":true}   500
    Log To Console    ${format_phone}
registration empty phone field
    API Comunication   {"targetid":"","kurz":"1","name":"Nunca","surname":"Nunca","email":"nunca@nada.cz","phone":,"person":"fyz","address":"Brno","ico":null,"count":"1","comment":"bla","souhlas":true}    500
    Log To Console    ${format_phone}
registration phone no too long
    API Comunication    {"targetid":"","kurz":"1","name":"Nunca","surname":"Nunca","email":"nunca@nada.cz","phone":"666666666666666666666","person":"fyz","address":"Brno","ico":null,"count":"1","comment":"bla","souhlas":true}     500
    Log To Console     ${format_phone}
registration invalid email
    API Comunication   {"targetid":"","kurz":"1","name":"Nunca","surname":"Nunca","email":"nunca@","phone":"777777777","person":"fyz","address":"Brno","ico":null,"count":"1","comment":"bla","souhlas":true}    500
registration surname too short
    API Comunication    {"targetid":"","kurz":"1","name":"Nunca","surname":"l","email":"nunca@nada.cz","phone":"777777777","person":"fyz","address":"Brno","ico":null,"count":"1","comment":"bla","souhlas":true}    200
    Log To Console    OK, length is not limited.
registration wrong JSON format: missing key name
    API Comunication   {"targetid":"","kurz":"1","surname":"Nunca","email":"nunca@nada.cz","phone":"777777777","person":"fyz","address":"Brno","ico":null,"count":"1","comment":"bla","souhlas":true}    500
registration wrong JSON format: quotation marks missing for address
    API Comunication   {"targetid":"","kurz":"1","name":"Nunca","surname":"Nunca","email":"nunca@nada.cz","phone":"777777777","person":"fyz",address:"Brno","ico":null,"count":"1","comment":"bla","souhlas":true}     500
registration wron JSON format: incorrect brackets type
    API Comunication   ("targetid":"","kurz":"1","name":"Nunca","surname":"Nunca","email":"nunca@nada.cz","phone":"777777777","person":"fyz","address":"Brno","ico":null,"count":"1","comment":"bla","souhlas":true)    500
    Log To Console    Enter curly brackets
registration course with special character
    API Comunication   {"targetid":"","kurz":"%","name":"Nunca","surname":"Nunca","email":"nunca@nada.cz","phone":"777777777","person":"fyz","address":"Brno","ico":null,"count":"1","comment":"bla","souhlas":true}    500
    Log To Console    Enter in correct format: 1, 2, or 3
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