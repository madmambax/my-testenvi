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
    Login               lukasbaron@seznam.cz              tajneheslotajneheslo        LB

    #zvažte kolik parametrů bude třeba
#    Pridat Do Kosiku                        banán
#    Pridat do kosiku varianta pocet         banán  5
    Pridat do kosiku varianta produkt id    banán  1349777  5

    Logout


*** Keywords ***

Login
    [Arguments]         ${email}                            ${heslo}                    ${validation}

    Open Browser        ${URL}                              headless=false     #dá se použít pro nastavení dalších parametru - umožňuje např vypnout headless mode

    Get Title           contains                            Rohlik

    Cookie              AcceptAll


    Click               data-test=header-user-icon

    Type Text           id=email             ${email}
    Type Text           id=password          ${heslo}
    Click               data-test=btnSignIn
    Sleep    2
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
    Go To            ${URL}
    Click            id=headerUser
    Click            data-test=user-box-logout-button


Pridat do kosiku
    [Arguments]         ${Zbozi}

#    ${old_mode} =      Set Strict Mode    False
    #zde DOPLNIT ks pro napsání textu, který je v ${Zbozi} do vyhledávání
    Type Text           id=searchGlobal      ${Zbozi}

    #zde DOPLNIT ks pro kliknutí na hledat, selektor bude text "Hledat"
    Sleep               3                           # čeká 3 sekundu
    Click               text=Hledat
    Sleep               3
    #zde DOPLNIT ks pro kliknout talčítko "Do košíku"
    Click               data-test=btnAdd

    #ověří že je zboží v košíku
    ${cart_text}=       Get Text                    id=cart
    Log                 ${cart_text}

    # zde DOPLNIT porovnání zda text z košíku obsahuje zboží
    # použijte příkaz Get Text a parametr  matches  (?i)${Zbozi}
    # (?i)  znamená že se bere case insensitive

    Take Screenshot



Pridat do kosiku varianta produkt id
    [Arguments]         ${Zbozi}     ${produkt_id}     ${Kusu}
    Type Text           id=searchGlobal      ${Zbozi}
    Sleep    2
    Click               data-test=header-search-button
    Sleep    4

    # použít původní verzi a rozšířit ji o

    # kliknutí na tlačítko "Do košíku" pro konkrétní produkt
    Click               css=[data-product-id="${produkt_id}"]
    Sleep    4

    #odečtení 1 kusu, protože 1 zboží jsme již přidali
    Click               css=.amountCounterWrap [data-test="btnMinus"]
    Sleep    3

    # přidání zbylého počtu kusů pomocí vícenásobného kliknutí na tlačítko plus u konkrétního produktu
    Click               css=[data-product-id="${produkt_id}"]
    Click               css=.amountCounterWrap [data-test="btnPlus"]  clickCount=4

    Sleep    3




