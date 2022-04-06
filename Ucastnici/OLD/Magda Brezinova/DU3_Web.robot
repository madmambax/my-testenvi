# požadavky
#   pip install robotframework-browser
#   rfbrowser init


*** Settings ***
Documentation   Automatizace kalkulačky s BrowserLibrary. Správné heslo jsem poslala v emailu.
Library  Browser


*** Variables ***
${URL}      https://stage.inovis.renomia.cz/oauth/login
${user}     Magda Brezinova

*** Test Cases ***

Prihlaseni success
    Login               magda.brezinova@renomia.cz              Spatneheslo        ${user}     #Správné heslo jsem poslala v emailu.


Prihlaseni a odhlaseni success
    Login               magda.brezinova@renomia.cz              Spatneheslo        ${user}     #Správné heslo jsem poslala v emailu.
    Logout              ${user}


Prihlaseni negativni
    Login negativni              magda@renomia.cz              Spatneheslo        Přihlášení neproběhlo        #Správné heslo jsem poslala v emailu.


Prihlaseni negativni
    Login negativni              magda.brezinova@renomia.cz              Badpassword        Přihlášení neproběhlo


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
    Get Text            //span[text()="${validation}"]
    ${log}=             Get Text                            //span[text()="${validation}"]
    Log                 Url: ${URL} ${\n} user: ${log} ${\n} login: ${email} ${\n} password: ${heslo}
    Take Screenshot

Login negativni
    [Arguments]         ${email}                            ${heslo}                    ${validation}
    Open Browser        ${URL}                              headless=false     #dá se použít pro nastavení dalších parametru - umožňuje např vypnout headless mode
    New Page            ${URL}
    Get Title           contains                            Vítejte
    Click               id=other-variant
    Type Text           id=username         ${email}
    Type Text           id=password         ${heslo}
    Click               id=logginButton
    Get Text            id=modal            contains        ${validation}
    Log                 Url: ${URL} ${\n} user: ${email} ${\n} password: ${heslo}
    Take Screenshot


Logout
    [Arguments]         ${validation}
    Click               //span[text()="${validation}"]
    Click               //div[text()="Odhlásit se"]
    Get Title           contains                            Vítejte