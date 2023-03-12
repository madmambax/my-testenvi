
*** Settings ***
Library    RequestsLibrary
Library    String
Library    Collections


*** Variables ***
${url}      http://testovani.kitner.cz/
${app}      regkurz/formsave.php
${urlapp}   ${url}${app}


*** Test Cases ***

registrace ok
    API Comunication   {"targetid":"","kurz":"2","name":"Janppek","surname":"Novajaader","email":"jakn.no22vak@abc.cz","phone":"608187123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  200

registrace phone cuountry ok
    API Comunication   {"targetid":"","kurz":"2","name":"Jaoek","surname":"Novarbbrů","email":"janp.no2vak@abc.cz","phone":"+420777222555","person":"fyz","address":"Brno","ico":"235563234","count":"1","comment":null,"souhlas":true}  200

#registrace bez volby kurzu
#    API Comunication   {"targetid":"","kurz":"","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500

registration long phone number
    API Comunication   {"targetid":"","kurz":"1","name":"Jan","surname":"ZRokycan","email":"jan.novak@abc.cz","phone":"608123123235694","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500

*** Keywords ***

API Comunication
# add 3rd argument -- expected error ${exp_error}
    [Arguments]       ${json}     ${error_resp}

    #transformation to UTF-8
    ${json_utf8} =      Encode String To Bytes     ${json}     UTF-8

    #POST query
    ${resp} =           POST  ${urlapp}  data=${json_utf8}  expected_status=${error_resp}

    #Save responce to log
    Log                 ${resp.json()}

    #Verify result
    Status Should Be                ${error_resp}
    #Verify field with issue
#    Should Be Equal As Strings      ${resp.json()}[problem][0][field]     phone
     IF  ${resp.json()}[response] == 200
                       Log To Console             Registration success!
     ELSE
                       Log                             ${resp.json()}[problem][0][field]
                       Should Be Equal As Strings      ${resp.json()}[problem][0][field]     phone
                       Log                             ${resp.json()}[problem][0][issue]
                       Should Be Equal As Strings      ${resp.json()}[problem][0][issue]     format
     END
#Verify field with issue
#If  ${error_resp} == 200
#   Log  ${Reg}

#Else
    #    Log                             ${resp.json()}[problem][0][field]
    #    Should Be Equal As Strings      ${resp.json()}[problem][0][field]     phone
    #    Log                             ${resp.json()}[problem][0][issue]
    #    Should Be Equal As Strings      ${resp.json()}[problem][0][issue]     empty