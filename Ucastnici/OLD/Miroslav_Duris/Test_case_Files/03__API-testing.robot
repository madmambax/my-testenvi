*** Comments ***

*** Settings ***
Documentation    Pouziti klic. slova 'Run Keyword And Expect Error'
Library         RequestsLibrary
Library          String

*** Variables ***
${url}		    http://testovani.kitner.cz/
${json1}      {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}
${json2}      {"targetid":"","kurz":"20","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"100","comment":null,"souhlas":true}
# Jak upravit proměnnou 'json2' tak, abych po jejím odeslání dostal Response se status kódem 400?

*** Test Cases ***
0. Prvni_test_api  # Nebo je to API test?
      ${response} =      GET                https://www.google.com
      Log to Console     ${\n}${response}

1. Očekávání_určité_chyby
# Převedení do UTF-8
   ${json_utf8} =     Encode String To Bytes     ${json2}     UTF-8          # Vyžaduje knihovnu String; a proč se tohle vlastně má dělat?
# Vytoření hlavičky ('header') zprávy/Requestu
  &{header}=          Create Dictionary   Content-Type=application/json     charset=utf-8
# Vytvoření spojení ('session')
  CreateSession       apilogin            ${url}

  Run Keyword And Expect Error  HTTPError: 400 Client Error:*  Post on Session     apilogin    /regkurz/formsave.php  data=${json_utf8}  headers=${header}
  # Musí být v klíč. slově 'Post on session' argument 'headers'?
  # A proč je parametr 'url' v klíč. slově 'Post on Session' jiný než parametr 'url' v klíč. slově 'CreateSession'? Jde o stejný spojení, tak bych čekal stejnou url..
  # expected_error je 'HTTPError: 400 Client Error:*'
  # Klíč. slovo, který chci, aby proběhlo, je 'Post on Session'.

2. Post_on_session(1)
    [Documentation]    Zkouska pouziti klic. slova 'POST On Session'
    [Tags]              Funkční
    &{header}=          Create Dictionary   Content-Type=application/json     charset=utf-8
    Create Session    APItest   ${url}
    POST On Session    APItest  ${url}  data=${json1}   #headers=${header}
    # Argument 'headers' klíč. slova 'POST On Session' není povinný a tento testcase funguje (asi správně) i bez něj. Ověřit v log file.
    # Klic. slovo 'Encode String To Bytes' jsem v tadytom testcasu nepotřeboval...není asi potřeba ani v předchozím testcasu.

3. Post_on_session(2)
    [Documentation]  Bez argumentu `headers` a bez klíč. slova 'Encode String To Bytes'
    [Tags]    Funkční

# Vytvoření spojení ('session'):
  CreateSession       apilogin            ${url}

  Post on Session     apilogin    /regkurz/formsave.php  data=${json2}
  # Musí být v klíč. slově 'Post on session' argument 'headers'?
  # A proč je parametr 'url' v klíč. slově 'vPost on Session' jiný než parametr 'url' v klíč. slově 'CreateSession'? Jde o stejný spojení, tak bych čekal stejnou url..

4. Post_on_session(3)
    [Documentation]     Opět bez argumentu `headers` a bez klíč. slova 'Encode String To Bytes'
# 'url' jsem použil v klíč. slově 'Post On Session' stejnou jako v klíč. slově 'Create Session'.
# A u klíč. slova 'Post on Session' jsem použil místo argumentu 'data' argument 'json' s tím, že proměnnou jsem nezměnil, tzn. stále ${json2}.
    [Tags]    Funkční

# Vytvoření spojení ('session'):
  CreateSession       apilogin    ${url}

  Post on Session     apilogin    ${url}		    json=${json2}

*** Keywords ***
