"""

Cvičení 01
poznámka: Mezi trojté uvozovky se píší víceřádkové komentáře

"""
#kratký komentář

*** Settings ***
Library	Collections
Library	RequestsLibrary


*** Variables ***
${url}		http://testovani.kitner.cz/


*** Test Cases ***
Login novak OK overeno v KS
    [Documentation]  	Uspesne prihlaseni s vnorenym navratovym kodem
    Login   novak       tajnenovak  200

Login novak notOK overeno v KS
    [Documentation]  	Uspesne prihlaseni s vnorenym navratovym kodem
    Login   novak       tajne   403

Login admin OK overeno v KS
    [Documentation]  	Uspesne prihlaseni s vnorenym navratovym kodem
    Login   admin       tajneadmin  200

Login admin notOK overeno v KS
    [Documentation]  	Uspesne prihlaseni s vnorenym navratovym kodem
    Login   admin       tajne   403


Login overeni po akci
    [Documentation]  	Uspesne prihlaseni s navratovym kodem po akci
    ${data}=   Login_V2   novak       tajnenovak
    Dictionary Should Contain Value     ${data}      200


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
    





 