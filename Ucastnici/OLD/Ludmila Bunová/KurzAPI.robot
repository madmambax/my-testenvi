*** Settings ***
Library	 Collections
Library	 RequestsLibrary
Library  String


*** Variables ***
${url}		        http://testovani.kitner.cz/


*** Test Cases ***
Registrace na kurz (vsechno spravne)
    Registrace na kurz   2  Jan  Novak  jan.novak@abc.cz  777123123  fyz  Udolni 21, Brno  false  200

Registrace na kurz (bez uvedeni kurzu)
    Registrace na kurz  ${null}  Jan  Novak  jan.novak@abc.cz   +420777123123  fyz  Udolni 21, Brno  false  200

Registrace na kurz (s neexistujicim kurzem)
    Registrace na kurz    5     Jan  Novak  jan.novak@abc.cz   +420777123123  fyz  Udolni 21, Brno  false  200

Registrace na kurz (kurz 1)
    Registrace na kurz   1   Jan  Novak  jan.novak@abc.cz   +420777123123  fyz  Udolni 21, Brno  false  200

Registrace na kurz (kurz 3)
    Registrace na kurz   3  Jan  Novak  jan.novak@abc.cz   +420777123123  fyz  Udolni 21, Brno  false  200

Registrace na kurz (bez jmena)
    Registrace na kurz   2  Novak  jan.novak@abc.cz  777123123  fyz  Udolni 21, Brno  false  200

Registrace na kurz (kratke jmeno)
    Registrace na kurz  2  I  Novak  jan.novak@abc.cz  777123123  fyz  Udolni 21, Brno  true  200

Registrace na kurz (dlouhe jmeno 35 zn.)
    Registrace na kurz   2  Janaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa  Novak  jan.novak@abc.cz  777123123  fyz  Udolni 21, Brno  false  200

Registrace na kurz (bez prijmeni)
    Registrace na kurz   2  Jan    jan.novak@abc.cz  777123123  fyz  Udolni 21, Brno  false  200

Registrace na kurz (kratke prijmeni)
    Registrace na kurz   2  Jan  N  jan.novak@abc.cz  777123123  fyz  Udolni 21, Brno  false  200

Registrace na kurz (dlouhe prijmeni 35 zn.)
    Registrace na kurz   2  Jan    Novaknovaknovaknovaknovaknovaknovak  jan.novak@abc.cz  777123123  fyz  Udolni 21, Brno  false  200

Registrace na kurz (bez mailu)
    Registrace na kurz   2  Jan  Novak  777123123  fyz  Udolni 21, Brno  false  200

Registrace na kurz (bez zavinace v mailu)
    Registrace na kurz   2  Jan  Novak  jan.novakabc.cz  777123123  fyz  Udolni 21, Brno  false  200

Registrace na kurz (bez tecky v mailu)
    Registrace na kurz   2  Jan  Novak  jan.novak@abccz  777123123  fyz  Udolni 21, Brno  false  200

Registrace na kurz (tel. s cz predvolbou)
    Registrace na kurz   2  Jan  Novak  jan.novak@abc.cz   +420777123123  fyz  Udolni 21, Brno  false  200

Registrace na kurz (tel. s sk predvolbou)
    Registrace na kurz   2  Jan  Novak  jan.novak@abc.cz   +421777123123  fyz  Udolni 21, Brno  false  200

Registrace na kurz (kratke tel.cislo)
    Registrace na kurz   2  Jan  Novak  jan.novak@abc.cz  777  fyz  Udolni 21, Brno  false  200

Registrace na kurz (nepovolene znaky v tel.cisle)
    Registrace na kurz   2  Jan  Novak  jan.novakabc.cz  abc123123  fyz  Udolni 21, Brno  false  200

Registrace na kurz (bez adresy)
    Registrace na kurz   2  Jan  Novak  jan.novak@abc.cz   777123123   fyz  true  200

Registrace na kurz (kratka adresa)
    Registrace na kurz   2  Jan  Novak  jan.novak@abc.cz   777123123   I  fyz  true  200

Registrace na kurz (bez uvedeni osoby)
    Registrace na kurz   2  Jan  Novak  jan.novak@abc.cz   +420777123123   Udolni 21, Brno  false  200




*** Keywords ***

Registrace na kurz
     [Arguments]    ${course}  ${name}  ${surname}  ${email}  ${phone}  ${person}  ${address}  ${souhlas}  ${responce_code}

    # vytvoření těla (body) zprávy
    ${json}=     Catenate      {"targetid":"","kurz":"${course}","name":"${name}","surname":"${surname}","email":"${email}","phone":"${phone}","person":"${person}","address":"${address}","ico":"1","count":"1","comment":null,"souhlas":${souhlas}}

    #převedení do UTF-8
    ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8      #vyžaduje knihovnu String

    #vytoření hlavičky (header) zprávy
    &{header}=          Create Dictionary   Content-Type=application/json

    #vytvoření spojení (session)
    CreateSession       apilogin            ${url}

    # odeslání zprávy a uložení odpovědi do ${resp}
    ${resp} =           Post on Session     apilogin    /regkurz/formsave.php  data=${json_utf8}  headers=${header}
    Log	                Response: @{resp}

    #vyhodnocení odpovědi a návratové hodnoty
    Should Be Equal As Strings	${resp.status_code}     200
    Dictionary Should Contain Key	${resp.json()}      response
    Dictionary Should Contain Value	${resp.json()}      ${responce_code}


