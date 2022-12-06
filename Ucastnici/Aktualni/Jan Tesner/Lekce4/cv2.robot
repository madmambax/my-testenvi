*** Settings ***
Documentation   Automatizace rohlik.cz s BrowserLibrary
Library  Browser

*** Variables ***
#${b_timeput} =     Set Browser Timeout
#${TIMEOUT_BROWSER}
${URL}      https://www.rohlik.cz/

*** Test Cases ***

Pridani zbozi do kosiku
    Login               hemof56369@probdd.com              7Csa6aZfQUbagpJ        JT
    #zvažte kolik parametrů bude třeba
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
    Sleep               2
    Type Text           id=email             ${email}
    Type Text           id=password          ${heslo}
    Click               data-test=btnSignIn
    Sleep               2
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
    Type Text           id=searchGlobal             ${Zbozi}
    #zde DOPLNIT ks pro kliknutí na hledat, selektor bude text "Hledat"
    Click               text=Hledat
    Sleep               2
    #zde DOPLNIT ks pro kliknout talčítko "Do košíku"
    Click               css=[data-test=btnAdd] >> nth=1
    Sleep               2

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
    Click               text="Hledat"               # tlačítko Hledat
    Sleep               2                           #Statický timeout
    Click               data-test=btnAdd >> nth=2   delay=100ms   clickCount=${Kusu}
    Sleep               2                           #Statický timeout -  čeká na aktualizaci košíku

    #ověří že je zboží v košíku
    ${cart_text}=       Get Text                    id=cart
    Log                 ${cart_text}
    Get Text            id=cart                     matches                             (?i)${Zbozi}
    Take Screenshot

Pridat do kosiku varianta produkt id
    [Arguments]         ${Zbozi}     ${produkt_id}     ${Kusu}
    ${old_mode} =      Set Strict Mode    False
    # použít původní verzi a rozšířit ji o
    Type Text           id=searchGlobal             ${Zbozi}
    Sleep               5
    Click               text="Hledat"               # tlačítko Hledat
    Sleep               5                           #Statický timeout
    # kliknutí na tlačítko "Do košíku" pro konkrétní produkt
    Click               css=[data-product-id="${produkt_id}"][data-test="btnAdd"]
    Click               css=[data-product-id="${produkt_id}"][data-test="btnPlus"]
    Sleep               5
    #odečtení 1 kusu, protože 1 zboží jsme již přidali
    Click               css=[data-product-id="${produkt_id}"][data-test="btnMinus"]
    Sleep               5
    # přidání zbylého počtu kusů pomocí vícenásobného kliknutí na tlačítko plus u konkrétního produktu
    ${Pocet}           Evaluate                    ${Kusu} - 1
    Click              css=[data-product-id="${produkt_id}"][data-test="btnPlus"]  clickCount=${Pocet}
    Sleep               5










#*** Settings ***
#Documentation   Automatizace rohlik.cz s BrowserLibrary
#Library  Browser
#
#
#*** Variables ***
#${URL}      https://www.rohlik.cz/
#
#
#*** Test Cases ***
#
#Uspesne prihlaseni
#    Login               bavemal543@cebaike.com              tajneheslotajneheslo        MS
#    Logout              MS
#
#
#Pridani zbozi do kosiku
#    Login               bavemal543@cebaike.com              tajneheslotajneheslo        MS
#    Type Text           id=searchGlobal             banán
#    Sleep               1                           # čeká 1 sekundu
#    Click               text=Hledat                 # ???
#    Sleep               1                           # čeká 1 sekundu
#    Click               css=[data-test=btnAdd] >> nth=1            # způsobuje někdy zmizení uživatele, scrol donwn, důvod někdy klikne na zboží níže
#    Sleep               1
#    Logout              MS
#
#
#*** Keywords ***
#
#Login
#    [Arguments]         ${email}                            ${heslo}                    ${validation}
#
#    Open Browser        ${URL}                              headless=false     #dá se použít pro nastavení dalších parametru - umožňuje např vypnout headless mode
#    New Page            ${URL}
#
#    Get Title           contains                            Rohlik
#
#    Cookie              AcceptAll
#
#
#    Click               id=headerLogin
#
#    Type Text           id=email                                    ${email}
#    Type Text           id=password                                 ${heslo}
#    Click               data-test=btnSignIn
#    Get Text            data-test=header-user-icon          ==      ${validation}
#    ${log}=   Get Text  data-test=header-user-icon
#    Log                 ${log}
#    Take Screenshot
#
#
#
#
#Cookie
#    [Arguments]         ${type}
#    IF  "${type}" == "AcceptAll"
#        Click           id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
#    ELSE
#        Click           id="CybotCookiebotDialogBodyButtonDecline"
#    END
#
##    sleep               1      #workaround: Probliknutí cele stránky po kliknutí na tlačítko
#
#
## Vytvořte KS pro Odlášení, tak aby fungoval vždy (Pro oba testy)
#Logout
#    [Arguments]         ${validation}
#    Go To               ${URL}
#    Click               data-test=header-user-icon
#    sleep               2
#    Click               data-test=user-box-logout-button
#    sleep               2
#    Get Text            data-test=header-user-icon  ==  Přihlásit
#
## zde je nutné doplnit KS
