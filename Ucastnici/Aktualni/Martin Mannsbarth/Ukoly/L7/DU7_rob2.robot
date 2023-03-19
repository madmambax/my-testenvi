*** Settings ***

Library    RequestsLibrary
Library    String
Library    Collections
Library    JSONLibrary


*** Variables ***
${url}                http://testovani.kitner.cz/
${app}                regkurz/formsave.php
${urlapp}             ${url}${app}


*** Test Cases ***

registration ok
     ${json_data}=  Registration json   2  Jauz  No1ltzroí  jajntr.nopo2vak@abc.cz  +420707486789  fyz   Brno   1   null  true
     Log                    ${json_data}
     Course registration    ${json_data}    200

registration phone cuountry ok
     ${json_data}=  Registration json   2  Jaudz  Nolt  jajntr.nopo9vak@abc.cz  +420707486789  fyz  Praha   5   null  true
     Log                    ${json_data}
     Course registration    ${json_data}    200

registration empty course
    ${json_data}=   Registration json    ${EMPTY}  Jan  Wolf  jajntr.nopo9vak@abc.cz  +420707486789  fyz  Praha   5   null  true
    Log              ${json_data}
    Course registration    ${json_data}    500

registration empty phone field
    ${json_data}=    Registration json    2  Jaudz  Nolt  jajntr.nopo9vak@abc.cz  ${EMPTY}  fyz  Praha   5   null  true
    Log              ${json_data}
    Course registration    ${json_data}    500

registration empty email
    ${json_data}=    Registration json    2  Jaudz  Nolt  ${EMPTY}  +420707486789  pra  62560131   5   null  true
    Log              ${json_data}
    Course registration    ${json_data}    500

*** Keywords ***

Course registration
     [Arguments]     ${json_data}     ${error_resp}

     ${json_utf8} =     Encode String To Bytes     ${json_data}     UTF-8
     &{header} =        Create Dictionary     Content-Type=application/json
     ${resp} =          POST     ${urlapp}     data=${json_utf8}     expected_status=${error_resp}
     Log	            Response: @{resp}
     Log                ${resp.json()}
     Status Should Be   ${error_resp}


Registration json
     [Arguments]     ${kurz}     ${jmeno}     ${prijmeni}      ${email}     ${telefon}     ${osoba}     ${adresa_ico}     ${pocet_osob}     ${komentar}     ${souhlas}

     &{data} =       Create Dictionary     targetid=""     kurz=${kurz}     name=${jmeno}     surname=${prijmeni}     email=${email}     phone=${telefon}     person=${osoba}     address=${adresa_ico}     ico=${adresa_ico}     count=${pocet_osob}     comment=${komentar}     souhlas=${souhlas}}
     ${json_data} =  Convert Json To String    ${data}
     Log             ${json_data}
     [return]        ${json_data}