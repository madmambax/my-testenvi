#*** Settings ***
#Library  RequestsLibrary

#*** Test Cases ***
#prvni test api
#      ${response} =      GET  https://www.google.com
#      Log to Console    ${response}

*** Settings ***
Library  RequestsLibrary
Library  String

*** Variables ***
${url}      http://testovani.kitner.cz/
${app}      regkurz/formsave.php
${urlapp}   ${url}${app}


*** Test Cases ***
Registrace na kurz
    ${json}=  Catenate  { "targetid":"","kurz":"1","name":"Jan","surname":"Tester","email":"jan.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
    ${response}=  POST  ${urlapp}  data=${json}
    Status Should Be    200
    Log To Console   ${response.json()}[response]
    Should Be Equal As Strings    200  ${response.json()}[response]

Registrace na kurz
    ${json}=  Catenate  { "targetid:"","kurz":"1","name":"Jan","surname":"Tester","email":"jan.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
    ${response}=  POST  ${urlapp}  data=${json}  expected_status=500
    Status Should Be    500
    Log To Console   ${response.json()}[response]
    Should Be Equal As Strings    500  ${response.json()}[response]




Quick Get Request Test
      ${response}=    GET  https://www.google.com

Quick Get Request With Parameters Test
      ${response}=    GET  https://www.google.com/search  params=query=ciao  expected_status=200

Quick Get A JSON Body Test
      ${response}=    GET  https://jsonplaceholder.typicode.com/posts/2
     #Log to console  ${response.reason}
     #Log to Console  ${response.ok}
     #Log to Console  ${response.headers}
     #Log to console  ${response.text}
     #Log To Console  ${response.json()}
      Log To Console    ${response.json()}[title]
      Should Be Equal As Strings    qui est esse  ${response.json()}[title]


registrace ok
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  200

registrace bez volby kurzu
    API Comunication   {"targetid":"","kurz":"","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500

registrace volby telefonu (prázdný)
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500

registrace chybny telefon (moc dlouhy)
    API Comunication  {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"123456789123456789","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500

registrace chybny email (tohleneniemail.cz)
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"tohleneniemail.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500

registrace chybny format JSON (bez klíče a hodnoty kurzu, tedy "kurz":"2")
    API Comunication   {"targetid:"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"tohleneniemail.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500

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