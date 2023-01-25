*** Settings ***
Library         Collections
Library         RequestsLibrary
Library         String

*** Variables ***
${url}          http://testovani.kitner.cz
${app}          /login_app/userauth.php
${urlapp}       ${url}${app}

*** Test Cases ***

Login OK - Chrome
    Login       admin    tajneadmin      Chrome  200

Login NOK - chybne jmeno
    Login       Anna    tajneadmin  Chrome  403

Login NOK - chybne heslo
    Login       admin  Test  Chrome  403

Login NOK - chybne jmeno a heslo
    Login       Anna  Test  Chrome  403

Login OK - Opera
    Login       admin  tajneadmin  Opera  200

Login OK - Mozilla
    Login       admin  tajneadmin  Mozilla  200

Login NOK - spec.znaky
    Login       admin  ?tajneadmin?  Chrome  403

Login NOK - prázdne povinne pole - jmeno
    Login       null  tajneadmin  Chrome  403

Login NOK - prázdne povinne pole - heslo
    Login       admin  null  Chrome  403



*** Keywords ***


Login
    [Arguments]  ${username}  ${password}  ${useragent}  ${error_resp}

    ${json}=     Catenate
     ...    {"username":"${username}",
     ...    "password":"${password}",
     ...    "useragent":"${useragent}"}

    ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8

    &{header}=          Create Dictionary   Content-Type=application/json

    ${resp} =           POST  ${urlapp}  data=${json_utf8}  headers=${header}  expected_status=Anything

    Log	                Response: @{resp}
    Status Should Be    200
    Should Contain      ${resp.json()}[response]    ${error_resp}
