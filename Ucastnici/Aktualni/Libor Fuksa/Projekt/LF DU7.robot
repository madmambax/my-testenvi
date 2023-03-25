*** Settings ***
Library	        Collections
Library	        RequestsLibrary
Library         String
Resource        Data/LFDU7_TestData.robot




*** Variables ***
${urlapp}           ${url}${app}


*** Test Cases ***

Registrace OK - IF - pravnicka osoba
    registrace na kurz s IF    200   2       Jan787878      Novak       jan.novak@abc.cz  777123123  pra  ${ICO_VALID}   1  dekuji  false

Registrace OK - IF - soukroma osoba
    registrace na kurz s IF    200   2       Jan787878      Novak       jan.novak@abc.cz  777123123  FYz  Liberec, U divných 13   1  dekuji  false

Registrace OK - seznam - FYZ - bez commentu
  Registrace na kurz    response_code=200      response_body=200       kurz=2       jmeno=Tomas       prijmeni=Marný        e-mail=jan.novak@abc.cz       telefon=777123123   osoba_druh=fyz     adresa=Udolni 21,Brno    ico=${empty}  count=1   comment=${empty}    souhlas=true

Registrace OK - seznam - PRA - bez commentu
  Registrace na kurz    response_code=200      response_body=200       kurz=2       jmeno=Tomáš137    prijmeni=Marný        e-mail=jan.novak@abc.cz       telefon=777123123   osoba_druh=Pra     adresa=${empty}    ico=${ICO_VALID}  count=1   comment=${empty}    souhlas=true

Registrace OK - seznam - FYZ - háčky čárky
  Registrace na kurz    response_code=200      response_body=200       kurz=2       jmeno=Tomas       prijmeni=Marný        e-mail=jan.novak@abc.cz       telefon=777123123   osoba_druh=fyz     adresa=Udolni 21,Brno    ico=${empty}  count=1   comment=${comment1}    souhlas=true

registrace NOK - "kurz" s hodnotou 0
  Registrace na kurz    response_code=500      response_body=500       kurz=0       jmeno=Tomas       prijmeni=Marný        e-mail=jan.novak@abc.cz       telefon=777123123   osoba_druh=fyz     adresa=Udolni 21,Brno    ico=${empty}  count=1   comment=${comment1}    souhlas=true

registrace NOK - "kurz" mimo hodnoty 1-3 (hodnota 4)
  Registrace na kurz    response_code=500      response_body=500       kurz=4      jmeno=Tomas       prijmeni=Marný        e-mail=jan.novak@abc.cz       telefon=777123123   osoba_druh=fyz     adresa=Udolni 21,Brno    ico=${empty}  count=1   comment=${comment1}    souhlas=true

registrace NOK - "kurz" prazdne
  Registrace na kurz    response_code=500      response_body=500       kurz=${EMPTY}       jmeno=Tomas       prijmeni=Marný        e-mail=jan.novak@abc.cz       telefon=777123123   osoba_druh=fyz     adresa=Udolni 21,Brno    ico=${empty}  count=1   comment=${comment1}    souhlas=true

registrace NOK - "name" prázdné
  Registrace na kurz    response_code=500      response_body=500       kurz=2       jmeno=${EMPTY}       prijmeni=Marný        e-mail=jan.novak@abc.cz       telefon=777123123   osoba_druh=fyz     adresa=Udolni 21,Brno    ico=${empty}  count=1   comment=${comment1}    souhlas=true

registrace OK - "name" 1000 znaků
  Registrace na kurz    response_code=200      response_body=200       kurz=2       jmeno=${hodneznaku}       prijmeni=Marný        e-mail=jan.novak@abc.cz       telefon=777123123   osoba_druh=fyz     adresa=Udolni 21,Brno    ico=${empty}  count=1   comment=${comment1}    souhlas=true

registrace OK - "name" s mezerou
  Registrace na kurz    response_code=200      response_body=200        kurz=2       jmeno=${name_s_mezerou}       prijmeni=Marný        e-mail=jan.novak@abc.cz       telefon=777123123   osoba_druh=fyz     adresa=Udolni 21,Brno    ico=${empty}  count=1   comment=${comment1}    souhlas=true

registrace OK - "surname" prázdný
  Registrace na kurz    response_code=500      response_body=500        kurz=2       jmeno=Tomas       prijmeni=${empty}        e-mail=jan.novak@abc.cz       telefon=777123123   osoba_druh=fyz     adresa=Udolni 21,Brno    ico=${empty}  count=1   comment=${comment1}    souhlas=true

registrace OK - "surname" 1000 znaků
  Registrace na kurz    response_code=200      response_body=200        kurz=2       jmeno=Tomas       prijmeni=${hodneznaku}        e-mail=jan.novak@abc.cz       telefon=777123123   osoba_druh=fyz     adresa=Udolni 21,Brno    ico=${empty}  count=1   comment=${comment1}    souhlas=true

registrace OK - "e-mail" krátký
  Registrace na kurz    response_code=200      response_body=200        kurz=2       jmeno=Tomas       prijmeni=Marný        e-mail=${email_kratky}       telefon=777123123   osoba_druh=fyz     adresa=Udolni 21,Brno    ico=${empty}  count=1   comment=${comment1}    souhlas=true

registrace NOK - "e-mail" chybí část před doménou
  Registrace na kurz    response_code=500      response_body=500        kurz=2       jmeno=Tomas       prijmeni=Marný        e-mail=${email_NOK_uziv_jmeno}       telefon=777123123   osoba_druh=fyz     adresa=Udolni 21,Brno    ico=${empty}  count=1   comment=${comment1}    souhlas=true

registrace NOK - "e-mail" chybí zavináč
  Registrace na kurz    response_code=500      response_body=500        kurz=2       jmeno=Tomas       prijmeni=Marný        e-mail=${email_NOK_chybi-@}       telefon=777123123   osoba_druh=fyz     adresa=Udolni 21,Brno    ico=${empty}  count=1   comment=${comment1}    souhlas=true

registrace NOK - "e-mail" chybí "."
  Registrace na kurz    response_code=500      response_body=500        kurz=2       jmeno=Tomas       prijmeni=Marný        e-mail=${email_NOK_chybi-.}       telefon=777123123   osoba_druh=fyz     adresa=Udolni 21,Brno    ico=${empty}  count=1   comment=${comment1}    souhlas=true

registrace NOK - "e-mail" chybí doménová přípona
  Registrace na kurz    response_code=500      response_body=500        kurz=2       jmeno=Tomas       prijmeni=Marný        e-mail=${email_NOK_chybi-pripona}       telefon=777123123   osoba_druh=fyz     adresa=Udolni 21,Brno    ico=${empty}  count=1   comment=${comment1}    souhlas=true

Registrace OK - "phone" predvolba +420
  Registrace na kurz    response_code=200      response_body=200       kurz=2       jmeno=Tomas       prijmeni=Marný        e-mail=jan.novak@abc.cz       telefon=${phone_+420}   osoba_druh=fyz     adresa=Udolni 21,Brno    ico=${empty}  count=1   comment=${empty}    souhlas=true

registrace NOK - "phone" 13 číslic
  Registrace na kurz    response_code=500      response_body=500       kurz=2       jmeno=Tomas       prijmeni=Marný        e-mail=jan.novak@abc.cz       telefon=${phone_13cislic}   osoba_druh=fyz     adresa=Udolni 21,Brno    ico=${empty}  count=1   comment=${empty}    souhlas=true

registrace NOK - "phone" 8 číslic
  Registrace na kurz    response_code=500      response_body=500       kurz=2       jmeno=Tomas       prijmeni=Marný        e-mail=jan.novak@abc.cz       telefon=${phone_8cislic}   osoba_druh=fyz     adresa=Udolni 21,Brno    ico=${empty}  count=1   comment=${empty}    souhlas=true

registrace NOK - "phone" 10 číslic
  Registrace na kurz    response_code=500      response_body=500       kurz=2       jmeno=Tomas       prijmeni=Marný        e-mail=jan.novak@abc.cz       telefon=${phone_10cislic}   osoba_druh=fyz     adresa=Udolni 21,Brno    ico=${empty}  count=1   comment=${empty}    souhlas=true

registrace NOK - "phone" písmeno
  Registrace na kurz    response_code=500      response_body=500       kurz=2       jmeno=Tomas       prijmeni=Marný        e-mail=jan.novak@abc.cz       telefon=${phone_char}   osoba_druh=fyz     adresa=Udolni 21,Brno    ico=${empty}  count=1   comment=${empty}    souhlas=true

registrace NOK - "phone" prázdné
  Registrace na kurz    response_code=200      response_body=500       kurz=2       jmeno=Tomas       prijmeni=Marný        e-mail=jan.novak@abc.cz       telefon=777123123   osoba_druh=fyz     adresa=Udolni 21,Brno    ico=${empty}  count=1   comment=${empty}    souhlas=true

registrace NOK - "person" not FYZ or PRA
  Registrace na kurz    response_code=200      response_body=500       kurz=2       jmeno=Tomas       prijmeni=Marný        e-mail=jan.novak@abc.cz       telefon=777123123   osoba_druh=kra     adresa=Udolni 21,Brno    ico=${ico_valid}  count=1   comment=${empty}    souhlas=true

registrace NOK - "person" prázdné
  Registrace na kurz    response_code=500      response_body=500       kurz=2       jmeno=Tomas       prijmeni=Marný        e-mail=jan.novak@abc.cz       telefon=777123123   osoba_druh=${EMPTY}     adresa=Udolni 21,Brno    ico=${ico_valid}  count=1   comment=${empty}    souhlas=true

registrace NOK - "address" prázdné
  Registrace na kurz    response_code=500      response_body=500       kurz=2       jmeno=Tomas       prijmeni=Marný        e-mail=jan.novak@abc.cz       telefon=777123123   osoba_druh=fyz     adresa=${EMPTY}    ico=${empty}  count=1   comment=${empty}    souhlas=true

registrace OK - "address" 1000 znaků
  Registrace na kurz    response_code=200      response_body=200       kurz=2       jmeno=Tomas       prijmeni=Marný        e-mail=jan.novak@abc.cz       telefon=777123123   osoba_druh=fyz     adresa=${hodneznaku}    ico=${empty}  count=1   comment=${empty}    souhlas=true

registrace NOK - "ICO" prazdne + "person" pra
  Registrace na kurz    response_code=500      response_body=500       kurz=2       jmeno=Tomas       prijmeni=Marný        e-mail=jan.novak@abc.cz       telefon=777123123   osoba_druh=pra     adresa=${empty}    ico=${empty}  count=1   comment=${empty}    souhlas=true

registrace NOK - "ICO" pismeno
  Registrace na kurz    response_code=500      response_body=500       kurz=2       jmeno=Tomas       prijmeni=Marný        e-mail=jan.novak@abc.cz       telefon=777123123   osoba_druh=pra     adresa=${empty}    ico=${ico_invalid_char}  count=1   comment=${empty}    souhlas=true

registrace NOK - "ICO" spec znak (+)
  Registrace na kurz    response_code=500      response_body=500       kurz=2       jmeno=Tomas       prijmeni=Marný        e-mail=jan.novak@abc.cz       telefon=777123123   osoba_druh=pra     adresa=${empty}    ico=${ico_invalid_spec_char}  count=1   comment=${empty}    souhlas=true

registrace NOK - "count" empty
  Registrace na kurz    response_code=500      response_body=500       kurz=2       jmeno=Tomas       prijmeni=Marný        e-mail=jan.novak@abc.cz       telefon=777123123   osoba_druh=fyz     adresa=Udolni 21,Brno    ico=${empty}  count=${EMPTY}   comment=${empty}    souhlas=true

registrace NOK - "count" 0
  Registrace na kurz    response_code=500      response_body=500       kurz=2       jmeno=Tomas       prijmeni=Marný        e-mail=jan.novak@abc.cz       telefon=777123123   osoba_druh=fyz     adresa=Udolni 21,Brno    ico=${empty}  count=0   comment=${empty}    souhlas=true

registrace NOK - "count" char
  Registrace na kurz    response_code=500      response_body=500       kurz=2       jmeno=Tomas       prijmeni=Marný        e-mail=jan.novak@abc.cz       telefon=777123123   osoba_druh=fyz     adresa=Udolni 21,Brno    ico=${empty}  count=k   comment=${empty}    souhlas=true

registrace NOK - "count" spec znak
  Registrace na kurz    response_code=500      response_body=500       kurz=2       jmeno=Tomas       prijmeni=Marný        e-mail=jan.novak@abc.cz       telefon=777123123   osoba_druh=fyz     adresa=Udolni 21,Brno    ico=${empty}  count=$  comment=${empty}    souhlas=true

registrace NOK - "count" spec znak " "
  Registrace na kurz    response_code=500      response_body=500       kurz=2       jmeno=Tomas       prijmeni=Marný        e-mail=jan.novak@abc.cz       telefon=777123123   osoba_druh=fyz     adresa=Udolni 21,Brno    ico=${empty}  count=   comment=${empty}    souhlas=true

registrace OK - "souhlas" false
  Registrace na kurz    response_code=200      response_body=200       kurz=2       jmeno=Tomas       prijmeni=Marný        e-mail=jan.novak@abc.cz       telefon=777123123   osoba_druh=fyz     adresa=Udolni 21,Brno    ico=${empty}  count=1   comment=${empty}    souhlas=false

registrace NOK - "souhlas" prazdny
  Registrace na kurz    response_code=200      response_body=500       kurz=2       jmeno=Tomas       prijmeni=Marný        e-mail=jan.novak@abc.cz       telefon=777123123   osoba_druh=fyz     adresa=Udolni 21,Brno    ico=${empty}  count=1   comment=${empty}    souhlas=${EMPTY}

registrace NOK - "souhlas" False (velke F)
  Registrace na kurz    response_code=200      response_body=500       kurz=2       jmeno=Tomas       prijmeni=Marný        e-mail=jan.novak@abc.cz       telefon=777123123   osoba_druh=fyz     adresa=Udolni 21,Brno    ico=${empty}  count=1   comment=${empty}    souhlas=False


registrace NOK - chybny JSON - nekompletni JSON (chybějící klíč i hodnota "name")
  API Comunication      500     500     {"targetid":"","kurz":"2","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}
registrace NOK - chybny JSON - neuzavřený }
  API Comunication      500     500     {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true
registrace NOK - chybny JSON - chybi v klici kurz "
  API Comunication      500     500     {"targetid":"",kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true
registrace NOK - chybny JSON - chybi v hodnote klice kurz "
  API Comunication      500     500     {"targetid":"","kurz":"2,"name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true
registrace NOK - chybny JSON - chybi v u klice kurz :
  API Comunication      500     500     {"targetid":"","kurz""2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true
registrace NOK - chybny JSON - pridany klic a hodnota
  API Comunication      500     500     {"novy klic":"hoj","targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"pokus153.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}
registrace NOK - chybny JSON - zdvojeny klic a hodnota "name"
  API Comunication      500     500     {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"teset1877.novak@abc.cz","phone":"608123123","name":"Franta","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}

*** Keywords ***

Registrace na kurz s IF
    [Arguments]    ${response_code}     ${kurz}    ${jmeno}    ${prijmeni}  ${e-mail}  ${telefon}  ${osoba_druh}  ${adresa_ico}  ${count}    ${comment}  ${souhlas}

    ${osoba_druh_lower}=     Convert To Lower Case  ${osoba_druh}

   IF  "${osoba_druh_lower}" == "fyz"
        ${json}=      Catenate  {"targetid":"","kurz":"${kurz}","name":"${jmeno}","surname":"${prijmeni}","email":"${e-mail}","phone":"${telefon}","person":"${osoba_druh}","address":"${adresa_ico}","ico":"","count":"${count}","comment":"${comment}","souhlas":"${souhlas}"}
        Log To Console    BYLA TO FYZICKA OSOBA S adresou "${adresa_ico}"
    ELSE
        ${json}=      Catenate  {"targetid":"","kurz":"${kurz}","name":"${jmeno}","surname":"${prijmeni}","email":"${e-mail}","phone":"${telefon}","person":"${osoba_druh}","address":"","ico":"${adresa_ico}","count":"${count}","comment":"${comment}","souhlas":"${souhlas}"}
        Log To Console    BYLA TO PRAVNICKA OSOBA - jeji ICO ${adresa_ico}
    END

    ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8      #vyžaduje knihovnu String

    &{header}=          Create Dictionary   Content-Type=application/json

    ${resp} =           POST  ${urlapp}  data=${json_utf8}  expected_status=${response_code}
    Log	                Responce: @{resp}

    Should Be Equal     ${resp.json()}[response]    ${response_code}
    Log                 BODY RESPONSE : ${resp.json()}[response]


Registrace na kurz
    [Arguments]    ${kurz}    ${jmeno}    ${prijmeni}  ${e-mail}  ${telefon}  ${osoba_druh}  ${adresa}  ${ico}    ${count}    ${comment}  ${souhlas}   ${response_code}     ${response_body}

    ${json}=      Catenate  {"targetid":"","kurz":"${kurz}","name":"${jmeno}","surname":"${prijmeni}","email":"${e-mail}","phone":"${telefon}","person":"${osoba_druh}","address":"${adresa}","ico":"${ico}","count":"${count}","comment":"${comment}","souhlas":"${souhlas}"}
    log to console  JSON : ${json}

    #převedení do UTF-8
    ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8      #vyžaduje knihovnu String

    #vytoření hlavičky (header) zprávy
    &{header}=          Create Dictionary   Content-Type=application/json

    # odeslání zprávy a uložení odpovědi do ${resp}
    ${resp} =           POST  ${urlapp}  data=${json_utf8}  expected_status=${response_code}

    Log	                Response: @{resp}
    Status Should Be    ${response_code}
    Should Be Equal     ${resp.json()}[response]    ${response_code}
    Log                 Body response code : ${resp.json()}[response]

API Comunication
    [Arguments]      ${error_resp}     ${body_response}  ${json}

    #převedení do UTF-8
    ${json_utf8} =      Encode String To Bytes     ${json}     UTF-8          #vyžaduje knihovnu String

    ${resp} =           POST  ${urlapp}  data=${json_utf8}  expected_status=${error_resp}
    Log to console      RESPONSE: ${resp}
#    Log                 ${resp.json()}
    Log                 ${resp.json()}[response]
    Status Should Be    ${error_resp}
    Should Be Equal     ${resp.json()}[response]    ${body_response}

