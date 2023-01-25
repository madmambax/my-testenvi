*** Settings ***
Library	        Collections
Library	        RequestsLibrary
Library         String


*** Variables ***
${url}		        http://testovani.kitner.cz/
${app}              /login_app/userauth.php
${urlapp}           ${url}${app}


*** Test Cases ***

Login Chrome Successful
    Login  admin  tajneadmin  Chrome/108.0.0.0  200  correct

# This test is failing but it shouldn't
Login Mozilla Successful
    Login  admin  tajneadmin  Firefox/108.0  200  correct

# This test is failing but it shouldn't
Login Edge Successful
    Login  admin  tajneadmin  Edg/108.0.1462.76  200  correct

# This test is failing but it shouldn't
Login Safari Successful
    Login  admin  tajneadmin  Safari/537.36  200  correct

Login Incorrect Name Unsuccessful
    Login  test  tajneadmin  Chrome 108.0.5359.125  403  neexistujici uzivatel

Login Incorrect Password Unsuccessful
    Login  admin  test  Chrome 108.0.5359.125  403  spatne heslo

Login Incorrect Name And Password Unsuccessful
    Login  test  test  Chrome 108.0.5359.125  403  neexistujici uzivatel

Login Incorrect Useragent Unsuccessful
    Login  admin  tajneadmin  test  403  spatne heslo  #maybe better reason?


*** Keywords ***

Login
    [Arguments]  ${username}  ${password}  ${user_agent}  ${expected_status}  ${expected_reason}

    # vytvoření těla (body) zprávy
    ${json}=  Set Variable  {"username":"${username}","password":"${password}","useragent":"${user_agent}"}

    #převedení do UTF-8
    ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8      #vyžaduje knihovnu String

    #vytoření hlavičky (header) zprávy
    &{header}=          Create Dictionary   Content-Type=application/json

    # odeslání zprávy a uložení odpovědi do ${resp}
    ${resp} =           POST  ${urlapp}   data=${json}
    Log	                Responce: @{resp}

    #vyhodnocení status kódu
    Status Should Be    200

    #vyhodnocení JSONu stačí jen vyhodnotit klíč response a jeho hodnotu
    Should Be Equal  ${resp.json()}[response]  ${expected_status}
    Should Be Equal  ${resp.json()}[reason]  ${expected_reason}



