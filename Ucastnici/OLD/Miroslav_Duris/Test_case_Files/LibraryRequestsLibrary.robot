*** Settings ***
Library    RequestsLibrary

*** Variables ***
${url}      http://testovani.kitner.cz/
${app}      regkurz/formsave.php
${urlapp}   ${url}${app}
# K čemu je klíč. slovo 'Catenate'? Když jdou stringy spojit i bez něj? Viz výše.
# Jediný, co mě napadá, je, že klíč. slovo 'Catanate' umožňuje různý nastavení 'separátorů'.
# Možná umožňuje spojování položek slovníku - viz soubory na testování API.
# https://robotframework.org/robotframework/latest/libraries/BuiltIn.html#Catenate

*** Test Cases ***
API_test_1
    GET     http://google.com
    Status Should Be     200  msg=Wrong Status Code !!! ${\n}
    # Ten assert 'Status Should Be' se dá nahradit jedním argumentem klíč. slova 'GET' - viz testcase níže.

API_test_2
    GET    http://google.com    expected_status=200     msg=Wrong Status Code !!! ${\n}

API_test_3
      ${response}=      GET  https://www.kitner.cz
      Log to Console    ${\n}${response}
      # Nezobrazí se takto celý response, ale jenom jeho malá část>
      # <Response [200]>

# 3 test casy níže jsou zkopírovaný z dokumentace ke knihovně RequestsLibrary. A mnou upravený.

Quick_Get_Request_Test  # Co to je za test, když v sobě nemá žádný assert?
      ${response}=    GET  https://www.google.com
      # Klíč. slovo 'GET' fails if a status code with error values is returned in the response.
      # A toto chování může být upraveno argumentama 'expected_status' a 'msg'.
      Log To Console    ${\n}${response}

Quick_Get_Request_With_Parameters_Test
      ${response}=    GET  https://www.google.com/search  params=query=ciao  expected_status=200
      # 2. argument ('params') nechápu.
      Log To Console    ${\n}${response}

Quick_Get_A_JSON_Body_Test
        ${PuvodniHodnotaLogLevel}        Set Log Level       TRACE
# Přidat další asserty>
      ${response}=    GET  https://jsonplaceholder.typicode.com/posts/1
      Log To Console    ${\n}Samotný response>${\n}${response}
#      Log To Console    ${\n}Samotný response>${\n}${response()}
#      Resolving variable '${response()}' failed: TypeError: 'Response' object is not callable
##      Should Contain Any    ${response}     response    200       ignore_case=True
##      Proč to nefunguje?!
      Log To Console    ${\n}Atribut 'content' v 'Response' objektu>${\n}${response.content}
#      Log To Console    ${\n}Atribut 'content' v 'Response' objektu>${\n}${response.content()}
#      Resolving variable '${response.content()}' failed:  TypeError: 'bytes' object is not callable
##      Should Contain Any    ${response.content}     userId    id      title       body       ignore_case=True
##      Proč to nefunguje?!
      Log To Console    ${\n}Atribut 'cookies' v 'Response' objektu>${\n}${response.cookies}
#      Log To Console    ${\n}Atribut 'cookies' v 'Response' objektu>${\n}${response.cookies()}
#      Resolving variable '${response.cookies()}' failed:  TypeError: 'RequestsCookieJar' object is not callable

      Log To Console    ${\n}Atribut 'elapsed' v 'Response' objektu>${\n}${response.elapsed}
#      Log To Console    ${\n}Atribut 'elapsed' v 'Response' objektu>${\n}${response.elapsed()}
#      Resolving variable '${response.elapsed()}' failed: TypeError: 'datetime.timedelta' object is not callable

      Log To Console    ${\n}Atribut 'encoding' v 'Response' objektu>${\n}${response.encoding}
#      Log To Console    ${\n}Atribut 'encoding' v 'Response' objektu>${\n}${response.encoding()}
#      Resolving variable '${response.encoding()}' failed: TypeError: 'str' object is not callable
      Should Be Equal    ${response.encoding}     utf-8
      Should Be Equal As Strings        ${response.encoding}        utf-8

      Log To Console    ${\n}Atribut 'headers' v 'Response' objektu>${\n}${response.headers}
#      Log To Console    ${\n}Atribut 'headers' v 'Response' objektu>${\n}${response.headers()}
#      Resolving variable '${response.headers()}' failed: TypeError: 'CaseInsensitiveDict' object is not callable

      Log To Console    ${\n}Atribut 'history' v 'Response' objektu>${\n}${response.history}
#      Log To Console    ${\n}Atribut 'history' v 'Response' objektu>${\n}${response.history()}
#      Resolving variable '${response.history()}' failed: TypeError: 'list' object is not callable

      Log To Console    ${\n}Atribut 'json' v 'Response' objektu>${\n}${response.json}
      Log To Console    ${\n}Přístup k 'json' v 'Response' objektu jako k metodě>${\n}${response.json()}
      Should Be Equal As Strings    1  ${response.json()}[id]
      # Dá se 'id' vložit přes tečku přímo do proměnné? Tzn. ${response.json().id}
      Should Be True    ${response.json()}[userId] < 2
      # Dá se 'userId' vložit přes tečku přímo do proměnné? Tzn. ${response.json().userId}
      Should Start With    ${response.json()}[title]    sunt aut facere
      # Dá se 'title' vložit přes tečku přímo do proměnné? Tzn. ${response.json().title}
      Should End With   ${response.json()}[body]        rem eveniet architecto
      # Dá se 'body' vložit přes tečku přímo do proměnné? Tzn. ${response.json().body}

      Log To Console    ${\n}Atribut 'ok' v 'Response' objektu>${\n}${response.ok}
#      Log To Console    ${\n}Atribut 'ok' v 'Response' objektu>${\n}${response.ok()}
#      Resolving variable '${response.ok()}' failed: TypeError: 'bool' object is not callable
      ${true}     Convert To Boolean      true
      Should Be Equal    ${response.ok}   ${true}   #ignore_case=True      #values=true
##      Porovnávání Boolean. hodnot>
##      https://robotframework.org/robotframework/latest/libraries/BuiltIn.html#Boolean%20arguments
##      https://robotframework.org/robotframework/latest/libraries/BuiltIn.html#Convert%20To%20Boolean

      Log To Console    ${\n}Atribut 'reason' v 'Response' objektu>${\n}${response.reason}
#      Log To Console    ${\n}Atribut 'reason' v 'Response' objektu>${\n}${response.reason()}
#      Resolving variable '${response.reason()}' failed: TypeError: 'str' object is not callable
      Should Be Equal    ${response.reason}   ok   ignore_case=True
      Should Contain    ${response.reason}      ok      ignore_case=True

      Log To Console    ${\n}Atribut 'status_code' v 'Response' objektu>${\n}${response.status_code}
#      Log To Console    ${\n}Atribut 'status_code' v 'Response' objektu>${\n}${response.status_code()}
#      Resolving variable '${response.status_code()}' failed: TypeError: 'int' object is not callable
      Should Be Equal As Numbers    ${response.status_code}      200
      Should Be Equal As Integers    ${response.status_code}      200
      Should Be True                  ${response.status_code} < 300

      Log To Console    ${\n}Atribut 'text' v 'Response' objektu>${\n}${response.text}
#      Log To Console    ${\n}Atribut 'text' v 'Response' objektu>${\n}${response.text()}
#      Resolving variable '${response.text()}' failed: TypeError: 'str' object is not callable
      Should Contain Any    ${response.text}      userid      id      title       body

      Log To Console    ${\n}Atribut 'url' v 'Response' objektu>${\n}${response.url}
#      Log To Console    ${\n}Atribut 'url' v 'Response' objektu>${\n}${response.url()}
#      Resolving variable '${response.url()}' failed: TypeError: 'str' object is not callable
      Should Contain    ${response.url}       jsonplaceholder

      Comment
      Comment    Displays the given messages in the log file as keyword arguments.  Druhá message   A poslední.
      # Jaký je rozdíl mezi klíč. slovy 'Log' a 'Comment'? Viz níže.
      # Given arguments are ignored so thoroughly that they can even contain non-existing variables.
      # If you are interested about variable values, you can use the Log or Log Many keywords.

      Set Log Level               ${PuvodniHodnotaLogLevel}

*** Comments ***
