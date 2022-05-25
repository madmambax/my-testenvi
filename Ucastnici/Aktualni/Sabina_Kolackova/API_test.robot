
*** Settings ***
Library	        Collections
Library	        RequestsLibrary
Library         String
Resource        TestData.robot


*** Variables ***
${url}		        http://testovani.kitner.cz/
${app}              /regkurz/formsave.php
${urlapp}           ${url}${app}


*** Test Cases ***

Registrace na kurz
    Registrace na kurz  2  Jan787878  Novak  jan.novak@abc.cz  777123123  fyz  Udolni 21, Brno  true  200

Registrace na kurz- kurz 1
    Registrace na kurz  1  Jan787878  Novak  jan.novak@abc.cz  777123123  fyz  Udolni 21, Brno  true  200

Registrace na kurz háčky a čárky
    Registrace na kurz  2  Janěščřžýáíéů  Novakěščřžýáíéů  jan.novak@abc.cz  777123123  fyz  Udolniěščřžýáíéů, Brno  false  200

Registrace na kurz negativni test
    Registrace na kurz  2  Jan  Novak    chybna_emailova_adresa  777123123  fyz  Udolni, Brno  false  500

Registrace na kurz negativni test-spatny telefon
    Registrace na kurz  2  Jan  Novak  neco@neco.cz  111222333444  fyz  Udolni, Brno  false  500

Registrace na kurz- slovenska predvolba
    Registrace na kurz  2  Jan787878  Novak  jan.novak@abc.cz  +421777123123  fyz  Udolni 21, Brno  false  200

Registrace na kurz- spatny email
    Registrace na kurz  2  Jan787878  Novak  @.  777123123  fyz  Udolni 21, Brno  false  500

Registrace na kurz - dlouhé jméno
    Registrace na kurz  2  JanAaaaaaaaaaAAAAAAAAAAbbbbbbbbbbBBBBBBBBBBccccccccccCCCCCCCCCCddddddddddDDDDDDDDDDeeeeeeeeeeEEEEEEEEEEAaaaaaaaaaAAAAAAAAAAbbbbbbbbbbBBBBBBBBBBccccccccccCCCCCCCCCCddddddddddDDDDDDDDDDeeeeeeeeeeEEEEEEEEEE    Novak  jan.novak@abc.cz  777123123  fyz  Udolni 21, Brno  true  200

*** Keywords ***


Registrace na kurz
    [Arguments]     ${kurz}     ${name}     ${surname}      ${email}        ${phone}        ${person}        ${address}    ${souhlas}        ${error_resp}

    ${json}=   Catenate   {"targetid":"","kurz":"${kurz}","name":"${name}","surname":"${surname}","email":"${email}","phone":"${phone}","person":"${person}","address":"${address}","ico":"234563234","count":"1","comment":null, "souhlas":${souhlas}}      # ,"ico":"${ico}","count":"${count}","comment":null,"souhlas":true

    ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8

    &{header}=          Create Dictionary   Content-Type=application/json

    # odeslání zprávy a uložení odpovědi do ${resp}
    ${resp} =           POST   ${urlapp}    data=${json_utf8}    headers=${header}    expected_status=anything
    Log	                Responce: @{resp}

    Status Should Be           ${error_resp}

    Log To Console                  ${resp.json()}[response]

    Should Be Equal         ${resp.json()}[response]        ${error_resp}




