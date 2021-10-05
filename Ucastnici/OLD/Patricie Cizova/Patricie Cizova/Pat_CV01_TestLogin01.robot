"""

Cvičení 01
poznámka: Mezi trojté uvozovky se píší víceřádkové komentáře

Tento příklad potřebuje robotframework-requests balíček
instalace:
pip install robotframework-requests

Testovací Data - tento test používá následují testovací data - přihlašovací údaje
Login novak
Heslo tajnenovak
Login admin
Heslo tajneadmin
adresa api je http://testovani.kitner.cz/login_app/userauth.php

"""
#kratký komentář



*** Settings ***
Library	Collections
Library	RequestsLibrary


*** Variables ***
${url}		    http://testovani.kitner.cz/
${endpoint}     login_app/userauth.php
${responce_code} =      Set Variable         200
#${username} =      Set Variable     novak
${password} =      Set Variable     tajnenovak

*** Test Cases ***
Login novak overeno v KS
    [Documentation]  	Uspesne prihlaseni s vnorenym navratovym kodem
    Login   novak       tajnenovak  200
    Log to console      ${\n}Adresa aplikace: ${url}
    Log                 ${responce_code}
    ${username} =       Set Variable     novak
    Log to console      ${username}
    Log                 ${password}

Login admin overeno v KS
    [Documentation]  	Uspesne prihlaseni s vnorenym navratovym kodem
    Login   admin       tajneadmin  200

Login novak overeno v KS notOK
    [Documentation]  	Neuspesne prihlaseni s vnorenym navratovym kodem
    Login   nova/k      tajnenovak  403
    Log to console      ${\n}Adresa aplikace včetně endpointu: ${url}${endpoint}

Login admin overeno v KS notOK
    [Documentation]  	Neuspesne prihlaseni s vnorenym navratovym kodem
    Login   admin       tajne/admin  403

Login overeni po akci
    [Documentation]  	Uspesne prihlaseni s navratovym kodem po akci
    ${data}=   Login_V2   novak       tajnenovak
    Dictionary Should Contain Value     ${data}      200

Login overeni po akci notOK
    [Documentation]  	Neuspesne prihlaseni s navratovym kodem po akci
    ${data}=   Login_V2   nova/k       tajnenovak
    Dictionary Should Contain Value     ${data}      403



*** Keywords ***


Login
    [Arguments]    ${username}    ${password}   ${responce_code}
    ${json_string}=     catenate  {"username":"${username}","password":"${password}","useragent":"Chrome"}
    &{header}=    Create Dictionary    Content-Type=application/json
    CreateSession    apilogin    ${url}
    ${resp} =    Post on Session    apilogin    login_app/userauth.php  data=${json_string}  headers=${header}
    Log	Responce: @{resp}
    Should Be Equal As Strings	${resp.status_code}     200
    Dictionary Should Contain Key	${resp.json()}      response
    Dictionary Should Contain Value	${resp.json()}      ${responce_code}



Login_V2
    [Arguments]    ${username}    ${password}
    ${json_string}=     catenate  {"username":"${username}","password":"${password}","useragent":"Chrome"}
    &{header}=    Create Dictionary    Content-Type=application/json
    CreateSession    apilogin    ${url}
    ${resp} =    Post on Session    apilogin    login_app/userauth.php  data=${json_string}  headers=${header}
    Log	Responce: @{resp}
    [return]  ${resp.json()}