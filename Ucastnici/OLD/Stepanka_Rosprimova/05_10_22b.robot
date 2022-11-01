*** Settings ***
Library  RequestsLibrary

*** Variables ***
${url}      http://testovani.kitner.cz/
${app}      regkurz/formsave.php
${urlapp}   ${url}${app}

*** Test Cases ***
Prvni API test
      ${response}=      GET  https://www.google.com
      Log to Console    \n ${response}

Quick Get Request Test
     ${response}=    GET  https://www.google.com

Quick Get Request With Parameters Test
     ${response}=    GET  https://www.google.com/search  params=query=ciao  expected_status=200

Quick Get A JSON Body Test
     ${response}=    GET  https://jsonplaceholder.typicode.com/posts/2

     Log                                ${response.ok}
     Log                                ${response.headers}
     Log                                ${response.reason}
     Log                                ${response.text}
     Log                                ${response.content}
     Log                                ${response.url}
     Log                                ${response.status_code}
     Log To Console                     ${response.json()}[userId]
     Should Be Equal As Strings    1    ${response.json()}[userId]
     Log To Console                     ${response.json()}[id]
     Should Be Equal As Strings    2    ${response.json()}[id]

