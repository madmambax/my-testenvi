*** Settings ***
Library               RequestsLibrary

*** Variables ***
${url}      http://testovani.kitner.cz/
${app}      regkurz/formsave.php
${urlapp}   ${url}${app}

*** Test Cases ***
Test login
    ${response}=      GET ${urlapp}

{"targetid":"","kurz":"1","name":"Jan","surname":"Tester","email":"jan.teser@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21,Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}

#Quick Get Request Test
#      ${response}=    GET  https://www.google.com
#      Log To Console    ${response}
#
#Quick Get Request With Parameters Test
#      ${response}=    GET  https://www.google.com/search  params=query=ciao  expected_status=200
#
#Quick Get A JSON Body Test
#      ${response}=    GET  https://jsonplaceholder.typicode.com/posts/2
#      Log To Console   >>>${response.status_code}
#      Log To Console   >>>${response.json()}


#      Should Be Equal As Strings    3  ${response.json()}[id]