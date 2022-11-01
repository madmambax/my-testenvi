# požadavky
#   pip install robotframework-browser
#   rfbrowser init


*** Settings ***
Documentation   Automatizace rohlik.cz s BrowserLibrary
Library         Browser
Resource        TestData.robot
Resource        Configuration.robot

Test Setup      Pred_testy
Test Teardown   Po_testech

*** Variables ***

*** Test Cases ***

Pridani zbozi do kosiku
    Login                                   ${USER1_NAME}              ${USER1_PASSWORD}        ${USER1_SHORT}
    #Pridat do Kosiku                       ${ZBOZI01_NAME}
    #Pridat do kosiku varianta pocet        ${ZBOZI01_NAME}  5
    Pridat do kosiku varianta produkt id    ${ZBOZI01_NAME}  ${ZBOZI01_ID}   5
    #Odebrání několik ks
    Odebrání několik ks lepší   3
    Odebrání z kosiku komplet
    Logout


*** Keywords ***

Login
    [Arguments]         ${email}                            ${heslo}                    ${validation}

    Cookie              AcceptAll
    Click               ${SEL_HeaderLogin}
    Sleep               ${TIME_BETWEEN_CLICKS1}
    Type Text           ${SEL_LoginFormEmail}             ${email}
    Type Text           ${SEL_LoginFormPwd}               ${heslo}
    Click               ${SEL_BtnSignIn}
    Get Text            ${SEL_HeaderICON}          ==      ${validation}
    ${log}=   Get Text  ${SEL_HeaderICON}
    Log                 ${log}



Cookie
    [Arguments]         ${type}
    IF  "${type}" == "AcceptAll"
        Click           ${SEL_Cookie_AllowAll}
    ELSE
        Click           ${SEL_Cookie_Decline}
    END
    sleep               ${TIME_BETWEEN_CLICKS1}        #workaround: Probliknutí cele stránky po kliknutí na tlačítko


Logout
   Go to               ${URL}
   Click               ${SEL_HeaderLoginErrorTxt}
   Click               ${SEL_UserBoxLogoutBtn}


Pridat do kosiku
    [Arguments]       ${Zbozi}
   # ${old_mode} =      Set Strict Mode    False              #zajišťuje ingnorování více stejných selektorlů a jejich klikne prostě na ten první
    Type Text   ${SEL_SearchGlobal}     ${Zbozi}             #zde DOPLNIT ks pro napsání textu, který je v ${Zbozi} do vyhledávání
    Sleep       ${TIME_BETWEEN_CLICKS1}                      #Statický timeout
    Click       ${SEL_BtnSearchGlobal}                       #zde DOPLNIT ks pro kliknutí na hledat, selektor bude text "Hledat"
    Sleep       ${TIME_BETWEEN_CLICKS2}                      #Statický timeout

    #zde DOPLNIT ks pro kliknout talčítko "Do košíku" a kolikátou položku použít v rámci košíku pomocí selektorů
    Click       css=[${SEL_ProductID}=${ZBOZI01_ID}]

    #ověří že je zboží v košíku
    ${cart_text}=       Get Text                    ${SEL_Cart}
    Log                 ${cart_text}


Pridat do kosiku varianta produkt id
    [Arguments]         ${Zbozi}     ${produkt_id}     ${Kusu}
    #${old_mode} =      Set Strict Mode    False     #zajišťuje ingnorování více stejných selektorlů a klikne prostě na ten první
    # použít původní verzi a rozšířit ji o
    Type Text   ${SEL_SearchGlobal}    ${Zbozi}
    Sleep       ${TIME_BETWEEN_CLICKS1}
    Click       ${SEL_BtnSearchGlobal}  #zde DOPLNIT ks pro kliknutí na hledat, selektor bude text "Hledat"
    ${old_mode} =      Set Strict Mode    False     #zajišťuje ingnorování více stejných selektorlů a klikne prostě na ten první
    #Click               css=kde se jako selektor použije ${produkt_id} a také data-test="btnAdd"   # kliknutí na tlačítko "Do košíku" pro konkrétní produkt
    Click               css=[${SEL_ProductID}="${produkt_id}"][${SEL_BtnAdd}]

    ${Pocet}            Evaluate                    ${Kusu} - 1   #odečtení 1 kusu, protože 1 zboží jsme již přidali

    # přidání zbylého počtu kusů pomocí vícenásobného kliknutí na tlačítko plus u konkrétního produktu
    #Click               css=kde se jako selektor použije nadřezená třída + ${produkt_id} + také data-test="btnPlus"   Je třeba přidat parametr:   clickCount=${Pocet}

    Click               css=${SEL_CssForAdding} [${SEL_ProductID}="${produkt_id}"][${SEL_BtnPlus}]   clickCount=${Pocet}
    #Click              css=[data-product-id="${produkt_id}"][data-test="btnPlus"]  clickCount=${Pocet}
    Sleep   ${TIME_BETWEEN_CLICKS1}


Odebrání několik ks
    Click       css=[class="sc-f269a4e2-0 sc-54b62df6-0 fopvWD keHQgT"]
    Sleep       ${TIME_BETWEEN_CLICKS1}
    Click       css=[class="sc-f269a4e2-0 sc-54b62df6-0 fopvWD keHQgT"]

Odebrání několik ks lepší

    [Arguments]  ${Kusu}
    ${old_mode} =      Set Strict Mode    False     #zajišťuje ingnorování více stejných selektorlů a klikne prostě na ten první
    Click       ${SEL_BtnMinus}           clickCount=${Kusu}    delay=100ms
    Sleep       ${TIME_BETWEEN_CLICKS1}


Odebrání z kosiku komplet
    Click       ${SEL_Odebrani_kompletni}
    Sleep       ${TIME_BETWEEN_CLICKS1}

Pred_testy
    Open Browser        ${URL}                              headless=false     #dá se použít pro nastavení dalších parametru - umožňuje např vypnout headless mode
    New Page            ${URL}
    Get Title           contains                            Rohlik

Po_testech
    Take Screenshot



