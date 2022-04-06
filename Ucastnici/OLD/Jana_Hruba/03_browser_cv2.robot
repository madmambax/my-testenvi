# požadavky
#   pip install robotframework-browser
#   rfbrowser init


*** Settings ***
Documentation   Automatizace rohlik.cz s BrowserLibrary
Library  Browser


*** Variables ***
${URL}      https://www.rohlik.cz/

*** Test Cases ***

Prihlaseni bad login
    Login               dsadsad@sdas.cz                     dasdas                      Přihlásit


Prihlaseni bad heslo
    Login               radek.tester@seznam.cz              dasdas                      Přihlásit

Prihlaseni success
    Login               radek.tester@seznam.cz              tajneheslotajneheslo        JT


*** Keywords ***

Login
    [Arguments]         ${email}                            ${heslo}                    ${validation}
    Open Browser        ${URL}                              headless=false     #dá se použít pro nastavení dalších parametru - umožňuje např vypnout headless mode
    New Page            ${URL}
    Get Title           contains                            Rohlik
    Click               id=headerLogin
    Type Text           data-test=user-login-form-email     ${email}
    Type Text           data-test=user-login-form-password  ${heslo}
    Click               data-test=btnSignIn
    Get Text            data-test=header-user-icon          ==                          ${validation}
    ${log}=             Get Text                            data-test=header-user-icon
    Log                 ${log}
    Take Screenshot
