"""

Tento příklad potřebuje robotframework-requests balíček
instalace:
pip install robotframework-requests

"""


*** Settings ***
Library	 Collections
Library	 RequestsLibrary
Library  String


*** Variables ***
${url}		        http://testovani.kitner.cz/


*** Test Cases ***

Registrace na kurz 2
    Registrace na kurz  2  Jan787878  Novak  jan.novak@abc.cz  777123123  fyz  Udolni 21, Brno  false  200

Registrace na kurz háčky a čárky
    Registrace na kurz  2  Janěščřžýáíéů  Novakěščřžýáíéů  jan.novak@abc.cz  777123123  fyz  Udolniěščřžýáíéů, Brno  false  200

Registrace na kurz 1
    Registrace na kurz  1  Jan123  Čertík  jan.certik@abc.cz  777123123  fyz  Udolni 21, Brno  false  200

Registrace na kurz 3
    Registrace na kurz  3  Petr12  Doležal  petr.dolezal@abc.cz  589654256  fyz  Srbská 58, Brno  false  200

Registrace na kurz pravnicka
    Registrace na kurz  1  Jan123  Čertík  jan.certik@abc.cz  777123123  prav  Česká 241, Brno  false  200


Registrace na kurz spatny mail
    Registrace na kurz  1  Jan123  Čertík  jan.certik@abc.czhhh  777123123  fyz  Česká 241, Brno  true  200

Registrace na kurz spatne tel. cislo (prilis dlouhe)
    Registrace na kurz  1  Jan123  Čertík  jan.certik@abc.cz  7771231234  fyz  Česká 241, Brno  true  500

Registrace na kurz spatne tel. cislo (nesmyslny znak)
    Registrace na kurz  1  Jan123  Čertík  jan.certik@abc.cz  -777123123  fyz  Česká 241, Brno  true  500

Registrace na kurz spatnou adresu (nesmyslny znak)
    Registrace na kurz  1  Jan123  Čertík  jan.certik@abc.czhhh  777123123  fyz  -Česká 241, Brno  false  200

Registrace na kurz - zvlastni znaky
    Registrace na kurz  2  $$$  $$$  jan.novak@abc.cz  777123123  fyz  $$$ 21, $$$  false  200

Registrace na kurz - vynechane jmeno (požaduje 9 argumentu), vlozime 8
    Registrace na kurz  2    Klouda  petr.klouda@abc.cz  777123123  fyz  Česká 241, Brno  false  200


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
    Log	                Responce: @{resp}

    #vyhodnocení odpovědi a návratové hodnoty
    Should Be Equal As Strings	    ${resp.status_code}     200
    Dictionary Should Contain Item	${resp.json()}          response    ${responce_code}
