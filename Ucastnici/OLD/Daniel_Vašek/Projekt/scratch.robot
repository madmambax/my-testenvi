*** Settings ***
Library  RequestsLibrary


*** Test Cases ***

Prvni API test
      ${response}=      GET  https://www.google.com
      Log to Console    ${response}

Quick Get Request Test
      ${response}=    GET  https://www.google.com
      Log to Console    ${response}

Quick Get Request With Parameters Test
      ${response}=    GET  https://www.google.com/search  params=query=ciao  expected_status=200
      Log to Console    ${response}

Quick Get A JSON Body Test
      ${response}=    GET  https://jsonplaceholder.typicode.com/posts/2
      Log to Console    ${response.ok}
      Log to Console    ${response.json()}[id]
      Log to Console    ${response.json()}.id


      #Log to Console    ${response.headers}
      #Log to Console    ${response.json().id}
      #Log to Console    ${response.reason}
      #Log to Console    ${response.text}
      #Should Be Equal As Strings    1  ${response.json()}[id]