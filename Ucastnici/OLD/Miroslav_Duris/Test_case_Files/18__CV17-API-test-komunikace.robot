"""
CVIČENÍ 2: vytvořte další testy, 1 pozitivní a 1 negativní test
"""

*** Settings ***
Library	 RequestsLibrary
Library  String             # Potřebujeme kvůli klíč. slovu 'Encode String To Bytes'.
Library	 Collections

*** Variables ***
${url}		    http://testovani.kitner.cz/
${app}          /regkurz/formsave.php
${urlapp}       ${url}${app}    # Zajímavej způsob spojení stringů - 'Catanate' tady vnení potřeba.. Kde je vlastně 'Catanate' potřeba?

# ${json}      {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}
# Ten slovník ${json} je dobrej, dal bych ho ale do ext. souboru. Patří mezi test. data.

*** Test Cases ***

1. TestCase
    [Documentation]     Registrace vše OK ("Pozitivní test")
    [Tags]              Funkční
    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  200

2. TestCase
    [Documentation]    Registrace bez volby kurzu ("negativní test")
    [Tags]              Funkční
    API Comunication   {"targetid":"","kurz":"","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500

3. TestCase
    [Documentation]     Registrace volby telefonu (prázdný)
    [Tags]              Funkční
    API Comunication    {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500
    # V Responsu chodí status kód 500.

4. TestCase
    [Documentation]    Registrace chybne telef. cislo (moc dlouhe)
    [Tags]              Funkční
    API Comunication    {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"1020304050607891023654","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500
    # V Responsu chodí status kód 500.

5. TestCase
    [Documentation]    Registrace chybna email. adresa (např 'tohleneniemail.cz')
    [Tags]              Funkční
    API Comunication    {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"tohleneniemail.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}     500
    # V Responsu chodí status kód 500.

6. TestCase
    [Documentation]    Registrace chybny format JSON (bez klíče a hodnoty kurzu, tedy "kurz":"2")
    # Nevím, jak to Radek myslí 'bez klíče a hodnoty kurzu, tedy "kurz":"2"'. Smazal jsem první položku ("targetid":"") a test prochází.
    [Tags]              Funkční
    API Comunication    {"kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}        200
    # V Responsu chodí status kód 200.

7. TestCase
    [Documentation]    BONUS: registrace chybny format JSON (vymyslet jinou chybu JSON dat)
    [Tags]              Funkční
    API Comunication    {"targetid":"";"kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}      500
    # Za první položku slovníku jsem dal středník (místo čárky) a v Responsu chodí status kód 500.

8. TestCase
    [Documentation]    Zkouška klíč. slova 'API Comunication Post on Session'
    [Tags]              Funkční
    API Comunication Post on Session     {"targetid":"","kurz":"2","name":"Jan","surname":"Novakščěšíů","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  200
    # V Responsu chodí status kód 200.

*** Keywords ***

API Comunication
    [Arguments]       ${json}     ${error_resp}

    # Převedení do UTF-8
    ${json_utf8} =      Encode String To Bytes     ${json}     UTF-8          # Vyžaduje knihovnu 'String'
    # Tenhle krok je potřeba kvůli diakritice, např. tyto znaky 'ščěš' neprojdou, když se nepoužije 'Encode String To Bytes' nebo nějaký podobný klíč. slovo.

#    ${resp} =           POST  ${urlapp}  data=${json_utf8}  expected_status=${error_resp}
    # Místo argumentu 'data' se dá použít argument 'json'. Pro ty 2 argumenty klíč. slova 'Post' platí trochu jiný pravidla.
    # Argument 'expected_status' v klíč. slově 'POST' má jiný význam než v jakým ho my tady používáme. Ale asi to tak nějak funguje..

    ${resp} =           POST  ${urlapp}  data=${json_utf8}  expected_status=${error_resp}
    # Co je potřeba udělat, abych mohl použít místo argumentu 'data' argument 'json'?

    Log                 ${resp.json()}
    Log To Console      ${\n}${\n}${resp.json()}

    Log To Console       ${\n}${resp}${\n}     # Vypíše např. toto: <Response [200]>
#    Log To Console    ${\n}${resp.json()}[phone]   # Funguje to v případě, že přijde response v pořádku (status code 200)

#    Log To Console     ${\n}${resp.text}
    # Výsledek je podobnej jako při použití ${resp.json()} (viz výše), ale ne úplně stejnej.
    # V tadytom případě jsou použitý jiný (dvojtý) uvozovky, chybí mezery mezi interpunkčníma znaménkama a objevil se problém s kódováním diakritiky.
    # Níže jsem zkusil na tělo Responsu použít klíč. slovo 'Encode String To Bytes', ale nepomohlo to - nic se nezměnilo.

#    ${resp_utf8}=   Encode String To Bytes  ${resp.text}     UTF-8
#    Log To Console  ${\n}${resp_utf8}

    Status Should Be    ${error_resp}
    # Je rozdíl/jaký je mezi argumentem 'expected_status' v klíč slově 'Post' a argumentem  'expected_status' v klíč. slově 'Status Should Be'?
    # (Proč je tady použito klíč. slovo 'Status Should Be', když je o kousek výše použito klíč. slovo 'POST' včetně argumentu 'expected_status'?)
    # Pokud by Response přišel se status kódem jiným než zadá uživatel, tak klíč slovo 'POST' failne.
    # Klíč. slovo 'Status Should Be' je v tadytom případě podle mě zdvojená/zbytečná kontrola.


API Comunication Post on Session
    [Arguments]       ${json}     ${error_resp}

   # Převedení do UTF-8
   ${json_utf8} =     Encode String To Bytes     ${json}     UTF-8          # Vyžaduje knihovnu 'String'

  # Vytoření hlavičky ('header') zprávy/Requestu
  # Proč Request v klíč. slovech 'Post' a 'API Comunication' nemá (nemusí mít) 'header'?
  &{header}=          Create Dictionary   Content-Type=application/json     charset=utf-8

  # Vytvoření spojení ('session')
  # Proč se v předchozím případě (v klíč. slově 'API Comunication') nemusela vytvářet 'session'?
  CreateSession       apilogin            ${url}

  # odeslání zprávy (to dělá klíč. slovo 'Post on Sesion') a uložení odpovědi do proměnné ${resp}
  ${resp}=   Post on Session   apilogin  ${app}   data=${json_utf8}   expected_status=Anything    #  headers=${header}
  # Argument 'headers' není povinný v klíč. slově 'Post on Session'.
    # Proč se v klíč. slově 'Post on Session' zadává jiná 'url' než je v klíč. slově 'Create Session'?

    # Proč vůbec zadávat 'url' v 'Post on Session', když už jsme zadal 'url' v 'Create Session'?
    # Ta 'url' v 'Post on Session' navazuje/dopňuje 'url' zadanou jako argument do 'Create Session'.
    # V 'Create Session' zadám do argumentu 'url' např. 'kitner.cz' a v 'Post on Session' zadám do argumentu 'url' např. '/kurz/jak-automatizovat-testy/'
    # 'Post on Session' přidá '/kurz/jak-automatizovat-testy/' za 'url' z 'Create Session' a vznikne nová, takováto 'url'>
    # kitner.cz/kurz/jak-automatizovat-testy/

    # Argument 'headers' by měl být až za argumentem 'expected_status'. I takhle to ale funguje správně..

  Log                 ${resp.json()}
  Log To Console      ${\n}${\n}${resp.json()}
  Log To Console       ${\n}${resp}${\n}     # Vypíše např. toto: <Response [200]>

  Status Should Be    ${error_resp}


