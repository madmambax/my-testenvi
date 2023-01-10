*** Settings ***
Library               RequestsLibrary

*** Test Cases ***

Quick Get A JSON Body Test
      ${response}=    GET  https://jsonplaceholder.typicode.com/posts/5
#      Should Be Equal As Strings    5  ${response.json()}[id]
      Log To Console    ${response.status_code}
      Log To Console    ${response.ok}
      Log To Console    ${response.reason}
      Log To Console  ${response.json()}[id]