"""

Tento příklad potřebuje robotframework-requests balíček
instalace:
pip install robotframework-requests

CVIČENÍ: Vytvořte klíčové slovo pro testy registrace na kurz z pohledu funkcionality +
                                                          přidejte další testy pro kompletní otestování

Inspirujte se ve cvičení CV17_API_test_komunikace.robot klíčové slovo "API Comunication"
"""


*** Settings ***
Library	        Collections
Library	        RequestsLibrary
Library         String



*** Variables ***
${url}		        http://testovani.kitner.cz/
${app}              /regkurz/formsave.php
${urlapp}           ${url}${app}


*** Test Cases ***

Registrace na kurz fyzicka osoba
    Registrace na kurz    2  Jan787878      Novak            jan.novak@abc.cz  777123123  fyz  Udolni 21, Brno  ${EMPTY}         1  komentar  false  200


Registrace na kurz pravnicka osoba
    Registrace na kurz    2  Jan787878      Novak            jan.novak@abc.cz  777123123  pra  ${EMPTY}  27232433                1  dekuji   false  200

Registrace na kurz háčky a čárky
    Registrace na kurz    2  Janěščřžýáíéů  Novakěščřžýáíéů  jan.novak@abc.cz  777123123  fyz  Udolniěščřžýáíéů, Brno  ${EMPTY}  1  nic      false  200

Registrace na kurz háčky a čárky (prázdné jméno)
    Registrace na kurz    2  ${EMPTY}  Novakěščřžýáíéů  jan.novak@abc.cz  777123123  fyz  Udolniěščřžýáíéů, Brno  ${EMPTY}  1  nic      false  500

*** Keywords ***


Registrace na kurz
    [Arguments]     ${1kurz}   ${1name}   ${1surname}   ${1email}  ${1phone}  ${1person}  ${1address}  ${1ico}  ${1count}  ${1comment}  ${1souhlas}  ${error_resp}

    # vytvoření těla (body) zprávy
    ${json}=     catenate  {"targetid":"","kurz":"${1kurz}","name":"${1name}","surname":"${1surname}","email":"${1email}","phone":"${1phone}","person":"${1person}","address":"${1address}","ico":"${1ico}","count":"${1count}","comment":"${1comment}","souhlas":"${1souhlas}"}

    #převedení do UTF-8
    ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8      #vyžaduje knihovnu String
    log  ${json_utf8}
    #vytoření hlavičky (header) zprávy
    &{header}=          Create Dictionary   Content-Type=application/json

    # odeslání zprávy a uložení odpovědi do ${resp}
    ${resp} =           POST  ${urlapp}  data=${json_utf8}  expected_status=${error_resp}
    Status Should Be    ${error_resp}
    Should Be Equal As Strings     ${error_resp}    ${resp.status_code}

    #vyhodnocení status kódu
    #??? DOPLNIT ???#

    #vyhodnocení JSONu stačí jen vyhodnotit klíč response a jeho hodnotu
    #??? DOPLNIT ???#



