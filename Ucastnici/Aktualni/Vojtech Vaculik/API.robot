###
# Documentation: catfact.ninja

*** Settings ***
Library  RequestsLibrary


*** Variables ***
${API_key}
${url}          https://catfact.ninja
${app}          /breeds
${urlapp}       ${url}${app}



*** Test Cases ***

Prvni api test
    Get a cat breed
    Sleep   5


*** Keywords ***
Dej mi kocku
    #JSON zprava
    ${json}=

   # vytoření hlavičky (header) zprávy
   &{header}=   Create Dictionary   Content-Type=application/json

#   # vytvoření spojení (session)
   CreateSession       apilogin            ${url}

#   # odeslání zprávy a uložení odpovědi do ${resp}
    ${resp} =  Post on Session  apilogin  ${app}  data=${json}  headers=${header}
    Log To Console    ${resp}
#   Status Should Be  200   # vyhodnocení


Get a cat breed
     &{header}=   Create Dictionary   Content-Type=application/json
     ${resp} =  Post on Session  apilogin  ${app}  data=${json}  headers=${header}
    Log To Console    ${resp}




