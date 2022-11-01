*** Settings ***
Library  Browser

*** Variables ***
${URL}      https://www.rohlik.cz/
${title}    Online supermarket Rohlik.cz — nejrychlejší doručení ve městě


*** Test Cases ***

Přihlášení s dobrým loginem pro temp účet a přidání do košíku
    Login               riyap56604@orlydns.com              b..d[e]1(/TWKgi             HK
    Add To Basket       penne       5
    Sleep               5
    Remove From Basket
    Sleep               4

Přihlášení se špatným heslem
    Login               radek.tester@seznam.cz              dasdas                     Přihlásit
#
Prihlaseni s dobrým loginem pro radekkitner
    Login               radek.tester@seznam.cz              tajneheslotajneheslo        JT


*** Keywords ***

Login
    [Arguments]     ${email}      ${heslo}     ${user}

    #Otevřít prohlížeč a stránku
    New Browser     chromium    headless=false
    New Page        ${URL}

    #Ověření načtení stránky
    Get Title       contains   ${title}

    #Přijmout cookies
    Cookie          AcceptAll

    #Otevření login okna
    Click           id=headerLogin
    Sleep           2

    #Zadání emailu
    Type Text       id=email      ${email}
    Sleep           1

    #Zadání hesla
    Type Text       id=password   ${heslo}

    #Kliknout na přihlásit se
    Click           text="Přihlásit se"
    Sleep           3
    ${header_icon}=   Get Text     data-test=header-user-icon

    #Ověření přihlášení uživatele pomocí iniciálů v ikonce
    Get Text            data-test=header-user-icon          ==      ${user}
    ${icon}=   Get Text  data-test=header-user-icon
    Log         ${icon}
    Take Screenshot

    log             ${email}
    log             ${heslo}
    log             ${user}
    Sleep           2

Cookie
    [Arguments]         ${type}
    IF  "${type}" == "AcceptAll"
        Click           id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    ELSE
        Click           id="CybotCookiebotDialogBodyButtonDecline"
    END
    sleep               2


Logout
     Go to           ${URL}
     Click           xpath=//div[@class='u-mr--8']
     Click           data-test=user-box-logout-button
     Sleep           2
     Take Screenshot

Add to basket
     [Arguments]      ${product}    ${number}
     Type Text           id=searchGlobal             ${product}
     Sleep               1
     Click               text=Hledat
     Sleep               3
     Click               css=[data-test=btnAdd] >> nth=1
     Sleep               1
     ${pocet} =          Evaluate       ${number} - 1
     Click               css=[data-gtm-button="addPiece"] >> nth=1       clickCount=${pocet}

Remove from basket
     Click          [aria-label^="Odstranit z košíku"]

