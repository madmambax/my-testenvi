#DÚ 07 Přihlašovací formulář http://testovani.kitner.cz/login_app/

*** Settings ***
Library	        Collections
Library	        RequestsLibrary
Library         String
#Resource        TestData.robot


*** Variables ***
${url}		        http://testovani.kitner.cz/
${app}              /login_app/userauth.php
${urlapp}           ${url}${app}


*** Test Cases ***

Prihlaseni OK Chrome
    Login   admin   tajneadmin   Chrome 111.0.5563.111   200

Prihlaseni OK Firefox
    Login   admin   tajneadmin   Firefox 111.0.1  200
#nedojde k prihlaseni, prestoze by melo - FAIL

Prihlaseni 2 OK Chrome
    Login   novak   tajnenovak   Chrome   200

Prihlaseni 2 OK Firefox
    Login   novak   tajnenovak   Firefox 111.0.1   200

Prihlaseni NOT OK, spatny username
    Login   spatnyusername   tajneadmin   Chrome 111.0.5563.111   403

Prihlaseni NOT OK, spatne password
    Login   admin   spatnepassword   Chrome 111.0.5563.111   403

Prihlaseni NOT OK, nevyplnene username
    Login   ${EMPTY}   tajneadmin   Chrome 111.0.5563.111   403

Prihlaseni NOT OK, nevyplnene password
    Login   admin   ${EMPTY}   Chrome 111.0.5563.111   403

Prihlaseni NOT OK, nevyplnene username a password
    Login   ${EMPTY}   ${EMPTY}   Chrome 111.0.5563.111   403


*** Keywords ***

Login
    [Arguments]    ${username}  ${password}  ${useragent}  ${response_code}

    # vytvoření těla (body) zprávy

    ${json}=     Catenate      {"username":"${username}","password":"${password}","useragent":"${useragent}"}

    #převedení do UTF-8
    ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8      #vyžaduje knihovnu String

    #vytoření hlavičky (header) zprávy
    &{header}=          Create Dictionary   Content-Type=application/json

    # odeslání zprávy a uložení odpovědi do ${resp}
    ${resp} =           POST  ${urlapp}   data=${json_utf8}   headers=${header}   expected_status=200
    Log	                Response: @{resp}

    #vyhodnocení status kódu
    Status should be    200

    #nebo
    #Should Be Equal As Strings	    ${resp.status_code}     ${responce_code}

    #vyhodnocení JSONu klíč response
    Should Contain      ${resp.json()}[response]            ${response_code}

    #nebo
    #Dictionary Should Contain Item	${resp.json()}          response    ${responce_code}
