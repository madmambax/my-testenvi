"""

Cvičení 01
poznámka: Mezi trojté uvozovky se píší víceřádkové komentáře

"""


*** Settings ***
Library	Collections
Library	RequestsLibrary


*** Variables ***
${url}		http://testovani.kitner.cz/


*** Test Cases ***
Login
    [Documentation]  	Uspesne prihlaseni
    Login   novak       tajnenovak  200




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
    





 