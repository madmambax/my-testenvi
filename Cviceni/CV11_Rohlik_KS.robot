# požadavky
#   pip install robotframework-browser
#   rfbrowser init


*** Settings ***
Documentation   Automatizace rohlik.cz s BrowserLibrary
Library  Browser

#RK
Library         DebugLibrary     # knihova pro ladění, pokud chcete ledit test stačí to přislušéno místa dat KS: Debug
#RK

*** Variables ***
${URL}      https://www.rohlik.cz/


*** Test Cases ***

#Prihlaseni bad login
#    Login               dsadsad@sdas.cz                     dasdas                      Přihlásit


#Prihlaseni bad heslo
#    Login               radek.tester@seznam.cz              dasdas                      Přihlásit

Prihlaseni success
    Login               radek.tester@seznam.cz              tajneheslotajneheslo        JT

    Type Text           id=searchGlobal             banán
    Sleep               1                           # čeká 1 sekundu
    Click               text=Hledat                 # ???
    Sleep               1                           # čeká 1 sekundu
    Click               css=[data-test=btnAdd] >> nth=1            # způsobuje někdy zmizení uživatele, scrol donwn, důvod někdy klikne na zboží níže
    Sleep               1

    Sleep               1
    Logout


*** Keywords ***

Login
    [Arguments]         ${email}                            ${heslo}                    ${validation}

    Open Browser        ${URL}                              headless=false     #dá se použít pro nastavení dalších parametru - umožňuje např vypnout headless mode
    New Page            ${URL}

    Get Title           contains                            Rohlik

    Cookie              AcceptAll


    Click               id=headerLogin

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
        Click               id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    ELSE
        Click               id="CybotCookiebotDialogBodyButtonDecline"
    END

    sleep                1      #workaround: Probliknutí cele stránky po kliknutí na tlačítko


# Vytvořte KS pro Odlášení, tak aby fungoval vždy
Logout

#    Hover               xpath=//div[@class='u-mr--8']
    Go to               ${URL}
#    Click               id=headerLogin     vs      Click               xpath=//div[@class='u-mr--8']
    Click               xpath=//div[@class='u-mr--8']
    Click               data-test=user-box-logout-button
##    Log                 ${OUTPUT_DIR}