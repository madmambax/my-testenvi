*** Settings ***
Library  Browser
Resource    ../../../OLD/Aneta_Moravcová/DU4_Web.robot

*** Variables ***
${Rohlik web}      https://www.rohlik.cz/

*** Test Cases ***
Otevření browseru se stránkou rohlik.cz, zamítnout cookies, přihlásit se, přidat zboží, odebrat zobží a odhlásit se.
    Přihlášení     jt5@seznam.cz     Heslo12345     JT 
    Přidání zboží do košíku     Dr. Oetker Krém na dukátové buchtičky     1420916     10
    Odebrání zboží z košíku
    Odhlášení

Přihlášení se a následné odhlášení se (pozitivní test)
    Přihlášení    jt5@seznam.cz     Heslo12345     JT
    Odhlášení

Přihlášení se se špatným heslem (negativní test)
    Přihlášení     jt5@seznam.cz     Heslo123456     JT

Odebrání zboží když žádné zboží není přidáno (negativní test)
    Přihlášení    jt5@seznam.cz     Heslo12345     JT
    Odebrání zboží z košíku
    Odhlášení

*** Keywords ***
Přihlášení
    [Arguments]     ${email}     ${password}     ${user}
    New Browser     chromium     headless=false
    New Page        ${Rohlik web}
    Get Title       contains    Online supermarket Rohlik.cz
    Click           id=CybotCookiebotDialogBodyButtonDecline
    Sleep           2
    Click           "Účet"
    Sleep           2
    Type Text       id=email    ${email}
    Type text       id=password    ${password}
    Click           "Přihlásit se"
    Sleep           2
    Get Text        data-test=header-user-icon   ==   ${user}
    Sleep           2
    Take Screenshot

Odhlášení
    Go To           ${Rohlik web}
    Sleep           2
    Click           id=headerUser
    Sleep           2
    Click           "Odhlásit se"
    Sleep           2
    Take Screenshot

Přidání zboží do košíku
    [Arguments]     ${goods}     ${goods ID}     ${quantity}
    Type Text       id=searchGlobal    ${goods}
    Click           css=[data-product-id="${goods ID}"][aria-label*="Přidat jeden kus."]
    ${quantity}     Evaluate    ${quantity} - 1
    Click           css=[data-product-id="${goods ID}"][data-gtm-button="addPiece"]    clickCount= ${quantity}
    Sleep           2
    Take Screenshot

Odebrání zboží z košíku
    Go To           ${Rohlik web}
    Sleep           2
    Click           data-test=headerPrice
    Sleep           2
    Click           css=[class="clearCart"]
    Sleep           2
    Take Screenshot