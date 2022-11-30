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
    Login               bavemal543@cebaike.com              tajneheslotajneheslo        JT
#    Pridat Do Kosiku                        banán
#    Pridat do kosiku varianta pocet         banán  5
    Pridat do kosiku varianta produkt id    banán  1349777  5
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


Pridat do kosiku
    [Arguments]         ${Zbozi}

#    ${old_mode} =      Set Strict Mode    False
    #zde DOPLNIT ks pro napsání textu, který je v ${Zbozi} do vyhledávání


    #zde DOPLNIT ks pro kliknutí na hledat, selektor bude text "Hledat"


    #zde DOPLNIT ks pro kliknout talčítko "Do košíku"


    #ověří že je zboží v košíku
    ${cart_text}=       Get Text                    id=cart
    Log                 ${cart_text}

    # zde DOPLNIT porovnání zda text z košíku obsahuje zboží
    # použijte příkaz Get Text a parametr  matches  (?i)${Zbozi}
    # (?i)  znamená že se bere case insensitive

    Take Screenshot



Pridat do kosiku varianta produkt id
    [Arguments]         ${Zbozi}     ${produkt_id}     ${Kusu}


    # použít původní verzi a rozšířit ji o

    # kliknutí na tlačítko "Do košíku" pro konkrétní produkt
    Click               css=kde se jako selektor použije ${produkt_id} a také data-test="btnAdd"


    #odečtení 1 kusu, protože 1 zboží jsme již přidali

    # přidání zbylého počtu kusů pomocí vícenásobného kliknutí na tlačítko plus u konkrétního produktu
    Click               css=kde se jako selektor použije nadřezená třída + ${produkt_id} + také data-test="btnPlus"   Je třeba přidat parametr:   clickCount=${Pocet}




