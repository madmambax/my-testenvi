# požadavky:
#   pip install robotframework-browser
#   rfbrowser init


*** Settings ***
Documentation   Automatizace rohlik.cz s BrowserLibrary
Library         Browser
Library         DebugLibrary     # knihova pro ladění, pokud chcete ledit test stačí to přislušéno místa dat KS: Debug

Test Timeout    25

*** Variables ***
${URL}          https://rohlik.cz




*** Test Cases ***
#Login spatny email
#    Login           chyba                       tajneheslotajneheslo                    Zadejte platný email
#
#
#Login spatne heslo
#    Login           radek.tester@seznam.cz      bad                                     Zadal(a) jste nesprávný e-mail nebo heslo.


Login vse OK
    Login           radek.tester@seznam.cz      tajneheslotajneheslo                    JT
    Logout


Test Objednavky
    ${kusu} =	        Set Variable	            5
    Login               radek.tester@seznam.cz      tajneheslotajneheslo                JT
    Pridat do kosiku    Losos                       ${kusu}
    Click               id=cartContent
    Take Screenshot
    Take Screenshot
    Vysypat kos         ${kusu}
    Take Screenshot
    Take Screenshot
    Logout
    Take Screenshot
    Take Screenshot




*** Keywords ***

Login
    [Arguments]                 ${Email}                            ${Heslo}                                ${Text}
    Open Browser                ${URL}                              headless=false     #dá se použít pro nastavení dalších parametru - umožňuje např vypnout headless mode
#    je možné i jen použít     Open Browser     kde je standartně headless mód vypnutý
    New Page                    ${URL}
#    Get Element
    Get Title                  contains                             Online supermarket Rohlik.cz
    Click               id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    sleep                1
    Click                       id=headerLogin
    Type Text                   data-test=user-login-form-email     ${Email}
    Type Text                   data-test=user-login-form-password  ${Heslo}
#    Debug
    Click                       data-test=btnSignIn

    Get Text                    xpath=//div[@class='u-mr--8']          contains                                ${Text}



Pridat do kosiku
    [Arguments]         ${Zbozi}                    ${Kusu}
    Set Strict Mode     False

    Type Text           id=searchGlobal             ${Zbozi}
    #1x
    Click               text=Hledat
#    Click               data-test=product-1
    Click               text=Do košíku
    # Kusu - 1
    ${Pocet}            Evaluate                    ${Kusu} - 1
    Click               data-test=btnMinus          clickCount=${Pocet}

    Get Text            id=cart                     matches                             (?i)${Zbozi}    # (?i)  znamená že se bere case insensitive
    Take Screenshot


Logout
    Click               xpath=//div[@class='u-mr--8']
    Click               text=Odhlásit se
#    Log                 ${OUTPUT_DIR}


Vysypat kos
    [Arguments]                 ${Kusu}

#    Repeat Keyword      42 times                     Click                             data-test=btnMinus
#    Repeat Keyword      ${Kusu}                      Click                             data-test=btnMinus
    Click               data-test=btnMinus           clickCount=${Kusu}
#    Repeat Keyword      ${Kusu}                     Odstran                    #debug, loguje cenu
    Sleep               3                                                       #timeout
#    Keyboard Key        press                        PageUp



Odstran
    Click               data-test=btnMinus
    ${log}=             Get Text                    data-test=headerPrice
    Log                 ${log}
#    Get Text            data-test=headerPrice       contains                        0
#    Sleep               1
#    Take Screenshot




