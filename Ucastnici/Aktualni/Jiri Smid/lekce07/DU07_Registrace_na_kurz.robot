#DÚ 07 Registrace na kurz http://testovani.kitner.cz/regkurz/

*** Settings ***
Library	        Collections
Library	        RequestsLibrary
Library         String
#Resource        TestData.robot


*** Variables ***
${url}		        http://testovani.kitner.cz/
${app}              /regkurz/formsave.php
${urlapp}           ${url}${app}


*** Test Cases ***

Registrace na kurz fyzicka osoba
    Registrace na kurz  2  Jan787878  Novak  jan.novak@abc.cz  777123123  fyz  Udolni 21, Brno  1  komentar  false  200

Registrace na kurz pravnicka osoba
    Registrace na kurz  2  Jan787878  Novak  jan.novak@abc.cz  777123123  pra  27232433  1  dekuji  false  200

Registrace na kurz hacky a carky - u jmena, prijmeni, adresy
    Registrace na kurz  2  Janěščřžýáíéů  Novakěščřžýáíéů  jan.novak@abc.cz  777123123  fyz  Udolniěščřžýáíéů, Brno  1  nic  false  200

Registrace na kurz prazdny komentar
    Registrace na kurz  2  Janěščřžýáíéů  Novakěščřžýáíéů  jan.novak@abc.cz  777123123  fyz  Udolniěščřžýáíéů, Brno  1  ${EMPTY}  false  200

Registrace na kurz spatny format telefonniho cisla (napr. abcde0)
    Registrace na kurz  2  Janěščřžýáíéů  Novakěščřžýáíéů  jan.novak@abc.cz  abcde0  fyz  Udolniěščřžýáíéů, Brno  1  neconeco  false  500

Registrace na kurz telefonni cislo s predvolbou
    Registrace na kurz  2  Jan  Novak  jan.novak@abc.cz  +420777123456  fyz  Udolniěščřžýáíéů, Brno  1  neconeco  false  200

Registrace na kurz chybny format ICO (o 1 cislo mene)
    Registrace na kurz  2  Janěščřžýáíéů  Novakěščřžýáíéů  jan.novak@abc.cz  777147852  pra  2722333  2  neconeco  false  500

Registrace na kurz spatny format emailu (napr. jan.novak@abc)
    Registrace na kurz  2  Jan787878  Novak  jan.novak@abc  777123123  fyz  Udolni 21, Brno  1  komentar  false  500

Registrace na kurz nevyplnene povinne pole - email
    Registrace na kurz  2  Jan  Novak  ${EMPTY}  777123123  fyz  Udolni 21, Brno  1  komentar  false  500

Registrace na kurz chybny pocet osob (např. 0)
    Registrace na kurz  2  Jan787878  Novak  jan.novak@abc.cz  777123123  fyz  Udolni 21, Brno  0  komentar  false  500

Registrace na kurz chybny format poctu osob (např. A)
    Registrace na kurz  2  Jan787878  Novak  jan.novak@abc.cz  777123123  fyz  Udolni 21, Brno  A  komentar  false  500

Registrace na kurz nevyplnene povinne pole - pocet osob
    Registrace na kurz  2  Jan787878  Novak  jan.novak@abc.cz  777123123  fyz  Udolni 21, Brno  ${EMPTY}  komentar  false  500

Registrace na kurz nevyplnene povinne pole - telefonni cislo
    Registrace na kurz  2  Jan787878  Novak  jan.novak@abc.cz  ${EMPTY}  fyz  Udolni 21, Brno  2  komentar  true  500

Registrace na kurz nevyplnene povinne pole - nazev kurzu
    Registrace na kurz  ${EMPTY}  Jan787878  Novak  jan.novak@abc.cz  777123123  fyz  Udolni 21, Brno  2  komentar  true  500

Registrace na kurz nevyplnene povinne pole - fyzicka/pravnicka osoba a adresa/ICO
    Registrace na kurz  1  Jan787878  Novak  jan.novak@abc.cz  777123123  ${EMPTY}  ${EMPTY}  2  komentar  true  500

Registrace na kurz nevyplnene povinne pole - jmeno
    Registrace na kurz  2  ${EMPTY}  Novak  jan.novak@abc.cz  777123123  fyz  Udolni 21, Brno  1  komentar  false  500

Registrace na kurz nevyplnene povinne pole - prijmeni
    Registrace na kurz  2  Jan  ${EMPTY}  jan.novak@abc.cz  777123123  fyz  Udolni 21, Brno  1  komentar  false  500

*** Keywords ***

Registrace na kurz
    [Arguments]    ${course}  ${name}  ${surname}  ${email}  ${phone}  ${person}  ${address_ico}  ${count}  ${comment}  ${souhlas}  ${responce_code}

    # vytvoření těla (body) zprávy

    ${json}=     Catenate      {"targetid":"","kurz":"${course}","name":"${name}","surname":"${surname}","email":"${email}","phone":"${phone}","person":"${person}","address":"${address_ico}","ico":"${address_ico}","count":"${count}","comment":"${comment}","souhlas":${souhlas}}

    #převedení do UTF-8
    ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8      #vyžaduje knihovnu String

    #vytoření hlavičky (header) zprávy
    &{header}=          Create Dictionary   Content-Type=application/json

    # odeslání zprávy a uložení odpovědi do ${resp}
    ${resp} =           POST  ${urlapp}   data=${json_utf8}  headers=${header}  expected_status=${responce_code}
    Log	                Responce: @{resp}

    #vyhodnocení status kódu
    Status should be    ${responce_code}

    #nebo
    #Should Be Equal As Strings	    ${resp.status_code}     ${responce_code}

    #vyhodnocení JSONu klíč response
    Should Contain      ${resp.json()}[response]            ${responce_code}

    #nebo
    #Dictionary Should Contain Item	${resp.json()}          response    ${responce_code}