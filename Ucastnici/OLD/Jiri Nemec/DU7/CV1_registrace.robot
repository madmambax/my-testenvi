*** Settings ***
Library	        Collections
Library	        RequestsLibrary
Library         String
Resource        TestData.robot


*** Variables ***
${url}		        http://testovani.kitner.cz/
${app}              /regkurz/formsave.php
${urlapp}           ${url}${app}


*** Test Cases ***



Registrace na kurz fyzicka osoba
    Registrace na kurz  2  Frantisek  Dobrota  frantisek.dobrota@blizka.cz  777123123  fyz  Blizka 21, Blizka  1  komentar  false  200

Registrace na kurz pravnicka osoba
    Registrace na kurz  2  Frantisek  Dobrota  frantisek.dobrota@blizka.cz  777123123  pra  27232433  1  dekuji  false  200

Registrace na kurz háčky a čárky
    Registrace na kurz  2  Janěščřžýáíéů  Dobrotaěščřžýáíéů  frantisek.dobrota@blizka.cz  777123123  fyz  Udolniěščřžýáíéů, Brno  1  nic  false  200

registrace chybny telefon (specialni znak)
    Registrace na kurz   2  Frantisek  Dobrota  frantisek.dobrota@blizka.cz  ¶  fyz  Blizka 21, Blizka  1  komentar  false  500

registrace telefonu s predvolbou statu +420
    Registrace na kurz   2  Frantisek  Dobrota  frantisek.dobrota@blizka.cz  +420777666555  fyz  Blizka 21, Blizka  1  komentar  false  200

registrace telefonu s predvolbou statu 00420
    Registrace na kurz   2  Frantisek  Dobrota  frantisek.dobrota@blizka.cz  00420777666555  fyz  Blizka 21, Blizka  1  komentar  false  500

registrace telefonu se slovenskou předvolbou
    Registrace na kurz   2  Frantisek  Dobrota  frantisek.dobrota@blizka.cz  +421777666555  fyz  Blizka 21, Blizka  1  komentar  false  200

registrace telefonu se slovenskou předvolbou
    Registrace na kurz   2  Frantisek  Dobrota  frantisek.dobrota@blizka.cz  00421777666555  fyz  Blizka 21, Blizka  1  komentar  false  500

registrace nulovy pocet ucastniku
    Registrace na kurz  2  Frantisek  Dobrota  frantisek.dobrota@blizka.cz  777123123  fyz  Blizka 21, Blizka  0  komentar  false  500

registrace znak misto poctu ucastniku
    Registrace na kurz  2  Frantisek  Dobrota  frantisek.dobrota@blizka.cz  777123123  fyz  Blizka 21, Blizka  a  komentar  false  500

registrace prazdne tel cislo
    Registrace na kurz  2  Frantisek  Dobrota  frantisek.dobrota@blizka.cz  ${EMPTY}  fyz  Blizka 21, Blizka  1  komentar  false  500

registrace tel cislo null
    Registrace Na Kurz Bezuvozovek    2  "Frantisek"  "Dobrota"  "frantisek.dobrota@blizka.cz"  null  "fyz"  "Blizka 21, Blizka"  1  "komentar"  false  500

registrace na kurz jmeno null
    Registrace Na Kurz Bezuvozovek    2  null  "Dobrota"  "frantisek.dobrota@blizka.cz"  123456789  "fyz"  "Blizka 21, Blizka"  1  "komentar"  false  500

registrace na kurz jmeno prazdne (spatny format)
    Registrace Na Kurz Bezuvozovek    2  ${EMPTY}  "Dobrota"  "frantisek.dobrota@blizka.cz"  123456789  "fyz"  "Blizka 21, Blizka"  1  "komentar"  false  500

registrace na kurz prijmeni null
    Registrace Na Kurz Bezuvozovek    2  "Frantisek"  null  "frantisek.dobrota@blizka.cz"  123456789  "fyz"  "Blizka 21, Blizka"  1  "komentar"  false  500


registrace na kurz adresa null
    Registrace Na Kurz Bezuvozovek    2  "Frantisek"  "Dobrota"  "frantisek.dobrota@blizka.cz"  123456789  "fyz"  null  1  "komentar"  false  500

registrace na kurz komentar null
    Registrace Na Kurz Bezuvozovek    2  "Frantisek"  "Dobrota"  "frantisek.dobrota@blizka.cz"  123456789  "fyz"  "Blizka 21, Blizka"  1  null  false  200




*** Keywords ***


Registrace na kurz
    [Arguments]    ${kurz}  ${name}  ${surname}  ${email}  ${phone}  ${person}  ${address_ico}  ${count}  ${comment}  ${souhlas}  ${error_resp}

    Registrace na kurz bezuvozovek  ${kurz}  "${name}"  "${surname}"  "${email}"  "${phone}"  "${person}"  "${address_ico}"  ${count}  "${comment}"  ${souhlas}  ${error_resp}


Registrace na kurz bezuvozovek
    [Arguments]    ${kurz}  ${name}  ${surname}  ${email}  ${phone}  ${person}  ${address_ico}  ${count}  ${comment}  ${souhlas}  ${error_resp}

    # vytvoření těla (body) zprávy
    IF    ${person} == "fyz"
        ${json}=     Catenate    {"targetid":"","kurz":${kurz},"name":${name},"surname":${surname},"email":${email},"phone":${phone},"person":${person},"address":${address_ico},"ico":"","count":${count},"comment":${comment},"souhlas":${souhlas}}
    ELSE
        ${json}=     Catenate    {"targetid":"","kurz":${kurz},"name":${name},"surname":${surname},"email":${email},"phone":${phone},"person":${person},"address":"","ico":${address_ico},"count":${count},"comment":${comment},"souhlas":${souhlas}}
    END

    #převedení do UTF-8
    ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8      #vyžaduje knihovnu String
    Log                json: ${json_utf8}

    Log To Console    json: ${json_utf8}
    #vytoření hlavičky (header) zprávy
    &{header}=          Create Dictionary   Content-Type=application/json

    # odeslání zprávy a uložení odpovědi do ${resp}
    ${resp} =           POST  ${urlapp}  data=${json_utf8}  expected_status=${error_resp}
    Log	                Responce: @{resp}
#
#    #vyhodnocení status kódu
    Status Should Be    ${error_resp}
#
#    #vyhodnocení JSONu stačí jen vyhodnotit klíč response a jeho hodnotu
#    Should Be Equal As Integers    ${resp.status_code}  ${error_resp}
    Should Be Equal As Integers    ${resp.json()}[response]  ${error_resp}

