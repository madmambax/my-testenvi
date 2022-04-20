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

Prihlaseni bad login V
    Login               dsadsad@sdas.cz                     dasdas                      Přihlásit


#Prihlaseni bad heslo
#    Login               radek.tester@seznam.cz              dasdas                      Přihlásit

#Prihlaseni success
#    Login               radek.tester@seznam.cz              tajneheslotajneheslo        JT


*** Keywords ***

Login
    [Arguments]         ${email}                            ${heslo}                    ${validation}

    Open Browser        ${URL}                              headless=false     #dá se použít pro nastavení dalších parametru - umožňuje např vypnout headless mode
    New Page            ${URL}
    Get Title           contains                            Rohlik
    Click               id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    sleep                1
    Click               id=headerLogin
#    # Na rohlíku je aktuálně problém, že strnka po potvrzení Cookies problikne a tím se stratí kliknutí na login
#    # poroto je nutné ověřit otveření přihlašovacího okna
##    ${nevim} =  Get Text            text=Přihlášení
#    ${je_otevreno_prihlaseni} =  Get Element Count    text=Přihlášení
#    Log                 ${je_otevreno_prihlaseni}
#    IF  ${je_otevreno_prihlaseni} == 0
#        sleep  1
#        Click               id=headerLogin
#    END

    Type Text           data-test=user-login-form-email     ${email}
    Type Text           data-test=user-login-form-password  ${heslo}
    Click               data-test=btnSignIn
    Get Text            data-test=header-user-icon          ==                          ${validation}
    ${log}=             Get Text                            data-test=header-user-icon
    Log                 ${log}
    Take Screenshot
