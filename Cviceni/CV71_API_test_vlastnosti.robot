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
Resource        Data_and_Config/TestData.robot


*** Variables ***
${url}		        http://testovani.kitner.cz/
${app}              /regkurz/formsave.php
${urlapp}           ${url}${app}


*** Test Cases ***

Registrace na kurz
    Registrace na kurz  2  Jan787878  Novak  jan.novak@abc.cz  777123123  fyz  Udolni 21, Brno  false  200

Registrace na kurz háčky a čárky
    Registrace na kurz  2  Janěščřžýáíéů  Novakěščřžýáíéů  jan.novak@abc.cz  777123123  fyz  Udolniěščřžýáíéů, Brno  false  200

Registrace na kurz negativni test
    Registrace na kurz  2  Janěščřžýáíéů  Novakěščřžýáíéů  chybna_emailova_adresa  777123123  fyz  Udolniěščřžýáíéů, Brno  false  500

*** Keywords ***



Registrace na kurz CV
    [Arguments]    #??? DOPLNIT ???#

    # vytvoření těla (body) zprávy
    ${json}=     Catenate      #??? DOPLNIT ???#

    #převedení do UTF-8
    ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8      #vyžaduje knihovnu String

    #vytoření hlavičky (header) zprávy
    &{header}=          Create Dictionary   Content-Type=application/json

    #vytvoření spojení (session)
    CreateSession       apilogin            ${url}

    # odeslání zprávy a uložení odpovědi do ${resp}
    ${resp} =           Post on Session     apilogin    /regkurz/formsave.php  data=${json_utf8}  headers=${header}
    Log	                Responce: @{resp}

    #vyhodnocení odpovědi a návratové hodnoty
    Should Be Equal As Strings	    ${resp.status_code}     200
    Dictionary Should Contain Item	${resp.json()}          response    ${responce_code}


Registrace na kurz
    [Arguments]    #??? DOPLNIT ???#

    # vytvoření těla (body) zprávy
    ${json}=      #??? DOPLNIT ???#

    #převedení do UTF-8
    ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8      #vyžaduje knihovnu String

    #vytoření hlavičky (header) zprávy
    &{header}=          Create Dictionary   Content-Type=application/json

    # odeslání zprávy a uložení odpovědi do ${resp}
    ${resp} =           POST  #??? DOPLNIT ???#
    Log	                Responce: @{resp}

    #vyhodnocení status kódu
    #??? DOPLNIT ???#

    #vyhodnocení JSONu stačí jen vyhodnotit klíč response a jeho hodnotu
    #??? DOPLNIT ???#



