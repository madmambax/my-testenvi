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
Resource        /home/miki/PycharmProjects/jak_automatizovat_testy/Ucastnici/OLD/Miroslav_Duris/Data&Config/TestDataUpdated.robot

*** Variables ***
${url}		        http://testovani.kitner.cz/
${app}              /regkurz/formsave.php
${urlapp}           ${url}${app}

*** Test Cases ***

1. Case
    [Documentation]    Registrace na kurz fyzicka osoba
    [Tags]              Nefunkční
    Registrace na kurz  2  Jan787878  Novak  jan.novak@abc.cz  777123123  fyz  Udolni 21, Brno  1  komentar  false  200

2. Case
    [Documentation]    Registrace na kurz pravnicka osoba
    [Tags]              Nefunkční
    Registrace na kurz  2  Jan787878  Novak  jan.novak@abc.cz  777123123  pra  27232433  1  dekuji  false  200

3. Case
    [Documentation]    Registrace na kurz háčky a čárky
    [Tags]              Nefunkční
    Registrace na kurz  2  Janěščřžýáíéů  Novakěščřžýáíéů  jan.novak@abc.cz  777123123  fyz  Udolniěščřžýáíéů, Brno  1  nic  false  200

*** Keywords ***

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



