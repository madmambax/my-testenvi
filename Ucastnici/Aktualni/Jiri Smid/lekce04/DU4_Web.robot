#DÚ4

*** Settings ***
Library  Browser


*** Variables ***
${URL}              https://www.rohlik.cz/
${title}            Online supermarket Rohlik.cz
${headerusericon}   data-test=header-user-icon


*** Test Cases ***

Pozitivní test: Přihlášení, přidání zboží do košíku, odebrání zboží z košíku, odhlášení
    Přihlášení                 sm.jiri@seznam.cz     Testovani864ZdR     JŠ
    Přidání zboží do košíku    káva    1385789    7
    Odebrání zboží z košíku
    Odhlášení
    Log To Console             Úspěšný pozitivní test

Negativní test: Přihlášení se špatným emailem
    Přihlášení                 smm.jjiri@seznam.cz     Testovani864ZdR     Účet
    Další ověření nepřihlášení   #mimo Účet v ${headerusericon}
    Log To Console             Úspěšný negativní test

Negativní test: Přihlášení se špatným heslem
    Přihlášení                 sm.jiri@seznam.cz     TezstovQani864Zd4R     Účet
    Další ověření nepřihlášení   #mimo Účet v ${headerusericon}
    Log To Console             Úspěšný negativní test


*** Keywords ***

Cookie
    [Arguments]   ${type}
    IF  "${type}" == "AcceptAll"
        Click     id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    ELSE
        Click     id="CybotCookiebotDialogBodyButtonDecline"
    END

Přihlášení
    [Arguments]         ${email}     ${heslo}     ${user-icon}
    New Browser         chromium     headless=false
    New Page            ${URL}
    Get Title           contains     ${title}
    Cookie              AcceptAll
    Click               ${headerusericon}
    Type Text           id=email     ${email}
    Type Text           id=password     ${heslo}
    Click               data-test=btnSignIn
    Get Text            ${headerusericon}     contains     ${user-icon}
    Take Screenshot

Další ověření nepřihlášení
    Get Text           data-test=notification-content     ==     Zadal(a) jste nesprávný e-mail nebo heslo.

Přidání zboží do košíku
    [Arguments]         ${nazev_produktu}     ${id_cislo}     ${mnozstvi}
    Type Text           css=[aria-label="vyhledávaný text"]     ${nazev_produktu}
    Click               css=[data-product-id="${id_cislo}"][data-test="btnAdd"]
    ${Pocet}            Evaluate    ${mnozstvi} - 1
    Click               css=[data-product-id="${id_cislo}"][data-test="btnPlus"]    clickCount= ${Pocet}
    Sleep               2
    Go To               ${URL}
    Click               data-test=cart-header
    Get Text            id=cartReviewMainTitle     contains     Přehled objednávky
    Get Text            css=[data-gtm-button="clear-cart"]     contains     Vysypat košík
    Take Screenshot
    Sleep               1

Odebrání zboží z košíku
    Click               css=[data-gtm-button="clear-cart"]
    Sleep               1
    Get Text            id=cartReviewMainTitle     contains     Košík funguje i jako nákupní seznam
    Take Screenshot
    Go To               ${URL}
    Get Text            data-test=cart-header     contains     0,00
    Sleep               1

Odhlášení
    Click               ${headerusericon}
    Sleep               1
    Click               data-test=user-box-logout-button
    Sleep               1