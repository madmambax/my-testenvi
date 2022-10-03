*** Settings ***
Library     Browser

*** Variables ***
${URL}      https://www.rohlik.cz/

*** Test Cases ***
Prihlaseni
    Login       Lucykoranova@gmail.com              Jessie11#        LK
    Logout

Pridat do kosiku
    Login       Lucykoranova@gmail.com              Jessie11#        LK
    Type Text           id=searchGlobal             Alpro
    Sleep               1
    Click               text=Hledat
    Sleep               1

Kontrola obsahu kosiku
    ${cart_text}=       Get Text                    id=cart
    Log                 ${cart_text}
    Get Text            id=cart                     matches                             (?i)${Zbozi}
    Take Screenshot

Odebrani zbozi z kosiku
    ${Pocet}            Evaluate                    ${Kusu} - 1
    Click           css=[data-product-id="${produkt_id}"][data-test="btnMinus"]         clickCount=${Pocet}

Kotrola kosiku
    ${cart_text}=       Get Text                    id=cart
    Log                 ${cart_text}
    Get Text            id=cart                     matches                             (?i)${Zbozi}
    Take Screenshot





*** Keywords ***
Login
    [Arguments]         ${email}                            ${heslo}                    ${validation}

    #otevreni prohlizece
    Open Browser        ${URL}

    #Kontrola nacteni stranky
    Get Title       ==   Online supermarket Rohlik.cz — nejrychlejší doručení ve městě

    #odsouhlaseni cookies
    Cookie              AcceptAll

    #kliknuti na ikonu prihlaseni
    Click               id=headerLogin

    #vlozeni emailu a hesla
    Type Text           id=email             ${email}
    Type Text           id=password          ${heslo}

    #kliknuti na prihlaseni
    Click               data-test=btnSignIn


    #overeni prihlaseni + screenshot
    Get Text            data-test=header-user-icon          ==      ${validation}
    ${log}=   Get Text  data-test=header-user-icon
    Log                 ${log}
    Take Screenshot


Logout
   Go to               ${URL}
   Click               xpath=//div[@class='u-mr--8']
   Click               data-test=user-box-logout-button

Cookie
    [Arguments]         ${type}
    IF  "${type}" == "AcceptAll"
        Click           id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    ELSE
        Click           id="CybotCookiebotDialogBodyButtonDecline"
    END
    sleep               1

Pridat do kosiku
    [Arguments]         ${Zbozi}     ${Kusu}
    Type Text           id=searchGlobal             ${Zbozi}
    Sleep               5
    Click               text="Hledat"
    Sleep               5
    Click               data-test=btnAdd >> nth=2   delay=100ms   clickCount=${Kusu}
    Sleep               5

Kontrola obsahu kosiku
    ${cart_text}=       Get Text                    id=cart
    Log                 ${cart_text}
    Get Text            id=cart                     matches                             (?i)${Zbozi}
    Take Screenshot

Odebrani zbozi z kosiku
    ${Pocet}            Evaluate                    ${Kusu} - 1
    Click           css=[data-product-id="${produkt_id}"][data-test="btnMinus"]         clickCount=${Pocet}

Kotrola kosiku
    ${cart_text}=       Get Text                    id=cart
    Log                 ${cart_text}
    Get Text            id=cart                     matches                             (?i)${Zbozi}
    Take Screenshot