*** Settings ***
Documentation   Automatizace Google s BrowserLibrary
Library  Browser


*** Test Cases ***

Vyhledavani na googlu
    Otevri stranku  https://www.google.cz
"""

Tento příklad potřebuje robotframework-requests balíček
instalace:
pip install robotframework-requests

CVIČENÍ: Vytvořte klíčové slovo pro testy registrace na kurz z pohledu funkcionality +
                                                          přidejte další testy pro kompletní otestování

Inspirujte se ve cvičení CV64_API_test_komunikace.robot klíčové slovo "API Comunication"
"""


*** Settings ***
Library            Collections
Library            RequestsLibrary
Library         String

*** Variables ***
${url}                http://testovani.kitner.cz/
${app}                regkurz/formsave.php
${urlapp}             ${url}${app}
${format_phone}       Enter in format: +420xxxxxxxxx


*** Test Cases ***

registration ok
    API Comunication   1  Nunca  Nunca  nunca@nada.cz  777777777  fyz  Brno  null  1  bla  true   200

registration phone cuountry ok
    API Comunication   1  Nunca  Nada  nunca@nada.cz  +420777777777  fyz  Brno  null  1  bla  true  200

registration phone no incorrect format
    API Comunication   1  Nunca  Nunca  nunca@nada.cz  nikdy  fyz  Brno  null  1  bla  true  500
    Log To Console    ${format_phone}
registration prefix phone invalid format
    API Comunication  1  Nunca  Nunca  nunca@nada.cz  +410 777777777  fyz  Brno  null  1  bla  true  500
    Log To Console    ${format_phone}
registration phone no too long
    API Comunication    1  Nunca  Nunca  nunca@nada.cz  +420 7777777778888888888888888888888  fyz  Brno  null  1  bla  true  500
    Log To Console     ${format_phone}
registration invalid email
    API Comunication   1  Nunca  Nada  nunc@  +420777777777  fyz  Brno  null  1  bla  true  500
registration surname too short
    API Comunication    1  Nunca  Nu  nunca@nada.cz  +420 777777777  fyz  Brno  null  1  bla  true  500
    Log To Console    OK, length is not limited.

*** Keywords ***

API Comunication
    [Arguments]     ${course}  ${name}  ${surname}  ${email}  ${phone}  ${person}  ${address}  ${ico}  ${count}  ${comment}  ${agreement}  ${responce_number}

    # vytvoření těla (body) zprávy
    ${json}=      Catenate      {"targetid":"","kurz":"${course}","name":"${name}","surname":"${surname}","email":"${email}","phone":"${phone}","person":"${person}","address":"${address}","ico":"${ico}","count":"${count}","comment":"${comment}","souhlas":${agreement}}

    #převedení do UTF-8
    ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8      #vyžaduje knihovnu String

    #vytoření hlavičky (header) zprávy
    &{header}=          Create Dictionary   Content-Type=application/json

    # odeslání zprávy a uložení odpovědi do ${resp}
    ${resp} =           POST  ${urlapp}   data=${json_utf8}  headers=${header}  expected_status=Anything
    Log                    Responce: @{resp}

    #vyhodnocení status kódu
    Status should be    ${responce_number}

    #vyhodnocení JSONu stačí jen vyhodnotit klíč response a jeho hodnotu
    Should Contain      ${resp.json()}[response]            ${responce_number}


