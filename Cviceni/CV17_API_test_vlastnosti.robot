"""

Tento příklad potřebuje robotframework-requests balíček
instalace:
pip install robotframework-requests

"""


*** Settings ***
Library	Collections
Library	RequestsLibrary


*** Variables ***
${url}		        http://testovani.kitner.cz/


*** Test Cases ***

Registrace na kurz
    Registrace na kurz  2  Jan787878  Novak  jan.novak@abc.cz  777123123  fyz  Udolni 21, Brno  false  200



*** Keywords ***





Registrace na kurz
    [Arguments]    ${course}  ${name}  ${surname}  ${email}  ${phone}  ${person}  ${address}  ${souhlas}  ${responce_code}

    # vytvoření těla (body) zprávy
    ${json}=     Catenate      {"targetid":"","kurz":"${course}","name":"${name}","surname":"${surname}","email":"${email}","phone":"${phone}","person":"${person}","address":"${address}","ico":"1","count":"1","comment":null,"souhlas":${souhlas}}

    #vytoření hlavičky (header) zprávy
    &{header}=          Create Dictionary   Content-Type=application/json

    #vytvoření spojení (session)
    CreateSession       apilogin            ${url}

    # odeslání zprávy a uložení odpovědi do ${resp}
    ${resp} =           Post on Session     apilogin    /regkurz/formsave.php  data=${json}  headers=${header}
    Log	                Responce: @{resp}

    #vyhodnocení odpovědi a návratové hodnoty
    Should Be Equal As Strings	${resp.status_code}     200
    Dictionary Should Contain Key	${resp.json()}      response
    Dictionary Should Contain Value	${resp.json()}      ${responce_code}



