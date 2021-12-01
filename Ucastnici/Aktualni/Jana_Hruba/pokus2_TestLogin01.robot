"""

Cvičení 01
poznámka: Mezi trojté uvozovky se píší víceřádkové komentáře

Tento příklad potřebuje robotframework-requests balíček
instalace:
pip install robotframework-requests

Testovací Data - tento test používá následují testovací data - přihlašovací údaje
Login admin
Heslo a
Login jhruba
Heslo a
adresa api je http://cswworkflow:81/login.aspx?ReturnUrl=Default.aspx?

"""
# kratký komentář


*** Settings ***
Library	Collections
Library	RequestsLibrary


*** Variables ***
${url}		http://cswworkflow:81/login.aspx?ReturnUrl=Default.aspx?


*** Test Cases ***
Login overeno v KS
    [Documentation]  	Uspesne prihlaseni s vnorenym navratovym kodem
    Login   admin       a   200


Login overeni po akci
    [Documentation]  	Uspesne prihlaseni s navratovym kodem po akci
    ${data}=   Login_V2   admin       a
    Dictionary Should Contain Value     ${data}      200

*** Keywords ***


Login
    [Arguments]    ${username}    ${password}   ${responce_code}
    ${json_string}=     catenate  {"username":"${username}","password":"${password}","useragent":"Chrome"}
    &{header}=    Create Dictionary    Content-Type=application/json
    CreateSession    apilogin    ${url}
    ${resp} =    Post on Session    apilogin    login_app/userauth.php  data=${json_string}  headers=${header}
    Log	Responce: @{resp}
    Should Be Equal As Strings	${resp.status_code}     200
    Dictionary Should Contain Item	${resp.json()}      response    ${responce_code}



Login_V2
    [Arguments]    ${username}    ${password}
    ${json_string}=     catenate  {"username":"${username}","password":"${password}","useragent":"Chrome"}
    &{header}=    Create Dictionary    Content-Type=application/json
    CreateSession    apilogin    ${url}
    ${resp} =    Post on Session    apilogin    login_app/userauth.php  data=${json_string}  headers=${header}
    Log	Responce: @{resp}
    [return]  ${resp.json()}




