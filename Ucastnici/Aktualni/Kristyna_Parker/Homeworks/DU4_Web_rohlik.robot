*** Settings ***
Documentation   Automatizace rohlik.cz s BrowserLibrary
Library  Browser

*** Variables ***
${URL}      https://www.rohlik.cz/
${title}    Online supermarket Rohlik.cz

*** Test Cases ***

Přihlášení, vložení zboží do košíku, odebrání zboží, odhlášení
    Login               pipicog440@wiroute.com         testovaciucet       KT
    Přidat do košíku    brambory    1313883    4
    Odebrat z košíku
    Logout

Přihlášení - špatný email
    Login               pi@wiroute.com         testovaciucet       Účet

Přihlášení - špatné heslo
    Login               pipicog440@wiroute.com         testovaciucet4141       Účet

*** Keywords ***

Login
    [Arguments]         ${email}           ${heslo}       ${user}
    New Browser         chromium       headless=false
    New Page            ${URL}
    Get Title           contains        ${title}
    Cookie              AcceptAll
    Click               data-test=header-user-icon
    Type Text           id=email                                    ${email}
    Type Text           id=password                                 ${heslo}
    Click               data-test=btnSignIn
    Get Text            data-test=header-user-icon       ==        ${user}
    ${log}=   Get Text  data-test=header-user-icon
    Log                 ${log}
    Take Screenshot
    Sleep    2
    
Cookie
    [Arguments]         ${type}
    IF  "${type}" == "AcceptAll"
        Click           id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    ELSE
        Click           id="CybotCookiebotDialogBodyButtonDecline"
    END

Přidat do košíku
    [Arguments]         ${Zbozi}    ${Cislo}       ${Mnozstvi}
    Type Text           id=searchGlobal        ${Zbozi}
    Click               css=[data-product-id="${Cislo}"][data-test="btnAdd"]
    ${Pocet}            Evaluate    ${Mnozstvi} - 1
    Click               css=[data-product-id="${Cislo}"][data-test="btnPlus"]   clickCount= ${Pocet}
#    Click               css=[data-test=btnAdd] >> nth=1
#    ${Pocet}            Evaluate    ${Mnozstvi} - 1
#    Click               css=[data-gtm-button="addPiece"] >> nth=1    clickCount=${Pocet}
    Sleep               2
    Go To               ${URL}
    Sleep               2

Odebrat z košíku
    Click               data-test=IconCart
    Sleep               5
    Click               css=[data-gtm-button="clear-cart"]
    Sleep               3
Logout
    Go To               ${URL}
    Click               id=headerUser
    Sleep               1
    Click               data-test=user-box-logout-button
    Sleep               2