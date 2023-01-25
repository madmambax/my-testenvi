"""
API - HW06   2-1-2023 P.K.
"""

*** Settings ***
Documentation   API-testy
Library         RequestsLibrary
Library         String
Library         Collections
Library         JSONLibrary

*** Variables ***
${url}          http://testovani.kitner.cz/
${app}          regkurz/formsave.php
${urlapp}       ${url}${app}                            #   String - Spojení stringu


*** Test Cases ***
# TESTY - (VŠE OK)
Registrace na kurz - OK
      [Documentation]      Registrace json OK - Test Pozitivní
      API Comunication     1  Petr  Kono  p_kono@moomo.cz  777123321  fyz  nám. Dr. E. Beneše 559/28, Liberec  27232433  1  Test je OK!  true  200

Session - Registrace na kurz - OK
      [Documentation]      Session - Registrace json OK
      API Comunicaication Post on Session     1  Petr  Kono  p_kono@moomo.cz  777123321  fyz  nám. Dr. E. Beneše 559/28, Liberec  27232433  1  Test je OK!  true  200  OK  Test je OK!

# TESTY - (bez volby kurzu)
Registrace chybný json (bez volby kurzu)
    [Documentation]        Registrace json bez volby kurzu - Test Negativní
    API Comunication       ''  Petr  Kono  p_kono@moomo.cz  777123321  fyz  nám. Dr. E. Beneše 559/28, Liberec  27232433  1  ERROR - bez volby kurzu  true  500

Session - chybný json (bez volby kurzu)
    [Documentation]        Session - bez volby kurzu
    API Comunicaication Post on Session     ''  Petr  Kono  p_kono@moomo.cz  777123321  fyz  nám. Dr. E. Beneše 559/28, Liberec  27232433  1  ERROR - bez volby kurzu  true  500  Internal Server Error  RROR - bez volby kurzu

# TESTY - (Položka telefon prázdný)
Registrace chybný json (telefon prázdný)
    [Documentation]        Registrace json bez telefonu (prázdný) - Test Negativní
    API Comunication       2  Petr  Kono  p_kono@moomo.cz  ''  fyz  nám. Dr. E. Beneše 559/28, Liberec  27232433  1  ERROR - neni zadán telefon  true  500

Session chybný json (telefon prázdný)
    [Documentation]        Session json bez telefonu
    API Comunicaication Post on Session       2  Petr  Kono  p_kono@moomo.cz  ''  fyz  nám. Dr. E. Beneše 559/28, Liberec  27232433  1  ERROR - neni zadán telefon  true  500  Internal Server Error  ERROR - neni zadán telefon

# TESTY - (TELEFON - moc dlouhý)
Registrace chybný (telefon - moc dlouhý)
    [Documentation]        Registrace json bez telefonu (moc dlouhý) - Test Negativní
    API Comunication       3  Petr  Kono  p_kono@moomo.cz  777123321432196  fyz  nám. Dr. E. Beneše 559/28, Liberec  27232433  1  ERROR - Moc dlouhý telefon  true  500

Session chybný (telefon - moc dlouhý)
    [Documentation]        Session json bez telefonu -(moc dlouhý)
    API Comunicaication Post on Session       3  Petr  Kono  p_kono@moomo.cz  777123321432196  fyz  nám. Dr. E. Beneše 559/28, Liberec  27232433  1  ERROR - Moc dlouhý telefon  true  500  Internal Server Error  ERROR - Moc dlouhý telefon

# TESTY - (EMAIL - neplatný email)
Registrace chybný json (neplatný email)
    [Documentation]        Registrace - neplatný email (p_kono-moomo.cz) - Test Negativní
    API Comunication       2  Petr  Kono  p_kono-moomo.cz  777123321  fyz  nám. Dr. E. Beneše 559/28, Liberec  27232433  1  chybny formát email  true  500

Session chybný json (neplatný email)
    [Documentation]        Session - neplatný email (p_kono-moomo.cz)
    API Comunicaication Post on Session       2  Petr  Kono  p_kono-moomo.cz  777123321  fyz  nám. Dr. E. Beneše 559/28, Liberec  27232433  1  ERROR - chybny formát email  true  500  Internal Server Error  ERROR - chybny formát email


# TESTY - (KURZ - volby kurzu s písmenem)
Registrace chybný json (volby kurzu s písmenem)
    [Documentation]        Registrace - hybný json (volby kurzu s písmenem) - Test Negativní
    API Comunication       a  Petr  Kono  p_kono@moomo.cz  777123321  fyz  nám. Dr. E. Beneše 559/28, Liberec  27232433  1  ERROR - volby kurzu s písmenem  true  500

Session chybný json (volby kurzu s písmenem)
    [Documentation]        Session - hybný json (volby kurzu s písmenem)
    API Comunicaication Post on Session       a  Petr  Kono  p_kono@moomo.cz  777123321  fyz  nám. Dr. E. Beneše 559/28, Liberec  27232433  1  ERROR - volby kurzu s písmenem  true  500  Internal Server Error  ERROR - volby kurzu s písmenem

#-----------------------------------------------------------------------------------------------------------------------

# API2 - TEST - VŠE OK
Registrace ok
    [Documentation]     API2-Registrace json OK - Test Pozitivní
    API Comunication 2  {"targetid":"","kurz":"1","name":"Petr","surname":"Kono","email":"p_kono@moomo.cz","phone":"777123321","person":"fyz","address":"nám. Dr. E. Beneše 559/28, Liberec","ico":"27232433","count":"1","comment":"VŠE OK","souhlas":true}  200

# API2 - TEST - Bez volby kurzu
Registrace chybný json - Bez volby kurzu
    [Documentation]     API2-Registrace json bez volby kurzu - Test Negativní
    API Comunication 2  {"targetid":"","kurz":"","name":"Petr","surname":"Kono","email":"p_kono@moomo.cz","phone":"777123321","person":"fyz","address":"nám. Dr. E. Beneše 559/28, Liberec","ico":"27232433","count":"1","comment":"bez volby kurzu","souhlas":true}  500

# API2 - TEST - Položka telefon prázdný
API2 - Registrace chybný json - Položka telefon prázdný
    [Documentation]     API2-Registrace json - Položka telefon prázdný - Test Negativní
    API Comunication 2  {"targetid":"","kurz":"1","name":"Petr","surname":"Kono","email":"p_kono@moomo.cz","phone":"","person":"fyz","address":"nám. Dr. E. Beneše 559/28, Liberec","ico":"27232433","count":"1","comment":"bez telefonu","souhlas":true}   500

# API2 - TEST - Položka telefon moc dlouhý
API2 - Registrace chybný json Položka telefon moc dlouhý
    [Documentation]     API2-Registrace json - Položka telefon moc dlouhý - Test Negativní
    API Comunication 2  {"targetid":"","kurz":"1","name":"Petr","surname":"Kono","email":"p_kono@moomo.cz","phone":"603123456987656654","person":"fyz","address":"nám. Dr. E. Beneše 559/28, Liberec","ico":"27232433","count":"1","comment":"telefon moc dlouhý","souhlas":true}   500

# API2 - TEST - Položka telefon je text
API2 - Registrace chybný json - Položka telefon je text
    [Documentation]     API2-Registrace json - Položka telefonu Text - Test Negativní
    API Comunication 2  {"targetid":"","kurz":"1","name":"Petr","surname":"Kono","email":"p_kono@moomo.cz","phone":"abcdefgASLDOPO","person":"fyz","address":"nám. Dr. E. Beneše 559/28, Liberec","ico":"27232433","count":"1","comment":"Položka telefonu Text","souhlas":true}   500

# TEST - EMAIL - Neplatný email
API2 - Registrace chybný json poz.email (neplatný email)
    [Documentation]     API2-Registrace - Neplatný email (p_kono-moomo.cz) - Test Negativní
    API Comunication 2   {"targetid":"","kurz":"1","name":"Petr","surname":"Kono","email":"p_kono-moomo.cz","phone":"777123321","person":"fyz","address":"nám. Dr. E. Beneše 559/28, Liberec","ico":"27232433","count":"1","comment":"neplatný email","souhlas":true}   500

# TEST - Volba kurzu s písmenem
Registrace chybný json (volby kurzu s písmenem)
    [Documentation]      API2-Registrace - Volba kurzu s písmenem - Test Negativní
    API Comunication 2   {"targetid":"","kurz":"a","name":"Petr","surname":"Kono","email":"p_kono@moomo.cz","phone":"777123321","person":"fyz","address":"nám. Dr. E. Beneše 559/28, Liberec","ico":"27232433","count":"1","comment":"volby kurzu s písmenem","souhlas":true}  500

# TEST - Email není ukončen uvozovkou
Registrace chybný json - Email není ukončen uvozovkou
    [Documentation]      API2-Registrace - Email není ukončen uvozovkou - Test Negativní
    API Comunication 2   {"targetid":"","kurz":"1","name":"Petr","surname":"Kono","email":"p_kono@moomo.cz,"phone":"777123321","person":"fyz","address":"nám. Dr. E. Beneše 559/28, Liberec","ico":"27232433","count":"1","comment":"Email není ukončen uvozovkou","souhlas":true}  500


*** Keywords ***

API Comunication
    [Arguments]         ${kurz}  ${name}  ${surname}  ${email}  ${phone}  ${person}  ${address}  ${ico}  ${count}  ${comment}  ${souhlas}  ${response_code}
#   JSON se dá používat také jako řetězec: - využít knihovnu Collections

    ${json}=     Catenate    {
    ...     "targetid":"",
    ...     "kurz":"${kurz}",
    ...     "name":"${name}",
    ...     "surname":"${surname}",
    ...     "email":"${email}",
    ...     "phone":"${phone}",
    ...     "person":"${person}",
    ...     "address":"${address}",
    ...     "ico":"${ico}",
    ...     "count":"${count}",
    ...     "comment":"${comment}",
    ...     "souhlas":${souhlas}}

    ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8
    ${response} =      POST  ${urlapp}   data=${json_utf8}   expected_status=${response_code}
    Log	               Responce: @{response}
    Status Should Be    ${response_code}


API Comunicaication Post on Session
    [Arguments]         ${kurz}  ${name}  ${surname}  ${email}  ${phone}  ${person}  ${address}  ${ico}  ${count}  ${comment}  ${souhlas}  ${response_code}   ${reason_res}  ${error_comment}
#   JSON se dá používat také jako řetězec: - využít knihovnu Collections

    ${json}=     Catenate    {
    ...     "targetid":"",
    ...     "kurz":"${kurz}",
    ...     "name":"${name}",
    ...     "surname":"${surname}",
    ...     "email":"${email}",
    ...     "phone":"${phone}",
    ...     "person":"${person}",
    ...     "address":"${address}",
    ...     "ico":"${ico}",
    ...     "count":"${count}",
    ...     "comment":"${comment}",
    ...     "souhlas":${souhlas}}

    ${json_utf8}        Encode String To Bytes     ${json}     UTF-8
    CreateSession       apilogin            ${url}
    &{header}=          Create Dictionary   Content-Type=application/json     charset=utf-8
    ${response}=        Post on Session   apilogin  ${app}   data=${json_utf8}   headers=${header}   expected_status=Anything

    Status Should Be                               ${response_code}
    Should Be Equal As Strings   ${reason_res}     ${response.reason}


    Log to Console      reason:                    ${response.reason}${\n}
    Log to Console      Chybně zadaná položka:     ${error_comment}



API Comunication 2
    [Arguments]                   ${json}          ${response_code}
    ${json}=            Catenate  ${json}
    ${json}=            Encode String To Bytes     ${json}     UTF-8
    ${response}=        POST  ${urlapp}  data=${json}   expected_status=${response_code}

    Log to console                 ${\n}1: ${response.json}${\n}
    Log to console                      2: ${response.text}${\n}
    Log To Console                      3: ${response}${\n}
    Log to console                REASON: "${response.reason}"${\n}
    Log to console               CONTENT: "${response.content}"${\n}
    Log to Console               HEADERS: "${response.headers}"${\n}
    Should Be Equal As Strings             ${response.json()}[response]         ${response_code}
    Should Be Equal As Integers            ${response.status_code}              ${response_code}

