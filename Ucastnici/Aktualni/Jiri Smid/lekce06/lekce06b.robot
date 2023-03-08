*** Settings ***
Library  RequestsLibrary


*** Variables ***
${url}      http://testovani.kitner.cz/
${app}      regkurz/formsave.php
${urlapp}   ${url}${app}


*** Test Cases ***

Test Registrace na Kurz
  ${json}=  catenate  {"targetid":"","kurz":"1","name":"Jan","surname":"Tester","email":"jan.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}

  ${response}=    POST  ${urlapp}  data=${json}  expected_status=200

#  Status Should Be   200
#  Should Be Equal    ${response.json()}[response]   200


Test Registrace na Kurz chyba
  ${json}=  catenate  {"targetid":"","kurz":"","name":"Jan","surname":"Tester","email":"jan.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}

  ${response}=    POST  ${urlapp}  data=${json}  expected_status=500