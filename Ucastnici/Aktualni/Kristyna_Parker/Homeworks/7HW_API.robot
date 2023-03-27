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

Registrace na kurz fyzicka osoba
    Registrace na kurz  2  Kristyna  Parker  kristy.parker@abc.cz  741852963  fyz  Udolni 21,Brno  1  komentar  false  200

Registrace na kurz pravnicka osoba
    Registrace na kurz  2  Kristyna  Parker  kristy.parker@abc.cz  777123123  pra  27232433  1  dekuji  false  200

Registrace na kurz háčky a čárky
    Registrace na kurz   2  Kristýýýýna  Parkéééůůůůáer  kristy.parker@abc.cz  741852963  fyz  Udolni 21, Brno  1   ${EMPTY}  false   500

Registrace na kurz speciální znaky
    Registrace na kurz   2  Kri@}]*/*na  PaGH#&@er  kristy.parker@abc.cz  741852963  fyz  Udolni 21, Brno  1   a##&#aů  false   500

Registrace checkbox
    Registrace na kurz  2  Kristyna  Parker  kristy.parker@abc.cz  741852963  fyz  Udolni 21,Brno  1  komentar  true  200

Registrace na kurz tel číslo +420
    Registrace na kurz  2  Kristyna  Parker  kristy.parker@abc.cz  +420741852963  fyz  Udolni 21,Brno  1  komentar  false  200

Registrace na kurz chybné tel číslo
    Registrace na kurz  2  Kristyna  Parker  kristy.parker@abc.cz  +#&#&  fyz  Udolni 21,Brno  1  komentar  false  500

Registrace na kurz prázdné tel číslo
    Registrace na kurz  2  Kristyna  Parker  kristy.parker@abc.cz  ${EMPTY}  fyz  Udolni 21,Brno  1  komentar  false  500

Registrace znak místo počtu účastníků
    Registrace na kurz  2  Kristyna  Parker  kristy.parker@abc.cz  741852963  fyz  Udolni 21,Brno  &  komentar  false  500
#${EMPTY} pokud něco chybí napsat do testu parametr Empty
*** Keywords ***


Registrace na kurz
#    [Arguments]    ${kurz}   ${jmeno}   ${prijmeni}   ${email}   ${telefon}   ${osoba}   ${adresa_ico}   ${pocet}  ${komentar}  ${souhlas}   ${response_code}
#
#    # vytvoření těla (body) zprávy
#    ${json}=      catenate    {"targetid":"","kurz":"${kurz}","name":"${jmeno}","surname":"${prijmeni} ","email":"${email}","phone":"${telefon}","person":"${osoba}","address":"${adresa_ico}","count":"${pocet}","comment":${komentar},"souhlas":${response_code}}
    [Arguments]    ${course}   ${name}   ${surname}   ${email}   ${phone}   ${person}   ${address_ico}   ${count}   ${comment}   ${souhlas}   ${response_code}

    ${json}=   Catenate   {"targetid":"","kurz":"${course}","name":"${name}","surname":"${surname}","email":"${email}","phone":"${phone}","person":"${person}","address":"${address_ico}","ico":"${address_ico}","count":"${count}","comment":"${comment}","souhlas":${souhlas}}

    #převedení do UTF-8
    ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8      #vyžaduje knihovnu String

    #vytoření hlavičky (header) zprávy
    &{header}=          Create Dictionary   Content-Type=application/json

    # odeslání zprávy a uložení odpovědi do ${resp}
    ${resp} =           POST  ${urlapp}   data= ${json_utf8}   expected_status=Anything
    Log	                Responce: @{resp}

    #vyhodnocení status kódu
    Status Should Be    ${response_code}

    #vyhodnocení JSONu stačí jen vyhodnotit klíč response a jeho hodnotu
   Should Contain    ${resp.json()}[response]    ${response_code}

