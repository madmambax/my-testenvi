*** Settings ***
Library  RequestsLibrary

*** Test Cases ***

Quick Get Request Test
      ${response}=      GET  https://www.google.com
      Log to Console    ${response}

Quick Get Request With Parameters Test
#      ${response}=    GET  https://www.google.com/search  params=query=test  expected_status=200
#      Log to Console    ${response}

      ${response}=    GET  https://www.google.com/search  params=query=test  expected_status=200
      Status Should Be   200

Quick Get A JSON Body Test
      ${response}=    GET  https://jsonplaceholder.typicode.com/posts/1
#      Log To Console   >>>${response.status_code}
      Log To Console   >>>${response.ok}
#      Log To Console   >>>${response.reason}
#      Log To Console   >>>${response.headers}
#      Log To Console   >>>${response.text}
      Log To Console   >>>${response.json()}[id]

#      Should Be Equal As Strings    1  ${response.json()}[id]