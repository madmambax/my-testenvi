*** Settings ***
Documentation   Automatizace rohlik.cz s BrowserLibrary
Library         Browser
Library         String
Library         RequestsLibrary
Resource        Data_and_Config/testdataVK.robot
Resource        Data_and_Config/ConfigurationVK.robot

Test Setup      pred_testy
Test Teardown   po_testech

Suite Setup     pred_sadou
Suite Teardown  po_sade

*** Variables ***
${urlapp}  https://www.rohlik.cz/services/frontend-service/login


*** Test Cases ***
#good login API - 200
#    API Comunication    {email: "vojta.kartus@gmail.com", password: "mojeheslonarohlik", name: ""}  200
#    ${resp} =           POST  https://www.rohlik.cz/services/frontend-service/login  data=${json_utf8}  expected_status=${error_resp}

bad email prihlaseni
    Login                           dsadsad@sdas.cz                     ${SEL_USER1_PASSWORD}               ${TEXT_USER1_BadLoginOvereni}

bad heslo prihlaseni
    Login                           ${SEL_USER1_NAME}                      spatneheslo                      ${TEXT_USER1_BadLoginOvereni}

good login prihlaseni
    Login                           ${SEL_USER1_NAME}                       ${SEL_USER1_PASSWORD}               ${TEXT_USER1_GoodLoginOvereni}
    #vysypat pokud je plny kosik    css=.cartCount                   #css=.sc-c57c261e-4.dHRBLh.cartCount         #css=.sc-c57c261e-4.jWscLy.cartCount
    Pridat do kosiku                ${SEL_ZBOZI01_NAME}                      ${SEL_ZBOZI01_ID}                     8
    Odebrat z kosiku                ${SEL_ZBOZI01_NAME}                      ${SEL_ZBOZI01_ID}                     4
    Logout



*** Keywords ***
#API Comunication
#    [Arguments]       ${json}     ${error_resp}

    #převedení do UTF-8
#    ${json_utf8} =      Encode String To Bytes     ${json}     UTF-8         #kvůli encode string to bytes je třeba knihovna string!!
#    ${resp} =           POST  ${urlapp}  data=${json}  expected_status=${error_resp}       #kvůli POST je třeba knihovna RequestsLibrary!!
#    Log                 ${resp.json()}
#    Status Should Be    ${error_resp}


Login
    [Arguments]         ${email}                            ${heslo}                    ${validation}
        #otevri stranku
    Open Browser        ${URL}
    sleep               5
        #accept cookies
    Get Title           contains                            Rohlik
    Cookie              AcceptAll   #KEYWORD Cookie - - -
    sleep               5
        #clickni na login pro otevření přihlaseni
    Click               ${SEL_HeaderLogin}
    sleep               5
        #zadej email a heslo a odklikni prihlaseni
    Type Text           ${SEL_LoginFormEmail}             ${email}
    Type Text           ${SEL_LoginFormPwd}          ${heslo}
    Click               ${SEL_BtnSignIn}
    sleep               5
        #zkontroluj jestli prihlaseni proběhlo uspěsne
    Get Text            ${SEL_HeaderUserIcon}          ==      ${validation}
    ${log}=   Get Text  ${SEL_HeaderUserIcon}
    Log                 ${log}

Logout
        #pokud jsi prihlaseny = odhlasit
   Click               xpath=//div[@class='u-mr--8']
   Click               data-test=user-box-logout-button

Cookie
    [Arguments]         ${type}
    IF  "${type}" == "AcceptAll"
        # klinout na "Vše povolit"
        Click               ${SEL_Cookie_AllowAll}
    ELSE
        # klinout na "Odmítnout"
        Click               ${SEL_Cookie_Decline}
    END
    sleep                1      #workaround: Probliknutí cele stránky po kliknutí na tlačítko

#vysypat pokud je plny kosik
#    [Arguments]          ${plnyKosik}   #${pk0}  #${pk1}
#
#  IF  "${plnyKosik}" == "css=.dHRBLh"
#      Click  css=.h-flexStartItemsCenter
#      Click  css=.clearCart
#  ELSE
#      Click  css=.logo
#  END


Pridat do kosiku
    [Arguments]         ${Zbozi_name}     ${Zbozi_id}     ${Kusu}
        #do pole "heldat název" zadá jméno produktu a vyhledá
    type text           ${SEL_SearchGlobal}     ${Zbozi_name}
    Click               ${SEL_BtnSearchGlobal}       #hledat
    sleep               5
    Click               ${TEXT_DoporuceneRazeni}
        #zboží ještě není v košíku tz. vyhledáme zboží podle produk id a přidám 'do košíku'
    Click               css=[data-product-id="${Zbozi_id}"][${SEL_BtnAdd}]
    sleep               5

    Click               ${SEL_HeaderDoKosiku}      #klik na header
    sleep               5
    Take Screenshot
        #odečtení 1 kusu, protože 1 zboží jsme již přidali po kliknutí na pridat do kosiku
    ${Pocet}            Evaluate                    ${Kusu} - 1
        #přidání zbylého počtu kusů pomocí vícenásobného kliknutí na tlačítko plus u konkrétního produktu
        #Click          css=kde se jako selektor použije nadřezená třída + ${produkt_id} + také data-test="btnPlus"   Je třeba přidat parametr:   clickCount=${Pocet}
    Click               css=[data-product-id="${Zbozi_id}"][${SEL_BtnPlus}]  clickCount=${Pocet}
    sleep               5

Odebrat z kosiku
    [Arguments]         ${Zbozi_name}     ${Zbozi_id}     ${Kusu}
    type text           ${SEL_SearchGlobal}     ${Zbozi_name}
    Click               ${SEL_BtnSearchGlobal}   #hledat
    sleep               5
    Click               ${TEXT_DoporuceneRazeni}
    sleep               5
    Click               ${SEL_HeaderDoKosiku}   #klik na header
    sleep               5
    ${Pocet}            Evaluate                    ${Kusu} - 1
    Click               css=[data-product-id="${Zbozi_id}"][${SEL_BtnMinus}]  clickCount=${Pocet}
    sleep               5

pred_testy
    log  pred testem

po_testech
    log  po testu

pred_sadou
    log  pred sadou

po_sade
    log  po sade