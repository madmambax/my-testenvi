#
# Dokumentace ke SPOTIFY API: https://developer.spotify.com/documentation/web-api/
#

*** Settings ***
Library	    RequestsLibrary
Library     Lib/base64.py

*** Variables ***
${URL}                  https://api.spotify.com/v1/tracks/
#Artist                         artist           =   song
${ARTIST_ID}            1c2hJSwcCfoPEw1su83Sw0?si=d321161e923f4219

${URL_WITH_ARTIST_ID}   ${URL}${ARTIST_ID}
# CLIENT ID & SECRET
${CLIENT_ID}            4a83fe1829fd44f9b87345b6fcfadb5d
${CLIENT_SECRET}        c8e16e2b633d42aa83befc2cbda76bc2

${OAUTH_TOKEN_URL}      https://accounts.spotify.com/api/token

*** Test Cases ***

Spotify - získání tokenu, autentizace a vypsání jména umělce a tracku
    #base64 encoded client_id:client_secret
    ${base64encoded_client_id_and_secret}=    Evaluate    base64.b64encode('${CLIENT_ID}:${CLIENT_SECRET}'.encode('ascii'))
    ${headers}=   Create Dictionary  content-type=application/x-www-form-urlencoded  Authorization=Basic ${base64encoded_client_id_and_secret}
    ${body} =     Create Dictionary  grant_type=client_credentials
    ${resp} =     POST  ${OAUTH_TOKEN_URL}  headers=${headers}  data=${body}  expected_status=200

    #odpověď na Requests access token
     Log                 ${resp.json()}
     Log To Console      ${\n} Odpověď na Requests access token:
     Log To Console      access_token = ${resp.json()}[access_token]
     Log To Console      ${\n}
     Log To Console      Typ tokenu: ${resp.json()}[token_type]
     Log To Console      Token vyprší za: ${resp.json()}[expires_in]
     Log To Console      ${\n}
     ${access_token}     Set Variable  ${resp.json()}[access_token]

#Request2- Access Token
    ${headers}=         Create Dictionary  Authorization=Bearer ${access_token}
    ${resp} =           GET  ${URL_WITH_ARTIST_ID}  headers=${headers}  expected_status=200

    #data o umělci
    Log                 ${resp.json()}
    Log To Console      ${\n}
    Log To Console      Jméno umělce: ${\n}${resp.json()}[artists][0][name]   expected_status="Lady Gaga"
    Log To Console      Odkaz na song: ${\n}${resp.json()}[artists][0][external_urls][spotify]
    Log To Console      Název songu: ${\n}${resp.json()}[name]                expected_status="Hold My Hand"




