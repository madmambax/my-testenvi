# požadavky
#   pip install robotframework-browser
#   rfbrowser init


*** Settings ***
Documentation   Automatizace rohlik.cz s BrowserLibrary
Library  Browser


*** Variables ***
${URL}      https://stage.inovis.renomia.cz/oauth/login


*** Test Cases ***

Prihlaseni success
    Login               magda.brezinova@renomia.cz              spatneheslo        Magda Brezinova


*** Keywords ***

Login
    [Arguments]         ${email}                            ${heslo}                    ${validation}
    Open Browser        ${URL}                              headless=false     #dá se použít pro nastavení dalších parametru - umožňuje např vypnout headless mode
    New Page            ${URL}
    Get Title           contains                            Vítejte
    Click               id=other-variant
    Type Text           id=username         ${email}
    Type Text           id=password         ${heslo}
    Click               id=logginButton
    Get Text            class=navbar-menu-user          ==                          ${validation}           #nefunguje
    ${log}=             Get Text                            class=navbar-menu-user
    Log                 Url: ${URL} ${\n} user: ${log} ${\n} login: ${email} ${\n} password: ${heslo}
    Take Screenshot
