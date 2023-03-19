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
    Course registration   2  Jauz  No1ltzroíů  jajntr.nopo2vak@abc.cz  +420707486789  fyz   Brno   1   null  true   200

registrace phone cuountry ok
    Course registration   2  Jaudz  Nolt  jajntr.nopo9vak@abc.cz  +420707486789  fyz  Praha   5   null  true   200

registrace empty course
    Course registration   ${EMPTY}  Jan  Wolf  jajntr.nopo9vak@abc.cz  +420707486789  fyz  Praha   5   null  true   500


registration empty phone field
    Course registration   2  Jaudz  Nolt  jajntr.nopo9vak@abc.cz  ${EMPTY}  fyz  Praha   5   null  true   500

registration empty email
    Course registration   2  Jaudz  Nolt  ${EMPTY}  +420707486789  pra  62560131   5   null  true   500

*** Keywords ***

Course registration

    [Arguments]    ${course}  ${name}  ${surname}  ${email}  ${phone}  ${person}  ${address_ico}  ${count}  ${comment}  ${souhlas}  ${responce_code}

    ${json}=     Catenate      {"targetid":"","kurz":"${course}","name":"${name}","surname":"${surname}","email":"${email}","phone":"${phone}","person":"${person}","address":"${address_ico}","ico":"${address_ico}","count":"${count}","comment":"${comment}","souhlas":${souhlas}}

    #transfef tp UTF-8
    ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8

    #messge header
    &{header}=          Create Dictionary   Content-Type=application/json

    # odeslání zprávy a uložení odpovědi do ${resp}
    ${resp} =           POST  ${urlapp}   data=${json_utf8}  headers=${header}  expected_status=Anything
    Log	                Answer: @{resp}

    #vyhodnocení status kódu
    Status should be    ${responce_code}

#    Should Be Equal As Strings	    ${resp.status_code}     ${responce_code}

    #vyhodnocení JSONu klíč response
#    Dictionary Should Contain Item	${resp.json()}          response    ${responce_code}

    Should Contain      ${resp.json()}[response]            ${responce_code}