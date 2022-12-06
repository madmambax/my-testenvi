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
    Login               a.byrtusova1@gmail.com              testovaci        AB
    Sleep               5
    #zvažte kolik parametrů bude třeba
    #Pridat Do Kosiku                        banán
    #Pridat do kosiku varianta pocet         banán            3
    Pridat do kosiku varianta produkt id    banán            1381458                    3
    Sleep               5
    Logout


*** Keywords ***

Login
    [Arguments]         ${email}                            ${heslo}                    ${validation}

    Open Browser        ${URL}                              headless=false     #dá se použít pro nastavení dalších parametru - umožňuje např vypnout headless mode
    New Page            ${URL}
    Get Title           contains                            Rohlik

    Cookie              AcceptAll

    Click               id=headerLogin
    Sleep               5

    Type Text           id=email             ${email}
    Type Text           id=password          ${heslo}
    Click               data-test=btnSignIn
    Sleep               10
    Get Text            data-test=header-user-icon          ==      ${validation}
    ${log}=   Get Text  data-test=header-user-icon
    Log                 ${log}
   # Take Screenshot


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
   Sleep               5
   Click               xpath=//div[@class='u-mr--8']
   Click               data-test=user-box-logout-button


Pridat do kosiku
    [Arguments]         ${Zbozi}

    ${old_mode} =      Set Strict Mode    False
    #zde DOPLNIT ks pro napsání textu, který je v ${Zbozi} do vyhledávání
    Sleep               2
    Type Text           id=searchGlobal             ${Zbozi}
    Sleep    2
    #zde DOPLNIT ks pro kliknutí na hledat, selektor bude text "Hledat"
    Hledat
    Sleep    2
    #zde DOPLNIT ks pro kliknout talčítko "Do košíku"
    Do kosiku
    Sleep               5
    Go to               ${URL}
    Sleep               10
    #ověří že je zboží v košíku
    ${cart_text}=       Get Text                    id=cart
    Log                 ${cart_text}
    # zde DOPLNIT porovnání zda text z košíku obsahuje zboží
    # použijte příkaz Get Text a parametr  matches  (?i)${Zbozi}
    # (?i)  znamená že se bere case insensitive
    Get Text            id=cart                     matches          (?i)${Zbozi}

    Take Screenshot


Pridat do kosiku varianta pocet
    [Arguments]         ${Zbozi}                    ${Kusu}
    Type Text           id=searchGlobal             ${Zbozi}
    Hledat
    Sleep               5
    Click               data-test=btnAdd >> nth=1   clickCount=${Kusu}
    Sleep               5



Pridat do kosiku varianta produkt id

    [Arguments]         ${Zbozi}     ${produkt_id}     ${Kusu}

    Sleep               2
    Type Text           id=searchGlobal             ${Zbozi}
    Sleep               10
    Hledat
    Sleep               10
    # použít původní verzi a rozšířit ji o
    # kliknutí na tlačítko "Do košíku" pro konkrétní produkt
    Click               css=[data-product-id="${produkt_id}"][data-test="btnAdd"]
    Sleep               5

    #odečtení 1 kusu, protože 1 zboží jsme již přidali
    ${old_mode} =      Set Strict Mode    False
    Click               css=[data-product-id="${produkt_id}"][data-test="btnMinus"]
    Sleep               5
    # přidání zbylého počtu kusů pomocí vícenásobného kliknutí na tlačítko plus u konkrétního produktu
    ${ZbylyPocetKusu}           Evaluate                    ${Kusu} - 1
    Sleep                  5
    Click               css=.sc-da00148b-0 hoKRXJ [data-product-id="${produkt_id}"][data-test="btnAdd"]   clickCount=${ZbylyPocetKusu}
    Sleep               8


Hledat
    Click               text="Hledat"

Do kosiku
    Click               data-test=btnAdd


