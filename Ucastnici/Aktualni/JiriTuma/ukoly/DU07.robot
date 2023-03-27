*** Settings ***
Library	        Collections
Library	        RequestsLibrary
Library         String
Resource        TestData.robot


*** Variables ***
${urlapp}           ${url testovani kitner}${app regkurz}


*** Test Cases ***
Registrace na kurz Jak se stát testerem pro FO
    Registrace na kurz  1  Jan787878  Novak  jan.novak@abc.cz  777123123  fyz  Udolni 21, Brno  1  komentar  false  200

Registrace na kurz Testování v agilním prostředí pro PO
    Registrace na kurz  2  Jan787878  Novak  jan.novak@abc.cz  777123123  pra  27232433  1  dekuji  false  200

Registrace na kurz Základy testování software pro FO, test na háčky a čárky
    Registrace na kurz  3  Janěščřžýáíéů  Novakěščřžýáíéů  jan.novak@abc.cz  777123123  fyz  Udolniěščřžýáíéů, Brno  1  nic  false  200

Registrace na kurz FO bez e-mailu
    Registrace na kurz  2  Jan787878  Novak  email=${empty}  777123123  fyz  Udolni 21, Brno  1  komentar  false  500

Registrace na kurz PO s chybným e-mailem
    Registrace na kurz  2  Jan787878  Novak  jan.novakabc.cz  777123123  pra  27232433  1  dekuji  false  500

Registrace na kurz PO bez telefonního čísla
    Registrace na kurz  2  Jan787878  Novak  jan.novakabc.cz  phone=${empty}  pra  27232433  1  dekuji  false  500

Registrace FO bez vybrání typu kurzu
    Registrace na kurz  ? undefined:undefined ?  Jan787878  Novak  jan.novak@abc.cz  777123123  fyz  Udolni 21, Brno  1  komentar  false  500


*** Keywords ***
Registrace na kurz
    [Arguments]    ${kurz}  ${jmeno}  ${prijmeni}  ${e-mail}  ${telefon}  ${osoba_druh}  ${ico_adresa}  ${count}  ${comment}  ${souhlas}  ${response_code}

    # vytvoření těla (body) zprávy
    ${json}=    Catenate  {"targetid":"","kurz":"${kurz}","name":"${jmeno}","surname":"${prijmeni}","email":"${e-mail}","phone":"${telefon}","person":"${osoba_druh}","address":"${ico_adresa}","ico":"${ico_adresa}","count":"${count}","comment":"${comment}","souhlas":"${souhlas}"}
    log to console  JSON : ${json}

    #převedení do UTF-8
    ${json_utf8} =     Encode String To Bytes  ${json}     UTF-8      #vyžaduje knihovnu String

    #vytoření hlavičky (header) zprávy
    &{header}=          Create Dictionary  Content-Type=application/json

    # odeslání zprávy a uložení odpovědi do ${resp}
    ${resp} =           POST    ${urlapp}  data=${json_utf8}  headers=${header}  expected_status=${response_code}
    Log	                Response: @{resp}

    #vyhodnocení status kódu
    Status should be    ${response_code}
    #nebo
    Should Be Equal As Strings	    ${resp.status_code}     ${response_code}

    #vyhodnocení JSONu klíč response
    Dictionary Should Contain Item	${resp.json()}          response    ${response_code}
    #nebo
    Should Contain      ${resp.json()}[response]            ${response_code}




