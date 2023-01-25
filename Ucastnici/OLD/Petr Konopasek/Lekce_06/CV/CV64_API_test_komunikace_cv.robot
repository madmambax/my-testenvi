#"""

#Tento příklad potřebuje robotframework-requests balíček
#instalace:
#pip install robotframework-requests

#CVIČENÍ 2: vytvořte další testy, 1 pozitivní a 1 negativní test


#"""


*** Settings ***
Library	 RequestsLibrary
Library  String             # potřebujeme pro klíčové slovo: Encode String To Bytes
Library	 Collections


*** Variables ***
${url}		    http://testovani.kitner.cz/
${app}          /regkurz/formsave.php
${urlapp}       ${url}${app}

#${json}      {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}

*** Test Cases ***

registrace ok
    [Documentation]     Registrace vše OK - Test Pozitivní
    [Tags]              Funkční
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  200
    #očekávámm response 200

Registrace json bez volby kurzu

    API Comunication   {"targetid":"","kurz":"","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500
    #čekám response 500
Registrace volby telefonu json (prázdný)
    [Documentation]     Registrace bez telefonu (prázdný) - Test Negativní
    [Tags]              Funkční
    API Comunication   {"targetid":"","kurz":"","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500
    #čekám response 500

Registrace chybny json telefon (dlouhý)
#přidat test
    [Documentation]     Registrace telefon (moc dlouhy) - Test Negativní
    [Tags]              Funkční
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"6089991299993123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500

Registrace chybny json email (neplatný email)
#přidat test
    [Documentation]     Registrace - chybny email (tohleneniemail.cz) - Test Negativní
    [Tags]              Funkční
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"tohleneniemail.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500

registrace chybny format JSON (bez klíče a hodnoty kurzu,   #tedy "kurz":"2")
#přidat test
    [Documentation]     Registrace - chybny format JSON (bez klíče a hodnoty kurzu, tedy  "kurz":"2") - Test Negativní
    [Tags]              Funkční
    API Comunication   {"targetid":"","name":"Jan","surname":"Novak","email":"tohleneniemail.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500

BONUS: registrace chybny format JSON (vymyslet jinou chybu JSON dat)
#přidat test
    [Documentation]     Registrace - chybná hodnota kurzu format JSON ( hodnota kurzu "A" místo čísla 1-3 ) - Test Negativní
    [Tags]              Funkční
    API Comunication   {"targetid":"","kurz":"A",":"name":"Jan","surname":"Novak","email":"tohleneniemail.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500



*** Keywords ***

API Comunication
    [Arguments]       ${json}     ${error_resp}
    ${json_utf8} =      Encode String To Bytes     ${json}     UTF-8          #vyžaduje knihovnu String
    ${response} =           POST  ${urlapp}  data=${json_utf8}  expected_status=${error_resp}
    Log                 ${response.json()}
    Status Should Be    ${error_resp}
    Log To Console      ${response.status_code}                     #odpověd response=200
    Log To Console      ${response.ok}                              #odpověd True
    Log To Console      ${response.json()}
    Log To Console      ${response.json()}[id]
    Log To Console      ${response.json()}[id]


API Comunicaication Post on Session
    [Arguments]       ${json}     ${error_resp}

   #převedení do UTF-8
   ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8          #vyžaduje knihovnu String

  #vytoření hlavičky (header) zprávy
  &{header}=          Create Dictionary   Content-Type=application/json     charset=utf-8

  #vytvoření spojení (session)
  CreateSession       apilogin            ${url}

  # odeslání zprávy a uložení odpovědi do ${resp}
  ${resp}=   Post on Session   apilogin  ${app}   data=${json_utf8}   headers=${header}   expected_status=Anything

  Status Should Be    ${error_resp}

