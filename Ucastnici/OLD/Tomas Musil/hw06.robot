*** Settings ***
Library	 RequestsLibrary
Library  String
Library  Collections


*** Variables ***
${url}		    http://testovani.kitner.cz/
${app}          /regkurz/formsave.php
${urlapp}       ${url}${app}
&{JSON}         targetid=  kurz=2  name=Jan  surname=Novak  email=jan.novak@abc.cz  phone=608123123  person=fyz  address=Brno  ico=234563234  count=1  comment=  souhlas=${True}

# {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}


*** Test Cases ***

registrace ok
    API Comunication   ${JSON}  200

registrace specialni znak (misto jmena je snehulak)
    &{json} =  Copy Dictionary  ${JSON}
    Set To Dictionary    ${json}  name=\u2603
    API Comunication   ${json}   200

registrace bez volby kurzu
    &{json} =  Copy Dictionary  ${JSON}
    &{resp} =  Create Dictionary  field=kurz  issue=empty
    Set To Dictionary    ${json}  kurz=
    API Comunication   ${json}   500  ${resp}

registrace volby telefonu (prázdný)
    &{json} =  Copy Dictionary  ${JSON}
    &{resp} =  Create Dictionary  field=phone  issue=empty
    Set To Dictionary    ${json}  phone=
    API Comunication   ${json}   500  ${resp}

registrace chybny telefon (moc dlouhy)
    &{json} =  Copy Dictionary  ${JSON}
    &{resp} =  Create Dictionary  field=phone  issue=format  hint=777123456
    Set To Dictionary    ${json}  phone=6081231236543506831
    API Comunication   ${json}   500  ${resp}

registrace chybny email (tohleneniemail.cz)
    &{json} =  Copy Dictionary  ${JSON}
    &{resp} =  Create Dictionary  field=email  issue=format  hint=xxx@yyyyy.zzz
    Set To Dictionary    ${json}  email=tohleneniemail.cz
    API Comunication   ${json}   500  ${resp}

registrace chybny format JSON (bez klíče a hodnoty kurzu, tedy "kurz":"2")
    &{json} =  Copy Dictionary  ${JSON}
    &{resp} =  Create Dictionary  field=kurz  issue=empty
    Remove From Dictionary    ${json}  kurz
    API Comunication   ${json}   500  ${resp}


*** Keywords ***

API Comunication
    [Arguments]       ${json}     ${exp_status}     ${exp_resp}=

    ${json_string} =    evaluate  json.dumps(${json})  json

    #převedení do UTF-8
    ${json_utf8} =      Encode String To Bytes     ${json_string}     UTF-8          #vyžaduje knihovnu String

    ${resp} =           POST  ${urlapp}  data=${json_utf8}  expected_status=${exp_status}

    Log                 ${resp.json()}

    Status Should Be    ${exp_status}

    IF    ${exp_status} != 200
       Should Be Equal    ${resp.json()}[problem][0]    ${exp_resp}
    END

