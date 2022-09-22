*** Settings ***
Documentation   Automatizace rohlik.cz s BrowserLibrary
Library         Browser

*** Variables ***
${URL}      https://www.rohlik.cz/

*** Test Cases ***
Uspesne prihlaseni
    Login               radek.tester@seznam.cz              tajneheslotajneheslo        JT
    Logout

#Pridani zbozi do kosiku
#    Login               radek.tester@seznam.cz              tajneheslotajneheslo        JT
#    Type Text           id=searchGlobal             banán
#    Sleep               1                           # čeká 1 sekundu
#    Click               text=Hledat                 # ???
#    Sleep               1                           # čeká 1 sekundu
#    Click               css=[data-test=btnAdd] >> nth=1            # způsobuje někdy zmizení uživatele, scrol donwn, důvod někdy klikne na zboží níže
#    Sleep               1
#    Logout

*** Keywords ***
Login
    [Arguments]         ${email}                            ${heslo}                    ${validation}
    Open Browser        ${URL}                              headless=false     #dá se použít pro nastavení dalších parametru - umožňuje např vypnout headless mode
#    New Page            ${URL}
    Get Title           ==                                  Online supermarket Rohlik.cz — nejrychlejší doručení ve městě
    Cookie              AcceptAll
    Click               id=headerLogin
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

    sleep               1      #workaround: Probliknutí cele stránky po kliknutí na tlačítko

# Vytvořte KS pro Odlášení, tak aby fungoval vždy (Pro oba testy)
Logout
# zde je nutné doplnit KS
    Go To              ${URL}
    Click              xpath=//*[@id="headerUser"]/div
    Sleep              3
    Click              data-test=user-box-logout-button
    Sleep              3
    Get Text           id=headerLogin       ==      Přihlásit
