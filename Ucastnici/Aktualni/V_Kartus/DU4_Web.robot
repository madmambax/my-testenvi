*** Settings ***
Documentation   Automatizace rohlik.cz s BrowserLibrary
Library  Browser

*** Variables ***
${URL}      https://www.rohlik.cz/

*** Test Cases ***
bad login prihlaseni
    Login               dsadsad@sdas.cz                     dasdas                      Přihlásit

good login prihlaseni
    Login                           radek.tester@seznam.cz              tajneheslotajneheslo        JT
    #vysypat pokud je plny kosik     css=.cartCount      #css=.sc-c57c261e-4.dHRBLh.cartCount         #css=.sc-c57c261e-4.jWscLy.cartCount
    Pridat do kosiku                Banán Chiquita                      1349785                     8
    Odebrat z kosiku                Banán Chiquita                      1349785                     4
    Logout



*** Keywords ***
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
    Click               id=headerLogin
    sleep               5
        #zadej email a heslo a odklikni prihlaseni
    Type Text           id=email             ${email}
    Type Text           id=password          ${heslo}
    Click               data-test=btnSignIn
    sleep               5
        #zkontroluj jestli prihlaseni proběhlo uspěsne
    Get Text            data-test=header-user-icon          ==      ${validation}
    ${log}=   Get Text  data-test=header-user-icon
    Log                 ${log}

Logout
        #pokud jsi prihlaseny = odhlasit
   Click               xpath=//div[@class='u-mr--8']
   Click               data-test=user-box-logout-button

Cookie
    [Arguments]         ${type}
    IF  "${type}" == "AcceptAll"
        # klinout na "Vše povolit"
        Click               id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    ELSE
        # klinout na "Odmítnout"
        Click               id=CybotCookiebotDialogBodyButtonDecline
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
    [Arguments]         ${Zbozi}     ${produkt_id}     ${Kusu}
        #do pole "heldat název" zadá jméno produktu a vyhledá
    type text           id=searchGlobal     ${Zbozi}
    Click               css=.sc-4b6d3da4-2.eUMBpW       #hledat
    sleep               5
    Click               text="Doporučené řazení"
        #zboží ještě není v košíku tz. vyhledáme zboží podle produk id a přidám 'do košíku'
    Click               css=[data-product-id="${produkt_id}"][data-test="btnAdd"]
    sleep               5

    Click               data-test=cart-redirectToCart      #klik na header
    sleep               5
    Take Screenshot
        #odečtení 1 kusu, protože 1 zboží jsme již přidali po kliknutí na pridat do kosiku
    ${Pocet}            Evaluate                    ${Kusu} - 1
        #přidání zbylého počtu kusů pomocí vícenásobného kliknutí na tlačítko plus u konkrétního produktu
        #Click          css=kde se jako selektor použije nadřezená třída + ${produkt_id} + také data-test="btnPlus"   Je třeba přidat parametr:   clickCount=${Pocet}
    Click               css=[data-product-id="${produkt_id}"][data-test="btnPlus"]  clickCount=${Pocet}
    sleep               5

Odebrat z kosiku
    [Arguments]         ${Zbozi}     ${produkt_id}     ${Kusu}
    type text           id=searchGlobal     ${Zbozi}
    Click               css=.sc-4b6d3da4-2.eUMBpW    #hledat
    sleep               5
    Click               text="Doporučené řazení"
    sleep               5
    Click               data-test=cart-redirectToCart   #klik na header
    sleep               5
    ${Pocet}            Evaluate                    ${Kusu} - 1
    Click               css=[data-product-id="${produkt_id}"][data-test="btnMinus"]  clickCount=${Pocet}
    sleep               5
