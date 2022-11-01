*** Settings ***

Documentation   Test - API
Library         RequestsLibrary
Library         String

*** Variables ***

${url}      http://testovani.kitner.cz/
${app}      regkurz/formsave.php
${urlapp}   ${url}${app}

*** Test Cases ***

Registration FO
    Registration  1  Jitka  Novakova  jitka.novakova@abc.cz  777123456  fyz  Kladno  3  nic  true  200

Registration with wrong email
    Registration    2  Jitka  Novakova  jitka.cz  777123456  fyz  Nova 123, Kladno  3  nic  true  500

Registration PO
     Registration    3  Jitka  Novakova  jitka.novakova@abc.cz  777123456  pra  25596641  3  nic  true  200


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

     #převedení do UTF-8
    ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8      #vyžaduje knihovnu String

    #vytoření hlavičky (header) zprávy
    &{header}=          Create Dictionary   Content-Type=application/json

    # odeslání zprávy a uložení odpovědi do ${resp}
    ${resp} =           POST  ${urlapp}   data=${json_utf8}  headers=${header}  expected_status=${response_code}
    Log	                Responce: @{resp}

    #vyhodnocení status kódu
    Status Should Be    ${response_code}

    #vyhodnocení JSONu stačí jen vyhodnotit klíč response a jeho hodnotu
    Should Contain    ${resp.json()}[response]    ${response_code}