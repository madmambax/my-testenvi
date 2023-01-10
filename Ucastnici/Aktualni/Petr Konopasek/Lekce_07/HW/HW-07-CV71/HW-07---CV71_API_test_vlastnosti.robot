"""
HW07 ----- CV71_API_test_vlastnosti.robot
"""

*** Settings ***
Library	        Collections
Library	        RequestsLibrary
Library         String

*** Variables ***
${url}		        http://testovani.kitner.cz/
${app}              /regkurz/formsave.php
${urlapp}           ${url}${app}


*** Test Cases ***

Registrace na kurz pravnicka osoba
        Registrace na kurz  2  Jan787878  Novak  jan.novak@abc.cz  777123123  pra  27232433  1  1-test_resp200  false  200

Registrace na kurz diakritika
        Registrace na kurz  2  Janaščřýášřšáé  Novakováčřžýáíéů  jana.novak@abc.cz  777123123  fyz  Brno  1  2-test_resp200  false   200

Registrace na kurz spec.znaky
        Registrace na kurz  1  Nikos  Papado§§§§§§§*-+*/  jan.no@vak@abc.cz  777123123  fyz  ěšč#&řžýáíéů, Liberec  1  3-test_resp500  false    500

Registrace na kurz format emailu
        Registrace na kurz  2  Nikos  Papadopolus  Nikos.@@@@@abc.com  777123123  pra  27232433  1   4-test_resp500  false  500

Registrace na kurz format tel.číslo
        Registrace na kurz  2  Jan787878  Novak  jan.novak@abc.cz  +420777123123  pra  27232433  1   5-test_resp200  false  200

Registrace číslo kurzu
        Registrace na kurz  3  Jan787878  Novak  jan.novak@abc.cz  777123123  pra  27232433  1   6-test_resp200  false  200

Registrace checkbox
        Registrace na kurz  3  Jan787878  Novak  jan.novak@abc.cz  777123123  pra  27232433  1  7-test_resp200  true  200

Registrace - počet osob
        Registrace na kurz  1  IVan787878  Roupa  jan.novak@abc.cz  777123123  fyz  Praha, palmovka 2  99999999999999   8-test_resp200  false  200

*** Keywords ***

Registrace na kurz
    [Arguments]    ${course}   ${name}   ${surname}   ${email}   ${phone}   ${person}   ${address_ico}   ${count}   ${comment}   ${souhlas}   ${response_code}

    ${json}=   Catenate   {"targetid":"","kurz":"${course}","name":"${name}","surname":"${surname}","email":"${email}","phone":"${phone}","person":"${person}","address":"${address_ico}","ico":"${address_ico}","count":"${count}","comment":"${comment}","souhlas":${souhlas}}

    ${json_utf8} =                    Encode String To Bytes     ${json}     UTF-8
    &{header}=                        Create Dictionary   Content-Type=application/json
    ${resp} =                         POST  ${urlapp}   data=${json_utf8}  headers=${header}   expected_status=${response_code}
    Log	                              Responce: @{resp}
    Log To Console                    @{resp}

   #vyhodnocení status kódu
     Status Should Be                 ${\n}${response_code}
     Log to console                   ${\n}REASON: "${resp.reason}"${\n}
     Log                              ${\n}HEADERS: "${resp.headers}"${\n}
     Should Be Equal As Strings	      ${resp.status_code}                 ${response_code}
     Dictionary Should Contain Item	  ${resp.json()}          response    ${response_code}
     Should Contain                   ${resp.json()}[response]            ${response_code}
