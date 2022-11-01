#
# Dokumentace ke SPOTIFY API: https://developer.spotify.com/documentation/web-api/
#

*** Settings ***
Library	    RequestsLibrary
Library     Lib/base64.py

*** Variables ***
${URL}                  https://api.spotify.com/v1/tracks/
${ARTIST_ID}            5nnf6869xT9hof20RQ7E15?si=79fbe6aca7c3429b
${URL_WITH_ARTIST_ID}   ${URL}${ARTIST_ID}
${CLIENT_ID}            acf568a9c52d415bb04bef17bc0c7c37
${CLIENT_SECRET}        46bb407f17cc4957bf96102c07822ffe
${OAUTH_TOKEN_URL}      https://accounts.spotify.com/api/token

*** Test Cases ***
Spotify - získání tokenu, autentizace a vypsání jména umělce a tracku
    #base64 encoded client_id:client_secret
    ${base64encoded_client_id_and_secret}=    Evaluate    base64.b64encode('${CLIENT_ID}:${CLIENT_SECRET}'.encode('ascii'))
    ${headers}=         Create Dictionary  content-type=application/x-www-form-urlencoded  Authorization=Basic ${base64encoded_client_id_and_secret}
    ${body} =           Create Dictionary  grant_type=client_credentials
    ${resp} =           POST  ${OAUTH_TOKEN_URL}  headers=${headers}  data=${body}  expected_status=200

    #odpověď na Requests access token
#    Log                 ${resp.json()}
#    Log To Console      ${\n} Odpověď na Requests access token:
#    Log To Console      access_token = ${resp.json()}[access_token]
     Log To Console      ${\n}
     Log To Console      Typ tokenu: ${resp.json()}[token_type]
     Log To Console      Token vyprší za: ${resp.json()}[expires_in]
#    Log To Console      ${\n}
     ${access_token}     Set Variable  ${resp.json()}[access_token]


#2. request s použím Access Token
    ${headers}=         Create Dictionary  Authorization=Bearer ${access_token}
    ${resp} =           GET  ${URL_WITH_ARTIST_ID}  headers=${headers}  expected_status=200

    #data o umělci
    Log                 ${resp.json()}
    Log To Console      ${\n}
    Log To Console      ${\n} Jméno umělce: ${resp.json()}[artists][0][name]
    Log To Console      Odkaz na track: ${resp.json()}[artists][0][external_urls][spotify]
    Log To Console      ${\n}




