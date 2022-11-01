# požadavky
#   pip install robotframework-browser
#   rfbrowser init


*** Settings ***
Documentation   Automatizace rohlik.cz s BrowserLibrary
Library  Browser

*** Variables ***
${URL}      https://www.rohlik.cz/


*** Test Cases ***

Pridani zbozi do kosiku
    Login               radek.tester@seznam.cz              tajneheslotajneheslo        JT
    #Pridat do Kosiku                        banán
    #Pridat do kosiku varianta pocet         banán  5
    Pridat do kosiku varianta produkt id    banán   1349777   5
    #Odebrání několik ks
    #Odebrání z kosiku komplet
    Odebrání několik ks lepší
    Logout


*** Keywords ***

Login
    [Arguments]         ${email}                            ${heslo}                    ${validation}

    Open Browser        ${URL}                              headless=false     #dá se použít pro nastavení dalších parametru - umožňuje např vypnout headless mode
    New Page            ${URL}
    Get Title           contains                            Rohlik
    Cookie              AcceptAll
    Click               id=headerLogin
    Type Text           id=email             ${email}
    Type Text           id=password          ${heslo}
    Click               data-test=btnSignIn
    Get Text            data-test=header-user-icon          ==      ${validation}
    ${log}=   Get Text  data-test=header-user-icon
    Log                 ${log}
    Take Screenshot


Cookie
    [Arguments]         ${type}
    IF  "${type}" == "AcceptAll"
        Click           id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    ELSE
        Click           id="CybotCookiebotDialogBodyButtonDecline"
    END
    sleep               1      #workaround: Probliknutí cele stránky po kliknutí na tlačítko


Logout
   Go to               ${URL}
   Click               xpath=//div[@class='u-mr--8']
   Click               data-test=user-box-logout-button
   Take Screenshot

Pridat do kosiku
    [Arguments]         ${Zbozi}

#    ${old_mode} =      Set Strict Mode    False
    #zde DOPLNIT ks pro napsání textu, který je v ${Zbozi} do vyhledávání
    Type Text   id=searchGlobal    ${Zbozi}
    Sleep               1                           #Statický timeout

    #zde DOPLNIT ks pro kliknutí na hledat, selektor bude text "Hledat"
    Click       text="Hledat"
    Sleep               5                           #Statický timeout

    #zde DOPLNIT ks pro kliknout talčítko "Do košíku" a kolikátou položku použít v rámci košíku pomocí selektorů
    Click       css=[data-product-id="1349777"]



    #ověří že je zboží v košíku
    ${cart_text}=       Get Text                    id=cart
    Log                 ${cart_text}
    Take Screenshot

Pridat do kosiku varianta produkt id
    [Arguments]         ${Zbozi}     ${produkt_id}     ${Kusu}

    # použít původní verzi a rozšířit ji o
    Type Text   id=searchGlobal    ${Zbozi}

    #zde DOPLNIT ks pro kliknutí na hledat, selektor bude text "Hledat"
    Click       text="Hledat"

    # kliknutí na tlačítko "Do košíku" pro konkrétní produkt
    #Click               css=kde se jako selektor použije ${produkt_id} a také data-test="btnAdd"
    Click                css=[data-product-id="${produkt_id}"][data-test="btnAdd"]


    #odečtení 1 kusu, protože 1 zboží jsme již přidali
    ${Pocet}            Evaluate                    ${Kusu} - 1

    # přidání zbylého počtu kusů pomocí vícenásobného kliknutí na tlačítko plus u konkrétního produktu
    #Click               css=kde se jako selektor použije nadřezená třída + ${produkt_id} + také data-test="btnPlus"   Je třeba přidat parametr:   clickCount=${Pocet}
    Click                css=[data-product-id="${produkt_id}"][data-test="btnPlus"]  clickCount=${Pocet}
    Sleep   1
    Take Screenshot

Odebrání několik ks
    Click       css=[class="sc-f269a4e2-0 sc-54b62df6-0 fopvWD keHQgT"]
    Sleep  1
    Click       css=[class="sc-f269a4e2-0 sc-54b62df6-0 fopvWD keHQgT"]
    Take Screenshot

Odebrání z kosiku komplet
    Click       css=[class="sc-54fde564-4 dEfkOv"]
    Sleep  1
    Take Screenshot


Odebrání několik ks lepší
    [Arguments]         ${Kusu}
    Click               css=[class="sc-f269a4e2-0 sc-54b62df6-0 fopvWD keHQgT"]             clickCount=${Kusu}    delay=100ms
    Sleep  1
    Take Screenshot

#id=1349777

