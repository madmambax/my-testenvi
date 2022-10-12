#
# Dokumentace ke SPOTIFY API: https://developer.spotify.com/documentation/web-api/
#

*** Settings ***
Library	    RequestsLibrary
Library     Lib/base64.py
Variables   test_data.py

*** Variables ***
${URL}                  https://api.spotify.com/v1/tracks/
${ARTIST_ID}            2TpxZ7JUBn3uw46aR7qd6V
${URL_WITH_ARTIST_ID}   ${URL}${ARTIST_ID}


*** Test Cases ***
Test s autentizaci pro spotify

#1. requests pro získání access token

    #base64 encoded client_id:client_secret
    ${base64encoded_client_id_and_secret}=    Evaluate    base64.b64encode('${CLIENT_ID}:${CLIENT_SECRET}'.encode('ascii'))

    #   Připravit header s
    #       Authorization=Basic <base64 encoded client_id:client_secret>
    #       content-type=application/x-www-form-urlencoded
    ${headers}=         Create Dictionary  content-type=application/x-www-form-urlencoded  Authorization=Basic ${base64encoded_client_id_and_secret}

    #   Připravit body s
    #       grant_type=client_credential
    ${body} =           Create Dictionary  grant_type=client_credentials

    ${resp} =           POST  ${OAUTH_TOKEN_URL}  headers=${headers}  data=${body}  expected_status=200

#odpověď na Requests access token
    Log                 ${resp.json()}
    Log To Console      ${\n} Odpověď na Requests access token:
    Log To Console      access_token = ${resp.json()}[access_token]
    Log To Console      token_type = ${resp.json()}[token_type]
    Log To Console      expires_in = ${resp.json()}[expires_in]
    Log To Console      ${\n}
    ${access_token}     Set Variable  ${resp.json()}[access_token]


#2. request s použím Access Token
    ${headers}=         Create Dictionary  Authorization=Bearer ${access_token}
    ${resp} =           GET  ${URL_WITH_ARTIST_ID}  headers=${headers}  expected_status=200


#data o umělci
    Log                 ${resp.json()}
    Log To Console      ${\n} Data o umělci:
    Log To Console      ${resp.json()}[artists]
    Log To Console      ${\n}




