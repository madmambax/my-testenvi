*** Settings ***
Library	        Collections
Library	        RequestsLibrary
Library         String

Resource    ../Data_and_Lib/validations.robot
Resource    ../Data_and_Lib/import_jsonSchema.resource

# robot '.\Ucastnici\Aktualni\David Karpiel\DÚ-07\Test_registration\registration_api_post_pozitiveTests.robot'

*** Variables ***
${url}		        http://testovani.kitner.cz/
${app}              /regkurz/formsave.php
${urlapp}           ${url}${app}


*** Test Cases ***

Registration ok (natural person)
        Registrace na kurz                      2         Jan787878       Novak              jan.novak@abc.cz      777123123       fyz        Udolni 21, Brno          1         komentar      false         200
Registration ok (legal person)
        Registrace na kurz                      2         Jan787878       Novak              jan.novak@abc.cz      777123123       pra        27232433                 1         dekuji        false          200
Registration ok punctuation (natural person)
        Registrace na kurz                      2         Janěščřžýáíéů   Novakěščřžýáíéů    jan.novak@abc.cz      777123123       fyz       Udolniěščřžýáíéů, Brno    1         nic           false          200
Registration OK with consent (legal person)
        Registrace na kurz                      2         Jan787878       Novak              jan.novak@abc.cz      777123123        pra        27232433                1         dekuji        true           200
Registration OK with consent (natural person)
        Registrace na kurz                      2         Jan787878       Novak              jan.novak@abc.cz      777123123        fyz         27232433               1         dekuji        true           200
Telephone OK with preselection (natural person)
        Registrace na kurz                      2         Jan787878       Novak              jan.novak@abc.cz      +420608123123    fyz        Udolni 21, Brno         1         komentar      false          200
Registration OK kurz_1 (natural person)
        Registrace na kurz                      1         Jan787878       Novak              jan.novak@abc.cz      +420608123123    fyz        Udolni 21, Brno         1         komentar      false          200
Registration OK kurz _3 (natural person)
        Registrace na kurz                      3         Jan787878       Novak              jan.novak@abc.cz      +420608123123    fyz        Udolni 21, Brno         1         komentar      false          200
Registration ok kurz_1 (legal person)
        Registrace na kurz                      1         Jan787878       Novak              jan.novak@abc.cz      777123123       pra        27232433                 1         dekuji        false          200
Registration ok kurz_3 (legal person)
        Registrace na kurz                      3         Jan787878       Novak              jan.novak@abc.cz      777123123       pra        27232433                 1         dekuji        false          200

*** Keywords ***
Registrace na kurz
    [Arguments]    ${course}  ${name}    ${surname}    ${e-mail}    ${telephone_number}    ${person}    ${ico_adress}    ${count}    ${comment}    ${agreement}    ${expected_status}
    Log To Console    \nSending Request To ${urlapp}\n
    # vytvoření těla (body) zprávy
    ${jsonBody}      Catenate    {"targetid":"","kurz":"${course}","name":"${name}","surname":"${surname}","email":"${e-mail}","phone":"${telephone_number}","person":"${person}","address":"${ico_adress}","ico":"${ico_adress}","count":"${count}","comment":"${comment}","souhlas":${agreement}}
    ${json_utf8}     Encode String To Bytes     ${jsonBody}     UTF-8      #vyžaduje knihovnu String
    &{header}        Create Dictionary   Content-Type=application/json    #vytoření hlavičky (header) zprávy
    # odeslání zprávy a uložení odpovědi do ${resp}
    ${resp}  POST   url=${urlapp}  data=${json_utf8}  headers=${header}  expected_status=200
    Log	                Responce: @{resp}
    #Status Should Be    ${expected_status}    #vyhodnocení status kódu
    Should Contain      ${resp.json()}[response]     ${expected_status}    #vyhodnocení JSONu stačí jen vyhodnotit klíč response a jeho hodnotu
    Validate Schema    input_Json=${resp.json()}   reference_Schema_Path=${GLOBAL_SCHEMA_REGISTRATION_POST}    #json schema - ověření