*** Settings ***
Documentation   Domácí úkol z lekce 4
Library  Browser

*** Variables ***
#${b_timeput} =     Set Browser Timeout == 10 seconds
${URL}      https://www.rohlik.cz/

*** Test Cases ***

Pozitivni test: Pridani zbozi do kosiku s prihlasenim
    Login               hemof56369@probdd.com   7Csa6aZfQUbagpJ     JT
    Pridat do kosiku    banán                   1349777             5
    Odebrat z kosiku    banan                   1349777
    Logout              JT

Negativni test: Pridani zbozi do kosiku bez prihlaseni
    Login               hemof56369@probdd.com   spatneheslo         Přihlásit
    Pridat do kosiku    banán                   1349777             5
    Odebrat z kosiku    banan                   1349777
    Logout              Přihlásit

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

Logout
   [Arguments]         ${validation}
   Go to               ${URL}
   IF  "${validation}" == "JT"
        Click           data-test=header-user-icon
        Sleep                   2
        Click           data-test=user-box-logout-button
        Sleep                   2
        Get Text        data-test=header-user-icon    ==    Přihlásit
    ELSE
        Get Text        data-test=header-user-icon    ==    ${validation}
    END
    Take Screenshot

Cookie
    [Arguments]         ${type}
    IF  "${type}" == "AcceptAll"
        Click           id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
        Sleep                   2
    ELSE
        Click           id="CybotCookiebotDialogBodyButtonDecline"
        Sleep                   2
    END
    sleep               1      #workaround: Probliknutí cele stránky po kliknutí na tlačítko

Pridat do kosiku
    [Arguments]             ${Zbozi}            ${produkt_id}       ${Kusu}
    ${old_mode} =           Set Strict Mode     False
    Type Text               id=searchGlobal     ${Zbozi}
    Click                   text="Hledat"
    Sleep                   2
    Click                   css=[data-product-id="${produkt_id}"][data-test="btnAdd"]
    Sleep                   2
    #ověří že je zboží v košíku
    ${cart_text}=           Get Text            id=cart
    Log                     ${cart_text}
    Get Text                id=cart             matches             (?i)${Zbozi}
    Take Screenshot

Odebrat z kosiku
    [Arguments]         ${Zbozi}    ${produkt_id}
    Click           css=[data-product-id="${produkt_id}"][data-test="btnMinus"]
    Sleep                   2
    Take Screenshot