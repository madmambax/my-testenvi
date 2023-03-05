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
#Resource        Projekt/TestData.robot

*** Variables ***
${url}		        http://testovani.kitner.cz/
${app}              /regkurz/formsave.php
${urlapp}           ${url}${app}

*** Test Cases ***

Registrace na kurz fyzicka osoba
    Registrace na kurz  2  Jan787878  Novak  jan.novak@abc.cz  777123123  fyz  Udolni 21, Brno  1  komentar  false  200

Registrace na kurz pravnicka osoba
    Registrace na kurz  2  Jan787878  Novak  jan.novak@abc.cz  777123123  pra  27232433  1  dekuji  false  200

Registrace na kurz háčky a čárky
    Registrace na kurz  2  Janěščřžýáíéů  Novakěščřžýáíéů  jan.novak@abc.cz  777123123  fyz  Udolniěščřžýáíéů, Brno  1  nic  false  200

Registrace na kurz specialni znaky
    Registrace na kurz  2  J@#?_"!(%ˇ'něščřžýáíéů  Nov?_"!(%ˇ'kěščřžýáíéů  j@n.no?:_"!(%ˇ'vak@abc.cz  777123123  fyz  Udolniěš?:_"!(%ˇ'čřžýáíéů, B?:_"!(%ˇ'rno  1  nic  false  400

Registrace na kurz chybny format json
    Registrace na kurz  null  Janěščřžýáíéů  Novakěščřžýáíéů  jan.novak@abc.cz  7 77123123  fyz  Udolniěščřžýáíéů, Brno  1  nic  false  500


*** Keywords ***

Registrace na kurz
    [Arguments]     ${course}  ${name}  ${surname}  ${email}  ${phone}  ${person}  ${address_ico}  ${count}  ${comment}  ${souhlas}  ${responce_number}

    # vytvoření těla (body) zprávy
    ${json}=      Catenate      {"targetid":"","kurz":"${course}","name":"${name}","surname":"${surname}","email":"${email}","phone":"${phone}","person":"${person}","address":"${address_ico}","ico":"${address_ico}","count":"${count}","comment":"${comment}","souhlas":${souhlas}}

    #převedení do UTF-8
    ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8      #vyžaduje knihovnu String

    #vytoření hlavičky (header) zprávy
    &{header}=          Create Dictionary   Content-Type=application/json

    # odeslání zprávy a uložení odpovědi do ${resp}
    ${resp} =           POST  ${urlapp}   data=${json_utf8}  headers=${header}  expected_status=Anything
    Log	                Responce: @{resp}

    #vyhodnocení status kódu
    Status should be    ${responce_number}

    #vyhodnocení JSONu stačí jen vyhodnotit klíč response a jeho hodnotu
    Should Contain      ${resp.json()}[response]            ${responce_number}



