"""

Tento příklad potřebuje robotframework-requests balíček
instalace:
pip install robotframework-requests

CVIČENÍ 2: vytvořte další testy, 1 pozitivní a 1 negativní test


"""


*** Settings ***
Library	 RequestsLibrary
Library  String             # potřebujeme pro klíčové slovo: Encode String To Bytes
#Library	 Collections


*** Variables ***
${url}		    http://testovani.kitner.cz/
${app}          /regkurz/formsave.php
${urlapp}       ${url}${app}

#${json}      {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}

*** Test Cases ***

registrace ok
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  200

registrace bez volby kurzu
    API Comunication   {"targetid":"","kurz":"","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500

#registrace volby telefonu (prázdný)
#přidat test

#registrace chybny telefon (moc dlouhy)
#přidat test

#registrace chybny email (tohleneniemail.cz)
#přidat test

#registrace chybny format JSON (bez klíče a hodnoty kurzu, tedy  "kurz":"2")
#přidat test

#BONUS: registrace chybny format JSON (vymyslet jinou chybu JSON dat)
#přidat test



*** Keywords ***

API Comunication
    [Arguments]       ${json}     ${error_resp}

    #převedení do UTF-8
    ${json_utf8} =      Encode String To Bytes     ${json}     UTF-8          #vyžaduje knihovnu String

    ${resp} =           POST  ${urlapp}  data=${json_utf8}  expected_status=${error_resp}

    Log                 ${resp.json()}

    Status Should Be    ${error_resp}


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

