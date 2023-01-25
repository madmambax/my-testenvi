*** Settings ***
Library	 RequestsLibrary
Library  String
Library  Collections

Resource  configuration.robot

*** Keywords ***


Registrace na kurz
    [Arguments]  ${cislo_kurzu}  ${jmeno}  ${prijmeni}  ${email}  ${tel}  ${typ_osoby}  ${adresa_nebo_ico}  ${pocet}  ${komentar}  ${souhlas}  ${response}

    Log  ${jmeno}  ERROR

    # vytvoření těla (body) zprávy
    ${json}=   Catenate  {"targetid":"","kurz":"${cislo_kurzu}","name":"${jmeno}","surname":"${prijmeni}","email":"${email}","phone":"${tel}","person":"${typ_osoby}","address":"${adresa_nebo_ico}","ico":"${adresa_nebo_ico}","count":"${pocet}","comment":"${komentar}","souhlas":${souhlas}}

    #převedení do UTF-8
    ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8      #vyžaduje knihovnu String

    #vytoření hlavičky (header) zprávy
    &{header}=          Create Dictionary   Content-Type=application/json

    # odeslání zprávy a uložení odpovědi do ${resp}
    ${resp} =           POST  ${urlapp}  data=${json_utf8}  expected_status=${response}
    Log	                Response: @{resp}  ERROR

    #vyhodnocení status kódu
    Status Should Be    ${response}

    #vyhodnocení JSONu stačí jen vyhodnotit klíč response a jeho hodnotu
    Should Contain      ${resp.json()}[response]            ${response}