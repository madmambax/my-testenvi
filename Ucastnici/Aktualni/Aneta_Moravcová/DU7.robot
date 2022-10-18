*** Settings ***

Library	         Collections
Library          JSONLibrary
Library	         RequestsLibrary
Library          String


*** Variables ***

${url}          http://testovani.kitner.cz/
${app}          regkurz/formsave.php
${urlapp}       ${url}${app}


*** Test Cases ***

Registrace na kurz - fyzicka osoba
     ${json_data} =     Registrace na kurz     1     Jan    Novak     jan.novak@email.cz     777123456     fyz     Udolni 21, Brno     1     nic     false
     Log                ${json_data}
     Send API Data      ${json_data}     200

Registrace na kurz - pravnicka osoba
     ${json_data} =     Registrace na kurz     1     Jan     Novak     jan.novak@email.cz     777123456     pra      27232433     1     nic     false
     Log                ${json_data}
     Send API Data      ${json_data}     200

Registrace na kurz - hacky a carky
     ${json_data} =     Registrace na kurz     1     Jan     Novák     jan.novak@email.cz     777123456     fyz     Udolní 21, Brno     1     nic     false
     Log                ${json_data}
     Send API Data      ${json_data}      200

Registrace na kurz - chybny format e-mailu
     ${json_data} =     Registrace na kurz     1     Jan     Novák     jan.novakemail.cz     777123456     fyz     Udolní 21, Brno     1     nic     false
     Log                ${json_data}
     Send API Data      ${json_data}      500

Registrace na kurz - chybny format telefonniho cisla
     ${json_data} =     Registrace na kurz     1     Jan     Novák     jan.novak@email.cz     ABCDEFGHI     fyz     Udolní 21, Brno     1     nic     false
     Log                ${json_data}
     Send API Data      ${json_data}      500

Registrace na kurz - prilis dlouhe telefonni cislo
     ${json_data} =     Registrace na kurz     1     Jan     Novák     jan.novak@email.cz     777123456789     fyz     Udolní 21, Brno     1     nic     false
     Log                ${json_data}
     Send API Data      ${json_data}      500

Registrace na kurz - chybny format ICO
     ${json_data} =     Registrace na kurz     1     Jan     Novák     jan.novak@email.cz     777123456     pra     ABCDEFGH     1     nic     false
     Log                ${json_data}
     Send API Data      ${json_data}      500


*** Keywords ***

Registrace na kurz
     [Arguments]     ${kurz}     ${jmeno}     ${prijmeni}      ${email}     ${telefon}     ${osoba}     ${adresa_ico}     ${pocet_osob}     ${komentar}     ${souhlas}

     &{data} =       Create Dictionary     targetid=""     kurz=${kurz}     name=${jmeno}     surname=${prijmeni}     email=${email}     phone=${telefon}     person=${osoba}     address=${adresa_ico}     ico=${adresa_ico}     count=${pocet_osob}     comment=${komentar}     souhlas=${souhlas}}
     ${json_data} =  Convert Json To String     ${data}
     Log             ${json_data}
     [return]        ${json_data}

Send API Data
     [Arguments]     ${json_data}     ${error_resp}

     ${json_utf8} =     Encode String To Bytes     ${json_data}     UTF-8
     &{header} =        Create Dictionary     Content-Type=application/json
     ${resp} =          POST     ${urlapp}     data=${json_utf8}     expected_status=${error_resp}
     Log	            Response: @{resp}
     Log                ${resp.json()}
     Status Should Be   ${error_resp}