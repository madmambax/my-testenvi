*** Settings ***
Library	        Collections
Library	        RequestsLibrary
Library         String

*** Variables ***
${url}		        http://testovani.kitner.cz
${app}              /login_app/userauth.php
${urlapp}           ${url}${app}

*** Test Cases ***
Přihlášení do TestLoginu s dobrými údaji
    Prihlaseni      admin     tajneadmin    Chrome 106.0.5249.119       correct          200

Přihlášení do TestLoginu se špatným heslem
    Prihlaseni      admin     tajneadminn    Chrome 106.0.5249.119       spatne heslo       200

Přihlášení do TestLoginu se špatným jménem
    Prihlaseni      honzaK     tajneadmin    Chrome 106.0.5249.119       neexistujici uzivatel       200


*** Keywords ***
Prihlaseni
    [Arguments]     ${username}     ${password}     ${useragent}    ${reason}   ${status_kod}

    # vytvoření těla (body) zprávy
    ${json}=  catenate    {"username":"${username}","password":"${password}","useragent":"${useragent}"}

    #převedení do UTF-8
    ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8

    #vytoření hlavičky (header) zprávy
    &{header}=          Create Dictionary   Content-Type=application/json

    # odeslání zprávy a uložení odpovědi do ${resp}
    ${resp} =           POST      ${urlapp}  data=${json_utf8}   headers=${header}   expected_status=${status_kod}
    Log	                Response: ${resp}

    #vyhodnocení status kódu
    Status Should Be    ${status_kod}

    #vyhodnocení JSONu
    Log To Console    ${resp.json()}[reason]
    Should Be Equal      ${resp.json()}[reason]         ${reason}
