*** Comments ***

*** Settings ***
Documentation   Moje-prvni-API-testy
Library  RequestsLibrary

*** Variables ***
${url}      http://testovani.kitner.cz/  # Je to string?
${app}      regkurz/formsave.php        # Je to string?
${urlapp}   ${url}${app}                #Takhle jednoduše funguje spojovámí stringů? K čemu je v to případě klíč. slovo 'Catenate'?
# Log To Console    ${urlapp}

*** Test Cases ***
API test #1
    [Documentation]                 Quick Get Request Test
    [Tags]                         Funkční
    ${response}=                  GET  https://www.google.com
    Log to Console               ${\n}${response}
    Log to Console                ${response.status_code}
    Should Be Equal As Numbers    200      ${response.status_code}
    Should Be Equal As Integers   200      ${response.status_code}
    Should Be Equal As Strings    200      ${response.status_code}
    Status Should Be             200

API test #2
    [Documentation]    Quick Get Request With Parameters Test
    [Tags]              Funkční
    ${response}=    GET  https://www.google.com/search  params=query=ciao  expected_status=200
    Log to Console    ${\n}${response}
    Log to Console      ${response.status_code}

API test #3
    [Documentation]    Quick Get A JSON Body Test I.
    [Tags]              Funkční
    ${response}=        GET  https://jsonplaceholder.typicode.com/posts/1
    Status should be    200
    Log to Console      ${\n}${response.ok}
    Log to Console      ${\n}${response.headers}
    Log to Console      ${\n}${response.text}
    Log to Console      ${\n}reason: ${response.reason}
    Log to Console      ${\n}status_code: ${response.status_code}
    Log to Console      ${\n}${response.json()}
    Should Be Equal As Strings    OK  ${response.reason}
# {'userId': 1, 'id': 1, 'title': 'sunt vaut facere repellat provident occaecati excepturi optio reprehenderit', 'body': 'quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto'}
    Should Be Equal As Strings    1  ${response.json()}[userId]
    Should Be Equal As Strings    1  ${response.json()}[id]
    Should Be Equal As Strings    sunt aut facere repellat provident occaecati excepturi optio reprehenderit  ${response.json()}[title]

API test #4
    [Documentation]    Quick Get A JSON Body Test II.
    [Tags]              Funkční
    ${response}=    GET  https://jsonplaceholder.typicode.com/posts/1
    Log To Console    ${\n}${response}
    Log To Console    ${\n}${response.json()}
    Should Be Equal As Strings    1  ${response.json()}[id]
    Log To Console    ${\n}${response.json()}[id]
    Should Be Equal As Strings    1  ${response.json()}[userId]
    Log To Console    ${\n}${response.json()}[userId]

API test #5
    [Documentation]    Test Registrace na Kurz
    [Tags]              Funkční
    #${json1}=  catenate  {"targetid":"","kurz":"1","name":"Jan","surname":"Tester","email":"jan.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
    ${json2}=  Set Variable  {"targetid":"","kurz":"1","name":"Jan","surname":"Tester","email":"jan.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
    #&{json3}=   Create Dictionary   targetid=  kurz=1  name=Jan    surname=Tester  email=jan.tester@data.cz    phone=777123132     person=fyz  address=Udolni 21, Brno     ico=27232433    count=1     comment=nic     souhlas=true
    Log To Console        ${\n}${json2}
    ${response}=    POST  ${urlapp}  data=${json2}  expected_status=200     # Použit parametr 'data' a proměnná '$' (tj. sklaární?).
    #${response}=    POST  ${urlapp}  json=&{json3}  expected_status=200     # Místo argumentu 'data' jsem použil argument 'json' a místo proměnné '$' (tj. skalární?) jsem použil proměnnou typu slovník '&'.

API test #6
    [Documentation]    Test Registrace na Kurz chyba
    [Tags]              Funkční
    ${json}=            catenate  {"targetid":"","kurz":"","name":"Jan","surname":"Tester","email":"jan.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
    ${response}=         POST  ${urlapp}  data=${json}  expected_status=500
    Log To Console       ${\n}${response}

API test #7
    [Documentation]    Chybny format dat místo DATA pouzit JSON
    [Tags]              Funkční
    ${json}=          catenate  {"targetid":"","kurz":"1","name":"Jan","surname":"Tester","email":"jan.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
    ${response}=      POST    ${urlapp}   json=${json}  expected_status=500
    Log To Console    ${\n}${response}

API test #8
    [Documentation]    Vše OK
    [Tags]              Funkční
    ${json}=        catenate  {"targetid":"","kurz":"1","name":"Jan","surname":"Tester","email":"jan.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
    ${response}=    POST    ${urlapp}   data=${json}  expected_status=200
    log to console  ${\n}${response.json()}[response]

API test #9
    [Documentation]    Chybné číslo kurzu
    [Tags]              Funkční
    ${json9}=  catenate  {"targetid":"","kurz":"5","name":"Jan","surname":"Tester","email":"jan.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
    ${response9}=  POST    ${urlapp}   data=${json9}  expected_status=200
    #Pozor na psani a nepsaní kulatých závorek
    Log To Console    ${\n}0. log: ${response9}
    log to console  ${\n}1. log: ${response9.json}
    log to console  ${\n}2. log: ${response9.json()}
    log to console  ${\n}3. log: ${response9.json()}[response]
    log to console  ${\n}4. log: ${response9.json()}[reason]
    log to console  ${\n}5. log: ${response9.text}

API test #10
    [Documentation]    Quick Get A JSON Body Test III.
    [Tags]              Funkční
    ${response10}=    GET  https://jsonplaceholder.typicode.com/posts/2
    Log To Console    ${\n} ${\n} Toto je status (hlavička) responsu:${\n} ${response10}
    Log To Console    ${\n} Toto je celý 'json' (tělo) responsu:${\n} ${response10.json()}
    Log To Console    ${\n} Toto je opět celý 'json' (tělo) responsu, tentokrát naparsovaný: ${\n} ${response10.text}
    Log To Console    ${\n} 'userId' v tomto responsu/'jsonu' je: ${response10.json()}[userId]
    Should Be Equal As Strings    1  ${response10.json()}[userId]     #1 Assert 10/I.

    Log To Console    ${\n} 'id' (v tomto responsu/'jsonu') je stejné jako poslední část URL (viz parametr klíč. slova 'GET'), tedy: ${response10.json()}[id]
    #Should Be Equal As Strings    1  ${response10.json()}[id]       #2 Assert 10/II.

    Log To Console    ${\n} 'title' v tomto 'jsonu' je: ${response10.json()}[title]
    Should Be Equal    ${response10.json()}[title]   qui est esse     #3 Assert 10/III.

    Log To Console    ${\n} Toto je 'body' 'jsonu': ${\n} ${response10.json()}[body]
    Should Contain  ${\n} ${response10.json()}[body]    sequi sint nihil reprehenderit dolor beatae ea dolores neque        #4 Assert 10/IV.


API test #11
    [Documentation]    Quick Get A JSON Body Test IV.
    [Tags]              Funkční
    ${response}=        GET                  https://jsonplaceholder.typicode.com/posts/11  #za posledním lomítkem může být pouze přirozené číslo z intervalu <1, 100>
    Log To Console    ${\n} ${\n} Toto je status (nebo statut?) responsu:${\n} ${response}
    Log To Console    ${\n} Toto je celý 'json' (tělo) responsu:${\n} ${response.json()}
#    Should Be Equal As Strings    1     ${response.json()}[id]
    Log To Console    ${\n} 'id' je stejné jako poslední část URL (viz parametr klíč. slova 'GET'), tedy: ${response.json()}[id]
#    Should Be Equal As Strings    1     ${response.json()}[userId]
    Log To Console    ${\n} 'userId' je přirozené číslo z intervalu <1, 10> a jeho skutečná hodnota je při URL ze zadání toho testu rovna: ${response.json()}[userId] ${\n}












