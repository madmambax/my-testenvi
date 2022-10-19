"""

Tento příklad potřebuje robotframework-requests balíček
instalace:
pip install robotframework-requests
pip install robotframework-jsonlibrary

CVIČENÍ: Vytvořte klíčové slovo pro testy registrace na kurz z pohledu funkcionality +
                                                          přidejte další testy pro kompletní otestování

Inspirujte se ve cvičení CV17_API_test_komunikace.robot klíčové slovo "API Comunication"
"""


*** Settings ***
Library	        Collections
Library	        RequestsLibrary
Library         String
#Resource        Data_and_Config/TestData.robot
Library         JSONLibrary


*** Variables ***
${url}		        http://testovani.kitner.cz/
${app}              /regkurz/formsave.php
${urlapp}           ${url}${app}


*** Test Cases ***

Registrace na kurz fyzicka osoba
    Registrace na kurz  2  Jan787878  Novak  jan.novak@abc.cz  777123000  fyz  Udolni 21, Praha  1  komentar  false  200

Registrace na kurz pravnicka osoba
    Registrace na kurz  2  Jan787878  Novak  jan.novak@abc.cz  777111222  pra  27232433  1  dekuji  false  200

Registrace na kurz háčky a čárky
    Registrace na kurz  2  Janěščřžýáíéů  Novakěščřžýáíéů  jan.novak@abc.cz  777123123  fyz  Udolniěščřžýáíéů, Brno  1  nic  false  200

*** Keywords ***


Registrace na kurz
    [Arguments]     ${error_resp}   ${kurz}      ${name}     ${surname}      ${email}     ${phone}     ${person}     ${adress_ico}     ${count}     ${comment}     ${souhlas}       ${200}
    # vytvoření těla (body) zprávy
    ${json}=       Catenate    {"targetid":"","kurz":"${kurz}","name":"${name}","surname":"${surname}","email":"${email}","phone":"${phone}","person":"${person}","address":"${adress_ico}","ico":"${adress_ico}","count":"${count}","comment":${comment},"souhlas":${souhlas}}
    ${error_resp}=  Log  200
    #převedení do UTF-8
    ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8      #vyžaduje knihovnu String

    #vytoření hlavičky (header) zprávy
    &{header}=          Create Dictionary   Content-Type=application/json

    # odeslání zprávy a uložení odpovědi do ${resp}
    ${resp} =           POST  ${urlapp}   data=${json_utf8}  headers=${header}  expected_status=Anything
    Log	                Responce: @{resp}

    #vyhodnocení status kódu
    Status Should Be    ${error_resp}

    #vyhodnocení JSONu stačí jen vyhodnotit klíč response a jeho hodnotu
    #??? DOPLNIT ???#






