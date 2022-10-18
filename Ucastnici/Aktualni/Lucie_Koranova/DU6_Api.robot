*** Settings ***

Documentation   Test - API
Library         RequestsLibrary
Library         String

*** Variables ***

${url}      http://testovani.kitner.cz/
${app}      regkurz/formsave.php
${urlapp}   ${url}${app}

*** Test Cases ***

Registration OK
    Registration  1  Jitka  Novakova  jitka.novakova@abc.cz  777123456  fyz  Kladno  3  nic  true  200

Registration with wrong email
    Registration    2  Jitka  Novakova  jitka.cz  777123456  fyz  Nova 123, Kladno  3  nic  true  500

*** Keywords ***


Registration
    [Arguments]    ${course}  ${name}  ${surname}  ${email}  ${phone}  ${person}  ${address_ico}  ${count}  ${comment}  ${agree}  ${response_code}

    # vytvoření těla (body) zprávy
    ${json}=     Catenate      {
    ...     "targetid":"",
    ...     "kurz":"${course}",
    ...     "name":"${name}",
    ...     "surname":"${surname}",
    ...     "email":"${email}",
    ...     "phone":"${phone}",
    ...     "person":"${person}",
    ...     "address":"${address_ico}",
    ...     "ico":"${address_ico}",
    ...     "count":"${count}",
    ...     "comment":"${comment}",
    ...     "souhlas":${agree}}


    ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8

    ${resp} =           POST  ${urlapp}   data=${json_utf8}   expected_status=${response_code}
    Log	                Responce: @{resp}