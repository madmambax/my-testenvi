
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
        Registrace na kurz  2  Jan787878  Novak  jan.novak@abc.cz  777123123  pra  27232433  1  dekuji  false  200

Registrace na kurz háčky a čárky
        Registrace na kurz  2  Janěščřžýáíéů  Novakěščřžýáíéů  jan.novak@abc.cz  777123123  fyz  Udolniěščřžýáíéů, Brno  1  nic  false  200

Registrace na kurz specialni znaky
        Registrace na kurz  1  Janěščřž#&@ýáíéů  Novakěš#&čřžýáíéů  jan.no@vak@abc.cz  777123123  fyz  Udolniěšč#&řžýáíéů, Brno  1  nic  false  200
#neakceptuje
Registrace na kurz format email
        Registrace na kurz  2  Jan787878  Novak  jan.novak@abc.com  777123123  pra  27232433  1  dekuji  false  200

Registrace na kurz format tel.číslo
        Registrace na kurz  2  Jan787878  Novak  jan.novak@abc.cz  +420777123123  pra  27232433  1  dekuji  false  200

Registrace číslo kurzu
        Registrace na kurz  3  Jan787878  Novak  jan.novak@abc.cz  777123123  pra  27232433  1  dekuji  false  200

Registrace checkbox
        Registrace na kurz  3  Jan787878  Novak  jan.novak@abc.cz  777123123  pra  27232433  1  dekuji  true  200

Registrace na kurz počet osob
        Registrace na kurz  1  Jan787878  Novak  jan.novak@abc.cz  777123123  fyz  Praha, palmovka 2  10  dekuji  false  200





*** Keywords ***

Registrace na kurz
    [Arguments]    ${course}   ${name}   ${surname}   ${email}   ${phone}   ${person}   ${address_ico}   ${count}   ${comment}   ${souhlas}   ${responce_code}

    # vytvoření těla (body) zprávy
    ${json}=   Catenate   {"targetid":"","kurz":"${course}","name":"${name}","surname":"${surname}","email":"${email}","phone":"${phone}","person":"${person}","address":"${address_ico}","ico":"${address_ico}","count":"${count}","comment":"${comment}","souhlas":${souhlas}}

    #převedení do UTF-8
    ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8      #vyžaduje knihovnu String

    #vytoření hlavičky (header) zprávy
    &{header}=          Create Dictionary   Content-Type=application/json

    # odeslání zprávy a uložení odpovědi do ${resp}
    ${resp} =           POST  ${urlapp}   data=${json_utf8}  headers=${header}  expected_status= ${responce_code}
    Log	                Responce: @{resp}

    #vyhodnocení status kódu
    Should Be Equal As Integers   200  ${responce_code}
    Log  ${responce_code}

    #vyhodnocení JSONu stačí jen vyhodnotit klíč response a jeho hodnotu
    Dictionary Should Contain Key    ${resp.json()}     name
