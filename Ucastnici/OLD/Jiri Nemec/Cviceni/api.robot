*** Settings ***
Library               RequestsLibrary
Library    Collections

*** Test Cases ***
#Quick Get Request Test
#      ${response}=    GET  https://www.google.com
#
#Quick Get Request With Parameters Test
#      ${response}=    GET  https://www.google.com/search  params=query=ciao  expected_status=200
#      Status Should Be    200

Quick Get A JSON Body Test
      ${response}=    GET  https://jsonplaceholder.typicode.com/posts/5
#      Should Be Equal As Strings    5  ${response.json()}[id]
#      Log To Console    ${response.json()}[title]
#      Log To Console    ${response.json()}
#      Log To Console    ${response.headers}[Date]
       Log To Console    ${response.json()}[body]
       Log To Console    ${response.text}

Registrace na kurz
    ${json} =  Catenate  {"targetid":"","kurz":"1","name":"Jan","surname":"Tester","email":"jan.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}

    ${response} =    POST  http://testovani.kitner.cz/regkurz/formsave.php  data=${json}  expected_status=200
    Should Be Equal As Strings    ${response.json()}[response]  200