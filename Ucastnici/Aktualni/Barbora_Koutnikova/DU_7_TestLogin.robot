*** Settings ***
Library         Collections
Library         RequestsLibrary
Library         String

*** Variables ***
${url}          http://testovani.kitner.cz
${app}          /login_app/userauth.php
${urlapp}       ${url}${app}

*** Test Cases ***
Positive login (Chrome, admin)
    Login       admin  tajneadmin  Chrome  200

Positive login (Mozilla, admin)
    Login       admin  tajneadmin  Mozilla  200

Positive login (Chrome, novak)
    Login       novak  tajnenovak  Chrome  200

Positive login (Mozilla, novak)
    Login       novak  tajnenovak  Mozilla  200

Negative login (wrong username)
    Login       spatne  tajneadmin  Chrome  403

Negative login (wrong password)
    Login       admin  spatne  Chrome  403

Negative login (empty username)
    Login       ${EMPTY}  tajneadmin  Chrome  403

Negative login (empty password)
    Login       admin  ${EMPTY}  Chrome  403

Negative login (long username - 60 letters)
    Login       adminadminadminadminadminadminadminadminadminadminadminadmin  tajneadmin  Chrome  403

Negative login (long password - 60 letters)
    Login       admin  tajneadmintajneadmintajneadmintajneadmintajneadmintajneadmin  Chrome  403

Negative login (username - special characters)
    Login       @?!  tajneadmin  Chrome  403

Negative login (password - special characters)
    Login       admin  @?!  Chrome  403

*** Keywords ***
Login
    [Arguments]  ${username}  ${password}  ${useragent}  ${response_code}

    ${json}=     Catenate     {"username":"${username}","password":"${password}","useragent":"${useragent}"}
    ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8

    &{header}=          Create Dictionary   Content-Type=application/json

    ${resp} =           POST  ${urlapp}  data=${json_utf8}  headers=${header}  expected_status=Anything
    Log	                Response: @{resp}

    Status Should Be    200

    Should Contain      ${resp.json()}[response]    ${response_code}
