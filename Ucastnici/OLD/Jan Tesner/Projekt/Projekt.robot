*** Settings ***
Documentation   Projekt

#Library  Browser
Library	 RequestsLibrary
Library  String             # potřebujeme pro klíčové slovo: Encode String To Bytes
Library	 Collections

#Resource        TestData.robot
#Resource        Configuration.robot
#
#Suite Setup     Pred_sadou_testu
#Suite Teardown  Po_sade_testu
#
#Test Setup      Pred_testem
#Test Teardown   Po_testu

*** Variables ***
${url}		    http://testovani.kitner.cz/
#${app}          /regkurz/formsave.php
${app}          /login_app/userauth.php
${urlapp}       ${url}${app}

*** Test Cases ***

#Pozitivni test: Pridani zbozi do kosiku s prihlasenim
#    Login               ${USER1_NAME}       ${USER1_PASSWORD}     ${USER1_SHORT}
#    Pridat do kosiku    ${ZBOZI01_NAME}     ${ZBOZI01_ID}         5
#    Odebrat z kosiku    ${ZBOZI01_NAME}     ${ZBOZI01_ID}
#    [Teardown]          Logout              ${USER1_SHORT}
#
#Negativni test: Pridani zbozi do kosiku bez prihlaseni
#    Login               ${USER1_NAME}       spatneheslo           ${TEXT_Prihlasit}
#    Pridat do kosiku    ${ZBOZI01_NAME}     ${ZBOZI01_ID}         5
#    Odebrat z kosiku    ${ZBOZI01_NAME}     ${ZBOZI01_ID}
#    [Teardown]          Logout              ${TEXT_Prihlasit}

#registrace ok
#    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  200
#
#registrace bez volby kurzu
#    API Comunication   {"targetid":"","kurz":"","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500
#
#registrace volby telefonu (prázdný)
#    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}   500
#
#registrace chybny telefon (moc dlouhy)
#    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500
#
#registrace chybny email (tohleneniemail.cz)
#    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"tohleneniemail.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500
#
#registrace chybny format JSON (bez klíče a hodnoty kurzu, tedy "kurz":"2")
#    API Comunication   {"targetid":,"kurz":"2","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500
#
#registrace chybny format JSON (bez souhlasu)
#    API Comunication   {"targetid":"","kurz":"2","name":"Jan","surname":"Novak","email":"jan.novak@abc.cz","phone":"608123123","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,:true}  500
#
#registrace specialni znaky
#    API Comunication   {"targetid":"","kurz":"2","name":"J@n","surname":"Novak?","email":"jan.novak@abc.cz","phone":"60812312 3","person":"fyz","address":"Brno","ico":"234563234","count":"1","comment":null,"souhlas":true}  500

Test login (validní)
     Login      admin           tajneadmin      Chrome      200

Test login (prázdné heslo)
     Login      admin           ${EMPTY}        Chrome      403

Test login (prázdný uživatel)
     Login      ${EMPTY}        tajneadmin      Chrome      403

Test login (prázdný useragent)
     Login      admin           tajneadmin      ${EMPTY}    403

Test login (prázdný)
     Login      ${EMPTY}         ${EMPTY}       ${EMPTY}    403

Test login (nevalidní uživatel)
     Login      spatnyuzivatel  tajneadmin      Chrome      403

Test login (nevalidní heslo)
     Login      admin           spatneheslo     Chrome      403

Test login (nevalidní useragent)
     Login      admin           tajneadmin      Anything    403

*** Keywords ***

Login
    [Arguments]    ${username}    ${password}   ${useragent}     ${responce_code}
    ${json_string}=     catenate  {"username":"${username}","password":"${password}","useragent":"${useragent}"}
    &{header}=    Create Dictionary    Content-Type=application/json
    CreateSession    apilogin    ${url}
    ${resp} =    Post on Session    apilogin    login_app/userauth.php  data=${json_string}  headers=${header}
    Log	Responce: @{resp}
    Dictionary Should Contain Item	${resp.json()}      response    ${responce_code}

#Login
#    [Arguments]         ${email}            ${heslo}              ${validation}
#
#    Click               ${SEL_HeaderLogin}
#    Sleep               2
#    Type Text           ${SEL_LoginFormEmail}        ${email}
#    Type Text           ${SEL_LoginFormPwd}          ${heslo}
#    Click               ${SEL_BtnSignIn}
#    Sleep               2
#    Get Text            ${SEL_HeaderUserIcon}          ==      ${validation}
#    ${log}=   Get Text  ${SEL_HeaderUserIcon}
#    Log                 ${log}
#    Take Screenshot
#
#Logout
#   [Arguments]         ${validation}
#   Go to               ${URL}
#   IF  "${validation}" == "${USER1_SHORT}"
#        Click           ${SEL_HeaderUserIcon}
#        Click           ${SEL_UserBoxLogoutBtn}
#        Get Text        ${SEL_HeaderUserIcon}    ==    ${TEXT_Prihlasit}
#    ELSE
#        Get Text        ${SEL_HeaderUserIcon}    ==    ${validation}
#    END
#    Take Screenshot
#
#Cookie
#    [Arguments]         ${type}
#    IF  "${type}" == "AcceptAll"
#        Click           ${SEL_Cookie_AllowAll}
#    ELSE
#        Click           ${SEL_Cookie_Decline}
#    END
#
#Pridat do kosiku
#    [Arguments]             ${Zbozi}            ${produkt_id}       ${Kusu}
#    ${old_mode} =           Set Strict Mode     False
#    Type Text               ${SEL_SearchGlobal}     ${Zbozi}
#    Click                   ${SEL_BtnSearchGlobal}
#    Click                   css=[${SEL_ProductID}="${produkt_id}"][${SEL_BtnAdd}]
#    #ověří že je zboží v košíku
#    ${cart_text}=           Get Text            ${SEL_Cart}
#    Log                     ${cart_text}
#    Get Text                ${SEL_Cart}             matches             (?i)${Zbozi}
#    Take Screenshot
#
#Odebrat z kosiku
#    [Arguments]             ${Zbozi}            ${produkt_id}
#    Click                   css=[${SEL_ProductID}="${produkt_id}"][${SEL_BtnMinus}]
#    Take Screenshot
#
#Pred_testem
#    New Page            ${URL}
#    Get Title           contains            ${TEXT_MainTitle}
#    Cookie              AcceptAll
#
#Po_testu
#    Go to              ${URL}
#
#Pred_sadou_testu
#    ${b_timeput} =     Set Browser Timeout        ${TIMEOUT_BROWSER}
#    New Browser        headless=false
#
#Po_sade_testu
#    Close Browser

#API Comunication
#    [Arguments]       ${json}     ${error_resp}
#
#    #převedení do UTF-8
#    ${json_utf8} =      Encode String To Bytes     ${json}     UTF-8          #vyžaduje knihovnu String
#
#    ${resp} =           POST  ${urlapp}  data=${json_utf8}  expected_status=${error_resp}
#
#    Log                 ${resp.json()}
#
#    Status Should Be    ${error_resp}
