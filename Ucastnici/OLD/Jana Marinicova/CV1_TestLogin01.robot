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
${url}		http://testovani.kitner.cz/




*** Test Cases ***
Login overeno v KS
    [Documentation]  	Uspesne prihlaseni s vnorenym navratovym kodem
    Login   novak       tajnenovak  200

Login overeno v KS
    [Documentation]  	Neuspesne prihlaseni se spatnym heslem s vnorenym navratovym kodem
    Login   novak       tajneNovak  403

Login uspech
    [Documentation]  	Uspesne prihlaseni s navratovym kodem po akci
    ${data}=   Login_V2   novak       tajnenovak
    Dictionary Should Contain Value     ${data}      200

Login neuspech
    [Documentation]  	Neuspesne prihlaseni se spatnym heslem s navratovym kodem po akci
    ${data}=   Login_V2   novak       @
    Dictionary Should Contain Value     ${data}      403

Login prazdne heslo
    [Documentation]  	Neuspesne prihlaseni s prazdnim heslem s navratovym kodem po akci
    ${data}=   Login_V2   novak     ""
    Dictionary Should Contain Value     ${data}      403





*** Keywords ***


Login
    [Arguments]    ${username}    ${password}   ${responce_code}
    ${json_string}=     catenate  {"username":"${username}","password":"${password}","useragent":"Chrome"}
    &{header}=    Create Dictionary    Content-Type=application/json
    CreateSession    apilogin    ${url}
    ${resp} =    Post Request    apilogin    login_app/userauth.php  data=${json_string}  headers=${header}
    Log	Responce: @{resp}
    Should Be Equal As Strings	${resp.status_code}     200
    Dictionary Should Contain Key	${resp.json()}      response
    Dictionary Should Contain Value	${resp.json()}      ${responce_code}



Login_V2
    [Arguments]    ${username}    ${password}
    ${json_string}=     catenate  {"username":"${username}","password":"${password}","useragent":"Chrome"}
    &{header}=    Create Dictionary    Content-Type=application/json
    CreateSession    apilogin    ${url}
    ${resp} =    Post Request    apilogin    login_app/userauth.php  data=${json_string}  headers=${header}
    Log	Responce: @{resp}
    [return]  ${resp.json()}
    





 