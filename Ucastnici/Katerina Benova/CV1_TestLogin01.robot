
# víceřádkové komentáře
# vlastní zkratka Ctrl+Shift+ú
# nebo """ a """ ale to není tak úplně podporovaný v Pycharmu

Jakýkoliv text na začátku souboru je ignorovaný, protože nemá žádné klíčové slovo.
IntelliBot ho obarví na šedo, jako skutečné komentáře s #


# kratký komentář

*** Settings ***
Library	Collections
Library	RequestsLibrary


*** Variables ***
${url}		http://testovani.kitner.cz/
${url2}  https://cloud.memsource.com/web/api2/
${password}     ***

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


Login NotOK overeni po akci
    [Documentation]  	Uspesne prihlaseni s navratovym kodem po akci
    ${data}=   Login_V2   novak       tajne
    Dictionary Should Contain Value     ${data}      403


#######  moje aplikace  ##############

#Tohle funguje se správným heslem (heslo záměrně odtraněno)
Login Memsource
    [Documentation]     Uspesne prihlaseni s odpovedi
    ${data}=    Login_V3    jane.brown   ${password}
    Dictionary Should Contain Key     ${data}      token


Login notOK Memsource
    [Documentation]     Neuspesne prihlaseni s odpovedic
    ${data}=    Login_V3    benkat  abc
    Status Should Be  401


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


Login_V3
    [Arguments]    ${username}    ${password}
    ${json_string}=    catenate    {"userName":"${username}","password":"${password}"}
    &{header}=    Create Dictionary    Content-Type=application/json
    CreateSession    apilogin    ${url2}
    ${resp} =   POST On Session  apilogin  v1/auth/login  data=${json_string}  headers=${header}  expected_status=Anything
    Log	Response: @{resp}
    [return]    ${resp.json()}
    # dotaz na HTTPS vyvolá warning:
    # InsecureRequestWarning: Unverified HTTPS request is being made to host 'cloud.memsource.com'.
    # Adding certificate verification is strongly advised.

