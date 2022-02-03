# požadavky
#   pip install robotframework-browser
#   rfbrowser init


*** Settings ***
Documentation   Automatizace kalkulačky s BrowserLibrary. Správné heslo jsem poslala v emailu.
Library  Browser
Library  DebugLibrary

Resource        Data/TestData.robot
Resource        Data/Cars.robot
Resource        Data/Values.robot
Resource        Configuration/Configuration.robot
Resource        KeyWords/Login.resource

#Test Setup      Pred testem
#Test Teardown   Po testu


*** Variables ***


*** Test Cases ***

test demo
    Ukazka Logovani

Prihlaseni a odhlaseni success
    ${b_timeout}        Set Browser Timeout                 ${TIMEOUT_BROWSER}
    Open Browser        ${URL}                              headless=false     #dá se použít pro nastavení dalších parametru - umožňuje např vypnout headless mode
    New Page            ${URL}
    Login               magda.brezinova@renomia.cz              Mk23pksc        ${USER}      #Správné heslo jsem poslala v emailu.
#    Get Title           Contains                                Universum
    Otevřu kalkulačku   Autopojištění
    Je aktivní krok     Konfigurace
    Zadám kalkulaci vozidla     K2_osobni_provozovatel_volkswagen_passat
#    log to console       \nOriginal JSON:\n${json_string_cars}
#    log to console       \nOriginal JSON:\n${json_cars}
#    Logout              ${USER}
#    Take Screenshot

*** Keywords ***



#Pred testem
#    ${b_timeout}        Set Browser Timeout                 ${TIMEOUT_BROWSER}
#    Open Browser        ${URL}                              headless=false     #dá se použít pro nastavení dalších parametru - umožňuje např vypnout headless mode
#    New Page            ${URL}

#Po testu
#    Take Screenshot

