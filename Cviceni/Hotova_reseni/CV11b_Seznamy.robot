# požadavky
#   pip install robotframework-browser
#   rfbrowser init


*** Settings ***
Documentation   Automatizace rohlik.cz s BrowserLibrary
Library  Browser

*** Variables ***
${URL}      https://www.rohlik.cz/


*** Test Cases ***

#Graficky se jedná o 3 typy, programátorsky to je ale stejné
#<button aria-label="Přidat jeden kus." data-test="btnAdd" data-gtm-button="addPiece" data-product-id="1349777"  class="sc-y4uoql-0 sc-p1h2ml-1 bDHbgu cAFXMJ">Do košíku</button>
#<button aria-label="Přidat jeden kus." data-test="btnPlus" data-gtm-button="addPiece" data-product-id="1353357" class="sc-y4uoql-0 sc-qfx827-0 bDHbgu jvnTbh"><svg xmlns="http://www.w3.org/2000/svg" width="16px" height="16px" viewBox="0 0 16 16"><path fill="#FFFFFF" fill-rule="evenodd" clip-rule="evenodd" d="M13 9H9V13C9 13.55 8.55 14 8 14C7.45 14 7 13.55 7 13V9H3C2.45 9 2 8.55 2 8C2 7.45 2.45 7 3 7H7V3C7 2.45 7.45 2 8 2C8.55 2 9 2.45 9 3V7H13C13.55 7 14 7.45 14 8C14 8.55 13.55 9 13 9Z"></path></svg></button>
#<button aria-label="Přidat jeden kus." data-test="btnPlus" data-gtm-button="addPiece" data-product-id="1353357" class="sc-y4uoql-0 cDkKoy"><svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 16 16"><path fill="#1C2529" fill-rule="evenodd" clip-rule="evenodd" d="M13 9H9V13C9 13.55 8.55 14 8 14C7.45 14 7 13.55 7 13V9H3C2.45 9 2 8.55 2 8C2 7.45 2.45 7 3 7H7V3C7 2.45 7.45 2 8 2C8.55 2 9 2.45 9 3V7H13C13.55 7 14 7.45 14 8C14 8.55 13.55 9 13 9Z"></path></svg></button>

Pridani zbozi do kosiku
    Login               radek.tester@seznam.cz              tajneheslotajneheslo        JT
    Type Text           id=searchGlobal             banán
    Sleep               1                           # čeká 1 sekundu
    Click               text=Hledat                 # ???
    Sleep               1                           # čeká 1 sekundu

#    ${old_mode} =      Set Strict Mode    False
#    Click              css=[data-test=btnAdd]       # Neselže, pokud selektor ukazuje více prvků
#    Set Strict Mode    ${old_mode}


#    Click               css=[data-test=btnAdd] >> nth=1
#    Click               css=[data-product-id="1353357"] >> nth=1

#     Click              css=[data-product-id="1353357"]                # pokud není žádné zboží v košíku stčí klik na p-id

#     Click               css=.sc-oad7xy-0 [data-product-id="1353357"][data-test="btnPlus"]                # pokud již je zboží v košíku
#     Click               css=.sc-oad7xy-0 >> [data-product-id="1353357"][data-test="btnPlus"]                # pokud již je zboží v košíku


    Sleep               1
    Logout


*** Keywords ***

Login
    [Arguments]         ${email}                            ${heslo}                    ${validation}

    Open Browser        ${URL}                              headless=false     #dá se použít pro nastavení dalších parametru - umožňuje např vypnout headless mode
    New Page            ${URL}

    Get Title           contains                            Rohlik

    Cookie              AcceptAll


    Click               data-test=header-user-icon

    Type Text           data-test=user-login-form-email             ${email}
    Type Text           data-test=user-login-form-password          ${heslo}
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
    Type Text           id=searchGlobal             ${Zbozi}
    Click               text="Hledat"               # tlačítko Hledat
    Click               data-test=btnAdd >> nth=1   # způsobuje někdy zmizení uživatele, scrol donwn, důvod někdy klikne na zboží níže

    #ověří že je zboží v košíku
    ${cart_text}=       Get Text                    id=cart
    Log                 ${cart_text}
    Get Text            id=cart                     matches                             (?i)${Zbozi}    # (?i)  znamená že se bere case insensitive
    Take Screenshot


Pridat do kosiku varianta pocet
    [Arguments]         ${Zbozi}                    ${Kusu}
    Type Text           id=searchGlobal             ${Zbozi}
    Click               text="Hledat"               # tlačítko Hledat
    Sleep               5                           #Statický timeout
    Click               data-test=btnAdd >> nth=2   delay=100ms   clickCount=${Kusu}
    Sleep               1                           #Statický timeout -  čeká na aktualizaci košíku

    #ověří že je zboží v košíku
    ${cart_text}=       Get Text                    id=cart
    Log                 ${cart_text}
    Get Text            id=cart                     matches                             (?i)${Zbozi}    # (?i)  znamená že se bere case insensitive
    Take Screenshot


Pridat do kosiku varianta produkt id
    [Arguments]         ${Zbozi}                    ${produkt_id}        ${Kusu}
    Type Text           id=searchGlobal             ${Zbozi}
    Sleep               1                           #Statický timeout
    Click               text="Hledat"               # tlačítko Hledat
    Sleep               5                           #Statický timeout

    Click               css=[data-product-id="${produkt_id}"][data-test="btnAdd"]            # způsobuje někdy zmizení uživatele, scrol donwn, důvod někdy klikne na zboží níže
    Sleep               1
    # Kusu - 1
    ${Pocet}            Evaluate                    ${Kusu} - 1
    Click               css=.sc-oad7xy-0 [data-product-id="${produkt_id}"][data-test="btnPlus"]           clickCount=${Pocet}

    #ověří že je zboží v košíku
    ${cart_text}=       Get Text                    id=cart
    Log                 ${cart_text}
    Get Text            id=cart                     matches                             (?i)${Zbozi}    # (?i)  znamená že se bere case insensitive
    Take Screenshot



