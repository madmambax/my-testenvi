
*** Settings ***
Library  RequestsLibrary


*** Variables ***
${url}      http://testovani.kitner.cz/
${app}      regkurz/formsave.php
${urlapp}   ${url}${app}


*** Test Cases ***

#Prvni API test
#      ${response}=      GET  https://www.google.com
#      #Log to Console    ${response}
#
#Quick Get Request Test
#      ${response}=      GET  https://www.google.com  params=query=ciao  expected_status=200
#      Log to Console    ${\n}${response}
#      Status Should Be    200
#

Quick Get Request With Parameters Test
      ${response}=    GET  https://jsonplaceholder.typicode.com/posts/5
#      Should Be Equal As Strings    1    ${response.json()}[id]
      Log To Console    ${response.status_code}                     #odpověd response=200
      Log To Console    ${response.ok}                              #odpověd True
      Log To Console    ${response.reason}                          #odpověd  .OK
      Log To Console    ${response.json()}                          #odpověd json.{'userId': 1, 'id': 1, 'title': 'sunt ....
      Log to Console    ${response.json()}[title]
      Log To Console    ${response.json()}[id]
      Log To Console    ${response.headers}                         #odpověd .headers .{'Date': 'Thu, 29 Dec 2022 10:19:13 GMT', '...
      Log To Console    ${response.headers}


#Quick Get A JSON Body Test
#      ${response}=    GET  https://jsonplaceholder.typicode.com/posts/1
##      Status should be  200
#      Log to Console      ${response.ok}
#      Log to Console      ${response.headers}
#      Log to Console      reason: ${response.reason}
#      Log to Console      status_code: ${response.status_code}
#      Log to Console      text: ${response.text}
#      Log to Console      ${response.json()}
#      Log to Console      ${response.json()}[title]
#      Log to Console      ${response.json()}[userId]
#      Log To Console      ${response.json()}.id
#
#    Should Be Equal As Strings    OK  ${response.reason}
#
##&{dict} =    userId=1  id=1  title='sunt'  body='quia et suscipit'
##{'userId': 1, 'id': 1, 'title': 'sunt aut facere repellat provident occaecati excepturi optio reprehenderit', 'body': 'quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto'}
#    Should Be Equal As Strings    1  ${response.json()}[userId]
#    Should Be Equal As Strings    1  ${response.json()}[id]
#    Should Be Equal As Strings    sunt aut facere repellat provident occaecati excepturi optio reprehenderit  ${response.json()}[title]



#Test Registrace na Kurz
#  ${json}=  catenate  {"targetid":"","kurz":"1","name":"Jan","surname":"Tester","email":"jan.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
#
#  ${response}=    POST  ${urlapp}  data=${json}  expected_status=200


#Test Registrace na Kurz chyba
#  ${json}=  catenate  {"targetid":"","kurz":"","name":"Jan","surname":"Tester","email":"jan.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
#
#  ${response}=    POST  ${urlapp}  data=${json}  expected_status=500



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

















