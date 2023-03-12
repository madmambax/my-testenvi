# Addtional check for course - issue and related fields

*** Settings ***
Library    RequestsLibrary
Library    String
Library    Collections


*** Variables ***
${url}                http://testovani.kitner.cz/
${app}                regkurz/formsave.php
${urlapp}             ${url}${app}
${status_ok}          200
${status_error}       500
${NA_ForOKStatus}     NoAvailable


*** Test Cases ***

registration ok
    API Comunication   {"targetid":"","kurz":"2","name":"Jupertz","surname":"Notreík","email":"jantro.nodavak@abcl.cz","phone":"608257123","person":"fyz","address":"Brno","ico":"62560131","count":"1","comment":null,"souhlas":true}  ${status_ok}   ${NA_ForOKStatus}  ${NA_ForOKStatus}

registration phone cuountry ok
    API Comunication   {"targetid":"","kurz":"1","name":"Jautk","surname":"Norllr","email":"jan.no2vak@abcd.cz","phone":"+420777222555","person":"fyz","address":"Brno","ico":"235563234","count":"1","comment":null,"souhlas":true}  ${status_ok}    ${NA_ForOKStatus}   ${NA_ForOKStatus}

registration empty course
    API Comunication   {"targetid":"","kurz":"","name":"Jan","surname":"Zrokycan","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   ${status_error}   kurz   empty

registration long phone number
    API Comunication   {"targetid":"","kurz":"1","name":"Jan","surname":"Zrokycan","email":"jan.novak@abc.cz","phone":"608123123235694","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   ${status_error}   phone   format

registration prefix phone invalid format
    API Comunication   {"targetid":"","kurz":"1","name":"Jan","surname":"Zrokycan","email":"jan.novak@abc.cz","phone":"+420 777587479","person":"pra","ico":"62560131","count":"1","comment":null,"souhlas":true}   ${status_error}   phone   format

*** Keywords ***

API Comunication
# add 3rd argument -- expected error, field and issue
    [Arguments]       ${json}     ${error_resp}    ${field}      ${field_value}
    #transformation to UTF-8
    ${json_utf8} =      Encode String To Bytes     ${json}     UTF-8

    #POST query
    ${resp} =           POST  ${urlapp}  data=${json_utf8}  expected_status=${error_resp}

    #Save responce to log
    Log                             ${resp.json()}
    #Verify result
#   Status Should Be                ${error_resp}

    #Verify field with issue

    IF          ${resp.json()}[response] == 200
                       Log To Console                  Registration success!
    ELSE IF     ${resp.json()}[response] == 500
                       Log                             ${resp.json()}[problem][0][field]
                       Should Be Equal As Strings      ${resp.json()}[problem][0][field]     ${field}
                       Log                             ${resp.json()}[problem][0][issue]
                       Should Be Equal As Strings      ${resp.json()}[problem][0][issue]     ${field_value}
    END