*** Settings ***
Library	        Collections
Library	        RequestsLibrary
Library         String


*** Variables ***
${url}		        http://testovani.kitner.cz/
${app}              /login_app/userauth.php
${urlapp}           ${url}${app}


*** Test Cases ***


Login funkcni
    Prihlaseni  admin   tajneadmin  Chrome 101.0.4951.67  200  correct

Login spatny
    Prihlaseni  utocnik   velky  Chrome 101.0.4951.67  403  neexistujici uzivatel

Login null
    Prihlaseni Ciste    null   "tajneadmin"  "Chrome 101.0.4951.67"  403  chybi prihlasovacijmeno

Heslo null
    Prihlaseni Ciste    "admin"   null  "Chrome 101.0.4951.67"  403  spatne heslo

Spatne heslo
    Prihlaseni  admin   velky  Chrome 101.0.4951.67  403  spatne heslo

UserAgent null
    Prihlaseni Ciste    "admin"   "tajneadmin"  null  403  spatne heslo

Useragent Wget
    Prihlaseni  admin   tajneadmin  Wget/1.13.4 (linux-gnu)  403  spatne heslo

Useragent Opera
    Prihlaseni  admin   tajneadmin  OPR/94.0.4606.54  403  spatne heslo


*** Keywords ***
Prihlaseni
    [Arguments]         ${username}        ${password}      ${userAgent}    ${error_resp}       ${reason}
    Prihlaseni Ciste  "${username}"  "${password}"  "${userAgent}"  ${error_resp}  ${reason}

Prihlaseni ciste
    [Arguments]         ${username}        ${password}      ${userAgent}    ${error_resp}       ${reason}

    &{header}=          Create Dictionary   Content-Type=application/json
    ${json}=            Catenate    {"username":${username},"password":${password},"useragent":${userAgent}}
    ${json_utf8} =      Encode String To Bytes     ${json}     UTF-8
    Log To Console      request: ${json_utf8}
    ${resp} =           POST  ${urlapp}  data=${json_utf8}  expected_status=anything
    Log To Console      response: ${resp.json()}

    Should Be Equal As Integers  ${resp.json()}[response]  ${error_resp}
    Should Be Equal     ${resp.json()}[reason]  ${reason}

