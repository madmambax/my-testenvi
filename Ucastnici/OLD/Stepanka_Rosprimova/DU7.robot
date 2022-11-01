*** Settings ***
Library	 RequestsLibrary
Library  JSONLibrary
Library  String

*** Variables ***
${BASE_URL}		        http://testovani.kitner.cz
${LOGIN_URL}            login_app/userauth.php
${LOGIN_BASE_URL}       ${BASE_URL}/${LOGIN_URL}

*** Test Cases ***
Uspesny login
    Send API Data       admin       tajneadmin      Chrome 101.0.4951.67        200     correct

Neexistujici uzivatel
    Send API Data       Vormicek    nemamheslo      Chrome 101.0.4951.67        403     neexistujici uzivatel

Spatne heslo
    Send API Data       admin       nemamheslo      Chrome 106                  403     spatne heslo

*** Keywords ***
Send API Data
    [Arguments]         ${username}        ${password}      ${userAgent}    ${status}       ${reason}

    &{data}=            Create Dictionary    username=${username}     password=${password}      useragent=${userAgent}
    &{header}=          Create Dictionary    Content-Type=application/json

    ${json_data}=       Convert Json To String      ${data}
    ${json_data_utf8}=  Encode String To Bytes      ${json_data}            UTF-8

    ${response}=        POST  ${LOGIN_BASE_URL}      data=${json_data_utf8}     headers=${header}   expected_status=200

    Log                 ${response.json()}

    Should Be Equal     ${status}               ${response.json()}[response]
    Should Be Equal     ${reason}               ${response.json()}[reason]

