"""

Tento příklad potřebuje robotframework-requests balíček
instalace:
pip install robotframework-requests

CVIČENÍ: Vytvořte klíčové slovo pro testy registrace na kurz z pohledu funkcionality +
                                                          přidejte další testy pro kompletní otestování

Inspirujte se ve cvičení CV64_API_test_komunikace.robot klíčové slovo "API Comunication"
"""


*** Settings ***
Library	        Collections
Library	        RequestsLibrary
Library         String
Resource        Data_and_Config/TestData.robot


*** Variables ***
${url}		        http://testovani.kitner.cz/
${app}              /regkurz/formsave.php
${urlapp}           ${url}${app}


*** Test Cases ***

Registrace na kurz fyzicka osoba
    Registrace na kurz  2  Jan787878  Novak  jan.novak@abc.cz  777123123  fyz  Udolni 21, Brno  empty  1   komentar  false  200

Registrace na kurz pravnicka osoba
    Registrace na kurz  2  Jan787878  Novak  jan.novak@abc.cz  777123123  pra empty 27232433  1  dekuji  false  200

Registrace na kurz háčky a čárky
    Registrace na kurz  2  Janěščřžýáíéů  Novakěščřžýáíéů  jan.novak@abc.cz  777123123  fyz  Udolniěščřžýáíéů, Brno  empty  1  nic  false  200

*** Keywords ***


Registrace na kurz
    [Arguments]    ${kurz}   ${name}  ${surname}   ${email}   ${phone}  ${person}  ${address}  ${ico}   ${count}   ${comment}   ${souhlas}   ${error_resp}

    # vytvoření těla (body) zprávy
    ${json}=  catenate  targetid  kurz ${kurz} name ${name}  email ${email} phone ${phone}  person ${person} address ${address_ico} ico ${address_ico} count ${count} comment ${comment} souhlas ${souhlas}  ${error_resp}

    #převedení do UTF-8
    ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8      #vyžaduje knihovnu String

    #vytoření hlavičky (header) zprávy
    &{header}=          Create Dictionary   Content-Type=application/json

    # odeslání zprávy a uložení odpovědi do ${resp}
    ${resp} =           POST  ${urlapp}  headers=${header}  expected_status=Anything
    Log	                Responce: @{resp}

    #vyhodnocení status kódu
    Status Should Be    ${error_resp}

    #vyhodnocení JSONu stačí jen vyhodnotit klíč response a jeho hodnotu
    Should Be Equal As Strings         ${resp.json()}[response]      ${error_resp}



