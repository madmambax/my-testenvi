*** Settings ***
Library           RequestsLibrary
Suite Setup       Set Log Level    trace
Suite Teardown    Set Log Level    info

*** Variables ***
${url}      http://testovani.kitner.cz/
${app}      regkurz/formsave.php
${urlapp}   ${url}${app}
# V testcasu/klíč. slově to funguje i jako ${url}${app}
# Proměnná ${urlapp} je asi zbytečná..
${json1}    {"targetid":"","kurz":"1","name":"Jan","surname":"Tester","email":"jan.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
&{json2}     "targetid"=""  "kurz"="1"     "name"="Jan"     "surname"="Tester"  "email"="jan.tester@data.cz"    "phone":=777123132"     "person"="fyz"  "address"="Udolni 21, Brno"     "ico"="27232433"    "count"="1"     "comment"="nic"     "souhlas"=true
# Proč ten slovník nemáme mezi ostatníma proměnnýma v ext. souboru?

*** Test Cases ***
TestKlicSlovaPOSTpozitivni
        &{json3}   Create Dictionary     "targetid":""  "kurz":"1"     "name":"Jan"     "surname":"Tester"  "email":"jan.tester@data.cz"    "phone":"777123132"     "person":"fyz"  "address":"Udolni 21, Brno"     "ico":"27232433"    "count":"1"     "comment":"nic"     "souhlas":true
# Jak ten slovník ('json3') dostat do sekce 'Variables'?
# Klíč. slovo 'Create Dictionary' asi mění pořadí zadaných položek.
#        ${json4}    Catenate    {"targetid":"","kurz":"1","name":"Jan","surname":"Tester","email":"jan.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
        ${json5}    Set Variable    {"targetid":"","kurz":"1","name":"Jan","surname":"Tester","email":"jan.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
# Je nějaký rozdíl mezi proměnnou ${json4} a ${json1} ? Obě dvě jsou skaláry.

#    ${POSTreturn}      POST    ${urlapp}   json={"targetid":"","kurz":"1","name":"Jan","surname":"Tester","email":"jan.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
#       Log To Console    ${\n}${POSTreturn}
## Proč to nefunguje? V argumentu 'json' jsem použil stejnej slovník jako níže. Jinak jsou ty řádky stejný.

#    ${POSTreturn}     POST    ${url}${app}   data={"targetid":"","kurz":"1","name":"Jan","surname":"Tester","email":"jan.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
# Čísla v uvozovkách, Boolean. hodnoty bez uvozovek, a všude jinde - takže u stringů - použity dvojité uvozovky - funguje to tak.

#    ${POSTreturn}     POST    ${url}${app}   data={"targetid":"","kurz":1,"name":"Jan","surname":"Tester","email":"jan.tester@data.cz","phone":777123132,"person":"fyz","address":"Udolni 21, Brno","ico":27232433,"count":1,"comment":"nic","souhlas":true}
# Čísla a Boolean. hodnoty bez uvozovek, jinak použity dvojité uvozovky - s jednoduchýma uvozovkama tu kupodivu nefunguje.

    ${POSTreturn}     POST    ${url}${app}   data=${json5}      expected_status=200     msg=Status Code by měl být 200, ale není!
#   Funguje to i přesto, že v argumentu 'data' by neměl být string>
#   https://marketsquare.github.io/robotframework-requests/doc/RequestsLibrary.html#POST
#   Zkusit místo 'expected_status=200' jenom '200'. Je to poziční argument - viz User Guide RBFW.

#    ${POSTreturn}     POST    ${url}${app}   json=${json3}
#   Nefunguje to i přesto, že v argumentu 'json' by měl být slovník>
#   https://marketsquare.github.io/robotframework-requests/doc/RequestsLibrary.html#POST

    Log To Console    ${\n}Samotný 'Return' toho responsu je>${\n}${POSTreturn}

    Log To Console    ${\n}Json toho responsu je>${\n}${POSTreturn.json}

    Log To Console    ${\n}Hodnota klíče 'response' v json/body responsu je>${\n}${POSTreturn.json()}[response]
    Should Be True    ${POSTreturn.json()}[response] < 300

    Log To Console    ${\n}Hodnota klíče 'kurz' v json/body responsu je>${\n}${POSTreturn.json()}[kurz]
    Should Be Equal As Integers    1    ${POSTreturn.json()}[kurz]

    Log To Console    ${\n}Hodnota klíče 'name' v json/body responsu je>${\n}${POSTreturn.json()}[name]
    Should Be Equal   Jan    ${POSTreturn.json()}[name]

    Log To Console    ${\n}Hodnota klíče 'suname' v json/body responsu je>${\n}${POSTreturn.json()}[surname]
    Should Be Equal   Tester     ${POSTreturn.json()}[surname]

    Log To Console    ${\n}Hodnota klíče 'email' v json/body responsu je>${\n}${POSTreturn.json()}[email]
    Should Be Equal   jan.tester@data.cz     ${POSTreturn.json()}[email]

    Log To Console    ${\n}Hodnota klíče 'phone' v json/body responsu je>${\n}${POSTreturn.json()}[phone]
    Should Be Equal As Integers    777123132     ${POSTreturn.json()}[phone]

    Log To Console    ${\n}Hodnota klíče 'person' v json/body responsu je>${\n}${POSTreturn.json()}[person]
    Should Be Equal   fyz     ${POSTreturn.json()}[person]

    Log To Console    ${\n}Hodnota klíče 'address' v json/body responsu je>${\n}${POSTreturn.json()}[address]
    Should Be Equal   Udolni 21, Brno     ${POSTreturn.json()}[address]

    Log To Console    ${\n}Hodnota klíče 'ico' v json/body responsu je>${\n}${POSTreturn.json()}[ico]
    Should Be Equal As Integers       27232433     ${POSTreturn.json()}[ico]

    Log To Console    ${\n}Hodnota klíče 'count' v json/body responsu je>${\n}${POSTreturn.json()}[count]
    Should Be Equal As Integers       1     ${POSTreturn.json()}[count]

    Log To Console    ${\n}Hodnota klíče 'comment' v json/body responsu je>${\n}${POSTreturn.json()}[comment]

    Log To Console    ${\n}Hodnota klíče 'souhlas' v json/body responsu je>${\n}${POSTreturn.json()}[souhlas]
    Should Be Equal As Strings    true     ${POSTreturn.json()}[souhlas]    ignore_case=True

TestKlicSlovaPOSTnegativni
    ${json6}    Set Variable    {"targetid":"","kurz":"","name":"Jan","surname":"Tester","email":"jan.tester@data.cz","phone":"777123132","person":"fyz","address":"Udolni 21, Brno","ico":"27232433","count":"1","comment":"nic","souhlas":true}
    # Chyba (v 'json6') způsobena absencí hodnoty u klíče 'kurz'. Mohl bych zkusit tam dát NULL.
#    ${POSTreturn}     POST    ${url}${app}   data=${json6}      expected_status=500     msg=Status Code by měl být 500, ale není!
#   Funguje

    ${POSTreturn}     POST    ${url}${app}   data=${json6}      expected_status=any
    Status Should Be    500

*** Comments ***
Můžu v jsonu/slovníku najít klíč podle zadané hodnoty?

Klíč. slovo 'Catenate' udělá ze slovníku (jedině) skalár?
${skalár}   Catenate    {"klíč1":"string","klíč2":True,"klíč3":100}
Zkusit místo 'Catenate' použít 'Set Variable'.

Nevím, kdy můžu/mám použít argument 'data' a kdy 'json'.
A nevím, čím můžu/mám naplnit ty argumenty - jestli skalárem nebo (i) slovníkem.

Možná příčina problémů je kódování znaků. Můžu zkusit test. data zakódovat pomocí klíč. slova>
'Encode String To Bytes'
z knihovny 'String'.
https://robotframework.org/robotframework/latest/libraries/String.html

Při používání klíč. slova 'POSt on session' (a ostatních metod 'on session') je potřeba aby url byla složená
z url domény + url aplikace?

Při používání háčků a čárek se může objevit fail s errorem>
UnicodeEncodeError
To se dá vyřešit tím, že testovací data pošlu nejdřív do klíč. slova 'Encode String To Bytes' a až potom do POST, GET atd.

POST vs. POST on Session>
První způsob se používá pokud chci poslat na server jenom 1 dotaz;
druhej způsob se používá pokud chci na server poslat více dotazů.
Platí to i pro ostatní http metody (get, delete, ... )
Urychluje to testování.

Dá se pomocí Set Variable vůbec vytvořit slovník?

Jak testovat API komunikaci, když server vyžaduje autorizaci/autentizaci? Jenom vytvoření 'session' to nevyřeší podle mě.
Jde asi o práci s tokenama..
Když posílám request bez vytvořené session, tak nevyplňuju hlavičku requestu, resp. nemusím, protože ji nějak defaultně
za mě vyplní RequestsLibrary (konkrétně to klíč. slovo, který použiju - třeba GET).
Když používám klíč. slovo 'GET|PUT|DELETE... on Session', tak musím vyplnit i hlavičku requestu - proč?

První část response je tzv. stavový řádek obsahující např. '200 OK'.

Naprostá většina současných API vyžaduje v responsu (v hlavičce i v těle) data ve formátu slovník.

Vytahování zanořených dat ze slovníku.

Dá se tady použít 'najdi a nahraď' jenom ve vyznačeným bloku kódu?
