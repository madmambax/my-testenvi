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

# Co se vyplňuje:
# 
#   ${course}         číslo kurzu - 1 (Jak se stát testerem), 2 (Testování v agilním prostředí), 3 (Základy testování softwaru)
#   ${name}           jméno účastníka
#   ${surname}        přijmení účastníka
#   ${email}          email na účastníka
#   ${phone}          telefon na účastníka
#   ${person}         rozlišení fyzická nebo právnická osoba
#   ${address}        adresa na účastníka (používá se v případě fyzické osoby)
#   ${ico}            identifikační číslo právnického subjektu (používá se v případě právnické osoby)
#   ${count}          počet účastníků
#   ${souhlas}        souhlas se zpracováním - true/false
#   ${responce_code}


*** Test Cases ***

Registrace na kurz základní
    Registrace na kurz  3  Gabriela  Zakova  gabriela.zakova@seznam.cz  604904589  fyz  Praha  false  200

Telefon v jiném formátu
    Registrace na kurz  3  Gabriela  Zakova  gabriela.zakova@seznam.cz  +420604904589  fyz  Praha  false  200

Háčky a čárky ve českých jménech 
    Registrace na kurz  3  Gabriela  Žáková  gabriela.zakova@seznam.cz  604904589  fyz  Hradec Králové  false  200

Číslo ve jméně
    Registrace na kurz  3  Gabriela88  Zakova  gabriela.zakova@seznam.cz  604904589  fyz  Praha  false  200

Číslo v příjmení
    Registrace na kurz  3  Gabriela  Zakova88  gabriela.zakova@seznam.cz  604904589  fyz  Praha  false  200

Speciální znak ve jméně
    Registrace na kurz  3  Gabriela+  Zakova  gabriela.zakova@seznam.cz  604904589  fyz  Praha  false  200

Speciální znak v příjmení
    Registrace na kurz  3  Gabriela  Zakova;  gabriela.zakova@seznam.cz  604904589  fyz  Praha  false  200


Registrace na kurz úplná
    Registrace          2  Gabriela  Zakova  gabriela.zakova@seznam.cz  604904589  fyz  Praha  123456789  5  Zdravím  true  200  



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
    Should Be Equal As Strings	${resp.status_code}     200
    Dictionary Should Contain Key	${resp.json()}      response
    Dictionary Should Contain Value	${resp.json()}      ${responce_code}


Registrace
    [Arguments]    ${course}  ${name}  ${surname}  ${email}  ${phone}  ${person}  ${address}  ${ico}  ${count}  ${comment}  ${souhlas}  ${responce_code}

    # vytvoření těla (body) zprávy
    ${json}=     Catenate      {"targetid":"","kurz":"${course}","name":"${name}","surname":"${surname}","email":"${email}","phone":"${phone}","person":"${person}","address":"${address}","ico":"${ico}","count":"${count}","comment":"${comment}","souhlas":${souhlas}}

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
    Should Be Equal As Strings	${resp.status_code}     200
    Dictionary Should Contain Key	${resp.json()}      response
    Dictionary Should Contain Value	${resp.json()}      ${responce_code}


