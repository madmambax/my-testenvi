*** Settings ***
Library	        Collections
Library	        RequestsLibrary
Library         String
Library         JSONLibrary

*** Variables ***
${url}		        http://testovani.kitner.cz/
${app}              regkurz/formsave.php
${urlapp}           ${url}${app}

*** Test Cases ***
Registrace na kurz fyzicka osoba
    ${json_data}=       Registrace na kurz  2  Jan787878  Novak  jan.novak@abc.cz  777123123  fyz  Udolni 21, Brno  1  komentar  false
    Log                 ${json_data}
    Send API Data       ${json_data}        200

Registrace na kurz pravnicka osoba
    ${json_data}=       Registrace na kurz  2  Jan787878  Novak  jan.novak@abc.cz  777123123  pra  27232433  1  dekuji  false
    Log                 ${json_data}
    Send API Data       ${json_data}        200

Registrace na kurz háčky a čárky
    ${json_data}=       Registrace na kurz  2  Janěščřžýáíéů  Novakěščřžýáíéů  jan.novak@abc.cz  777123123  fyz  Udolniěščřžýáíéů, Brno  1  nic  false
    Log                 ${json_data}
    Send API Data       ${json_data}        200

*** Keywords ***
Registrace na kurz
    [Arguments]     ${kurz}      ${name}     ${surname}      ${email}     ${phone}     ${person}     ${address_ico}     ${count}     ${comment}     ${souhlas}

    &{data}=            Create Dictionary    targetid=""    kurz=${kurz}   name=${name}    surname=${surname}    email=${email}    phone=${phone}    person=${person}    address=${address_ico}    ico=${address_ico}    count=${count}    comment=${comment}    souhlas=${souhlas}

    ${json_data}=       Convert Json To String      ${data}

    Log                 ${json_data}
    [return]            ${json_data}

Send API Data
    [Arguments]         ${json_data}        ${status}

    #převedení do UTF-8
    ${json_utf8} =     Encode String To Bytes     ${json_data}     UTF-8      #vyžaduje knihovnu String

    #vytoření hlavičky (header) zprávy
    &{header}=          Create Dictionary         Content-Type=application/json

    # odeslání zprávy a uložení odpovědi do ${resp}
    ${resp} =           POST        ${urlapp}      data=${json_utf8}    expected_status=${status}

    Log	                Response: @{resp}
    Log                 ${resp.json()}

    #vyhodnocení status kódu
    Status Should Be        ${status}

    #vyhodnocení JSONu stačí jen vyhodnotit klíč response a jeho hodnotu

