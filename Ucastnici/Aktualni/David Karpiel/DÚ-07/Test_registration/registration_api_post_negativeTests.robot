*** Settings ***
Library	        Collections
Library	        RequestsLibrary
Library         String

Resource    ../Data_and_Lib/validations.robot
Resource    ../Data_and_Lib/import_jsonSchema.resource

# robot '.\Ucastnici\Aktualni\David Karpiel\DÚ-07\Test_registration\registration_api_post_negativeTests.robot'

*** Variables ***
${url}		        http://testovani.kitner.cz
${app}              /regkurz/formsave.php
${urlapp}           ${url}${app}


*** Test Cases ***

Verify registration with empty name (natural person)
        Registrace na kurz                              2         ${EMPTY}     Novak          jan.novak@abc.cz       777123123    fyz        Udolni 21, Brno          1         komentar      false          500
Verify registration with empty name (legal person)
        Registrace na kurz                              2         ${EMPTY}     Novak          jan.novak@abc.cz       777123123    pra        27232433                 1         dekuji        false          500
Registration without choosing a course (natural person)
        Registrace na kurz                              ${EMPTY}  Honza        Novak          jan.novak@abc.cz       777123123    fyz         27232433                1         dekuji        false          500
Telephone dialing registration empty (natural person)
        Registrace na kurz                              2         Honza        Novak          jan.novak@abc.cz       ${EMPTY}     fyz         27232433                1         dekuji        false          500
Registration with long name (natural person)
        Registrace na kurz                              2         fasdfadfaffffffffffffffffffffffffffffaadfadfadfadfadffdfdafadfadfadfdafadfadfadfadfdfadfadfadfadfadfadfadfadfadfadfadfadfdajj        Novak          jan.novak@abc.cz       777123123     pra        27232433                 1         dekuji        false          500
Registration with long surname (natural person)
        Registrace na kurz                              2         Jan787878    fasdfadfaffffffffffffffffffffffffffffaadfadfadfadfadffdfdafadfadfadfdafadfadfadfadfdfadfadfadfadfadfadfadfadfadfadfadfadfdajj          jan.novak@abc.cz        777123123    fyz        Udolni 21, Brno          1         komentar      false          500
Negative phone number (natural person)
        Registrace na kurz                              2         Jan787878       Novak       jan.novak@abc.cz      -1           fyz        Udolni 21, Brno           1         komentar      false           500
Negative number in count field (natural person)
        Registrace na kurz                              2         Jan787878       Novak       jan.novak@abc.cz      777123123    fyz        Udolni 21, Brno           -1        komentar      false           500
Count field empty (natural person)
        Registrace na kurz                              2         Jan787878       Novak       jan.novak@abc.cz      777123123    fyz        Udolni 21, Brno           ${EMPTY}   komentar      false          500
Long number in count field (natural person)
        Registrace na kurz                              2         Jan787878       Novak       jan.novak@abc.cz      777123123    fyz        Udolni 21, Brno          123456781111111          komentar      false          500
Long string in the comment field (natural person)
        Registrace na kurz                              2         Jan787878       Novak       jan.novak@abc.cz      777123123    fyz        Udolni 21, Brno          1           xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx      false          500
Long string in the adress field (natural person)
        Registrace na kurz                              2         Jan787878       Novak       jan.novak@abc.cz      777123123    fyz        xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx          1           komentar      false          500
Long string in the email field (natural person)
        Registrace na kurz                              2         Jan787878       Novak       jan.novaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaak@abc.cz     777123123    fyz        Udolni 21, Brno          1           komentar      false          500
All field blank (natural person)
        Registrace na kurz                              ${EMPTY}    ${EMPTY}     ${EMPTY}     ${EMPTY}             ${EMPTY}     ${EMPTY}    ${EMPTY}           ${EMPTY}            ${EMPTY}       ${EMPTY}           500
Empty surname field (natural person)
        Registrace na kurz                              2         Jan787878      ${EMPTY}     jan.novak@abc.cz      777123123    fyz        Udolni 21, Brno          1           komentar      false          500
Empty email field (natural person)
        Registrace na kurz                              2         Jan787878       Novak       ${EMPTY}              777123123    fyz        Udolni 21, Brno          1           komentar      false          500
Email without "@" (natural person)
        Registrace na kurz                              2         Jan787878       Novak       jan.novakabc.cz       777123123    fyz        Udolni 21, Brno          1           komentar      false          500
Incorrectly entered email_01 (natural person)
        Registrace na kurz                              2         Jan787878       Novak       @abc.cz               777123123    fyz        Udolni 21, Brno          1           komentar      false          500
Incorrectly entered email_02 (natural person)
        Registrace na kurz                              2         Jan787878       Novak       jan.novak@.cz         777123123    fyz        Udolni 21, Brno          1           komentar      false          500
Incorrectly entered email_03 (natural person)
        Registrace na kurz                              2         Jan787878       Novak       jan.novak@.           777123123    fyz        Udolni 21, Brno          1           komentar      false          500
Incorrectly entered email_04 (natural person)
        Registrace na kurz                              2         Jan787878       Novak       jan.novak@com         777123123    fyz        Udolni 21, Brno          1           komentar      false          500
Incorrectly entered email_05 (natural pesrson)
        Registrace na kurz                              2         Jan787878       Novak       jan.novak@.com        777123123    fyz        Udolni 21, Brno          1           komentar      false          500
Adress fields with number only (natural person)
        Registrace na kurz                              2         Jan787878       Novak       jan.novak@abc.cz      777123123    fyz        555555555                1           komentar      false          500
Incorrect phone number (natural person)
        Registrace na kurz                              2         Jan787878       Novak       jan.novak@abc.cz      60812312     fyz        Udolni 21, Brno          1           komentar      false          500
Phone number field filled with letters (natural person)
        Registrace na kurz                              2         Jan787878       Novak       jan.novak@abc.cz      aaabbbccc    fyz        Udolni 21, Brno          1           komentar      false          500
Registration without choosing a course (legal person)
        Registrace na kurz                              ${EMPTY}   Honza          Novak       jan.novak@abc.cz      777123123    fyz         27232433                1           dekuji        false          500
Negative number in ICO field (legal person)
        Registrace na kurz                              2         Jan787878       Novak       jan.novak@abc.cz      777123123     pra        -1                       1           komentar      false          500
One number in ICO field (legal person)
        Registrace na kurz                              2         Jan787878       Novak       jan.novak@abc.cz      777123123     pra         1                       1           komentar      false          500
ICO field empty (legal person)
        Registrace na kurz                              2         Jan787878       Novak       jan.novak@abc.cz      777123123     pra         ${EMPTY}                1           komentar      false          500
Registration with long ICO number (legal person)
       Registrace na kurz                               2         Jan787878       Novak       jan.novak@abc.cz      777123123     pra         497133611               1           komentar      false          500

*** Keywords ***
Registrace na kurz
    [Arguments]    ${course}  ${name}    ${surname}    ${e-mail}    ${telephone_number}    ${person}    ${ico_adress}    ${count}    ${comment}    ${agreement}    ${expected_status}
    Log To Console    \nSending Request To ${urlapp}\n
    # vytvoření těla (body) zprávy
    ${jsonBody}      Catenate    {"targetid":"","kurz":"${course}","name":"${name}","surname":"${surname}","email":"${e-mail}","phone":"${telephone_number}","person":"${person}","address":"${ico_adress}","ico":"${ico_adress}","count":"${count}","comment":"${comment}","souhlas":${agreement}}
    ${json_utf8}     Encode String To Bytes     ${jsonBody}     UTF-8      #vyžaduje knihovnu String
    &{header}        Create Dictionary   Content-Type=application/json    #vytoření hlavičky (header) zprávy
    # odeslání zprávy a uložení odpovědi do ${resp}
    ${resp}  POST   url=${urlapp}  data=${json_utf8}  headers=${header}  expected_status=500
    Log	                Responce: @{resp}
    Status Should Be    ${expected_status}  #vyhodnocení status kódu
    Should Contain      ${resp.json()}[response]     ${expected_status}  #vyhodnocení JSONu stačí jen vyhodnotit klíč response a jeho hodnotu
    Validate Schema     input_Json=${resp.json()}   reference_Schema_Path=${GLOBAL_SCHEMA_ERROR_REGISTRATION_POST}   #json schema - ověření