*** Settings ***

Documentation   Test - API
Library         RequestsLibrary
Library         String

*** Variables ***

${url}      http://testovani.kitner.cz/
${app}      regkurz/formsave.php
${urlapp}   ${url}${app}

*** Test Cases ***

Registration OK
    ${json}=        catenate  {"targetid":"","kurz":"3","name":"Jitka","surname":"Tester","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","email":"jitka.tester@data.cz","phone":"777123132","count":"1","comment":"nic","souhlas":true}
    ${response}=    POST    http://testovani.kitner.cz/regkurz/formsave.php  data=${json}  expected_status=200
    log to console  ${response.json()}[response]

Registration with wrong email
    ${json}=        catenate  {"targetid":"","kurz":"3","name":"Jitka","surname":"Tester","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","email":"jitka.cz","phone":"777123132","count":"1","comment":"nic","souhlas":true}
    ${response}=    POST    http://testovani.kitner.cz/regkurz/formsave.php  data=${json}  expected_status=500
    log to console  ${response.json()}[response]
    log to console  ${response.json()}[reason]

