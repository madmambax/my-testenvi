# požadavky:
#   pip install robotframework-browser
#   rfbrowser init


*** Settings ***
Documentation   Automatizace rohlik.cz s BrowserLibrary
Library         Browser
Library         DebugLibrary     # knihova pro ladění, pokud chcete ledit test stačí to přislušéno místa dat KS: Debug


*** Variables ***
${URL}          https://rohlik.cz




*** Test Cases ***
Login spatny email
    Login           chyba                       tajneheslotajneheslo                    Zadejte platný email


Login spatne heslo
    Login           radek.tester@seznam.cz      bad                                     Zadal(a) jste nesprávný e-mail nebo heslo.


Login vse OK
    Login           radek.tester@seznam.cz      tajneheslotajneheslo                    JT
    Logout


Test Objednavky
    Login               radek.tester@seznam.cz      tajneheslotajneheslo                JT
    Pridat do kosiku    Losos                       5
    Click               id=cartContent
    Take Screenshot
    Take Screenshot
    Vysypat kos         5
    Take Screenshot
    Take Screenshot
    Logout
    Take Screenshot
    Take Screenshot




*** Keywords ***

Login
    [Arguments]                 ${Email}                        ${Heslo}                                ${Text}
    Open Browser                ${URL}                          headless=false     #dá se použít pro nastavení dalších parametru - umožňuje např vypnout headless mode
#    je možné i jen použít     Open Browser     kde je standartně headless mód vypnutý
    New Page                    ${URL}
#    Get Element
    Get Title                  contains                         Online supermarket Rohlik.cz

    Click                       id=headerLogin
    Type Text                   id=email                        ${Email}
    Type Text                   id=password                     ${Heslo}
#    Debug
    Click                       xpath=//x-translation[contains(text(),'Přihlásit se')]

    Get Text                    xpath=//div[@class='u-mr--8']   contains                                ${Text}



Pridat do kosiku
    [Arguments]                 ${Zbozi}    ${Kusu}
    Type Text           id=searchGlobal             ${Zbozi}
    Click               text=Hledat
    Click               text=Do košíku
    Click               data-test=btnPlus
    Click               data-test=btnPlus
    Click               data-test=btnPlus
    Click               data-test=btnPlus
    Get Text            id=cart                     contains                            ${Zbozi}
    Take Screenshot


Logout
    Click               xpath=//div[@class='u-mr--8']
    Click               text=Odhlásit se
#    Log                 ${OUTPUT_DIR}


Vysypat kos
    [Arguments]                 ${Kusu}
#    Repeat Keyword      42 times          Click               data-test=btnMinus
#    Repeat Keyword      42                          Click                               data-test=btnMinus
    Click               data-test=btnMinus           clickCount=${Kusu}
#    Repeat Keyword      ${Kusu}                     Odstran                    #debug, loguje cenu
    Sleep               3
#    Keyboard Key        press                        PageUp



Odstran
    Click               data-test=btnMinus
    ${log}=             Get Text                    data-test=headerPrice
    Log                 ${log}
#    Get Text            data-test=headerPrice       contains                        0
#    Sleep               1
#    Take Screenshot




