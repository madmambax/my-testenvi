# požadavky
#   pip install robotframework-browser
#   rfbrowser init


*** Settings ***
Documentation   Automatizace rohlik.cz s BrowserLibrary
Library  Browser

Resource    ../../David Karpiel/DÚ-03/projekt.robot

*** Variables ***
${URL}      https://www.rohlik.cz/


*** Test Cases ***

Uspesne prihlaseni
    Login               lukasbaron@seznam.cz              tajneheslotajneheslo        LB
    Logout


Pridani zbozi do kosiku
    Login               lukasbaron@seznam.cz              tajneheslotajneheslo        LB
    Type Text           id=searchGlobal             banán
    Sleep               1                           # čeká 1 sekundu
    Click               text=Hledat                 # ???
    Sleep               1                           # čeká 1 sekundu
    Click               css=[data-test=btnAdd] >> nth=1            # způsobuje někdy zmizení uživatele, scrol donwn, důvod někdy klikne na zboží níže
#    Click               css=[data-test=btnAdd]            # způsobuje někdy zmizení uživatele, scrol donwn, důvod někdy klikne na zboží níže
    Sleep               1
    Logout


*** Keywords ***

Login
    [Arguments]         ${email}                            ${heslo}                    ${validation}

    New Browser        headless=false     #dá se použít pro nastavení dalších parametru - umožňuje např vypnout headless mode
    New Page            ${URL}

    Get Title           contains                            Rohlik

    Cookie              AcceptAll


    Click               data-test=header-user-icon

    Type Text           id=email                                    ${email}
    Type Text           id=password                                 ${heslo}
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

#    sleep               1      #workaround: Probliknutí cele stránky po kliknutí na tlačítko


# Vytvořte KS pro Odlášení, tak aby fungoval vždy (Pro oba testy)
Logout
    Go To            ${URL}
    Click            id=headerUser
    Click            data-test=user-box-logout-button
    Sleep            5
# zde je nutné doplnit KS
