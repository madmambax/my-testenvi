
*** Settings ***
Library  RequestsLibrary


*** Variables ***
${url}      http://testovani.kitner.cz/
${app}      regkurz/formsave.php
${urlapp}   ${url}${app}


*** Test Cases ***

První test
    GET     https://www.google.com
    Status Should Be    200







#Quick Get Request Test
#      ${response}=    GET  https://www.google.com
#
#Quick Get Request With Parameters Test
#      ${response}=    GET  https://www.google.com/search  params=query=ciao  expected_status=200
#
#Quick Get A JSON Body Test
#      ${response}=    GET  https://jsonplaceholder.typicode.com/posts/1
#      Should Be Equal As Strings    1  ${response.json()}[id]







#
#Chybny format dat místo DATA pouzit JSON
#    ${json}=  catenate  {"targetid":"","kurz":"1","name":"Jan","surname":"Tester","email":"jan.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
#    POST    ${urlapp}   json=${json}  expected_status=500
#
#Vše OK
#    ${json}=        catenate  {"targetid":"","kurz":"1","name":"Jan","surname":"Tester","email":"jan.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
#    ${response}=    POST    ${urlapp}   data=${json}  expected_status=200
#    log to console  ${response.json()}[response]
#
#
#Chybné číslo kurzu
#    ${json}=  catenate  {"targetid":"","kurz":"5","name":"Jan","surname":"Tester","email":"jan.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
#    ${response}=  POST    ${urlapp}   data=${json}  expected_status=200
#
#    #Pozor na psani a nepsaní kulatých závorek
##    log to console  ${response.json}
#    log to console  ${response.json()}
#    log to console  ${response.json()}[response]
#    log to console  ${response.json()}[reason]
##    log to console  ${response.text}
#
#
#
#
#

















