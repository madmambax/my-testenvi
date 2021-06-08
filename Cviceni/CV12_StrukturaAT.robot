# požadavky:
#   pip install robotframework-browser
#   rfbrowser init


*** Settings ***
Documentation   Automatizace rohlik.cz s BrowserLibrary
Library         Browser
Library         DebugLibrary     # knihova pro ladění, pokud chcete ledit test stačí to přislušéno místa dat KS: Debug

Suite Setup     Pred Celou Sadou                     # nachází se v sekci *** Settings ***
Suite Teardown  Ukonceni

#Test Setup      Pred Celou Sadou
#Test Teardown   Ukonceni

*** Variables ***
${URL}          https://rohlik.cz



*** Test Cases ***
Login spatny email
    Login           chyba                       tajneheslotajneheslo                    Zadejte platný email

    # je nutné zavřít prihlašovací form
    # přidat reset
        # kde se nacházím - stránka
        # kliknout na něco co mě hodí do základu
    Click                       id=logo


Login spatne heslo
    Login           radek.tester@seznam.cz      bad                                     Zadal(a) jste nesprávný e-mail nebo heslo.

    # je nutné zavřít prihlašovací form
    Click                       id=logo



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
#    Get Element
    Get Title                   contains                            Online supermarket Rohlik.cz

    Click                       id=headerLogin
    Type Text                   data-test=user-login-form-email     ${Email}
    Type Text                   data-test=user-login-form-password  ${Heslo}
#    Debug
    Click                       data-test=btnSignIn

    Get Text                    xpath=//div[@class='u-mr--8']       contains                                ${Text}



Pridat do kosiku
    [Arguments]         ${Zbozi}                    ${Kusu}
    Type Text           id=searchGlobal             ${Zbozi}
    #1x
    Sleep               1
    Click               text=Hledat                 # ???
    Sleep               1
    Click               data-test=btnAdd            # způsobuje někdy zmizení uživatele, scrol donwn, důvod někdy klikne na zboží níže
    Sleep               1
    # Kusu - 1
    ${Pocet}            Evaluate                    ${Kusu} - 1
    Click               data-test=btnPlus           clickCount=${Pocet}
    Get Text            id=cart                     contains                            ${Zbozi}
    Take Screenshot


Logout
#    Hover               xpath=//div[@class='u-mr--8']
    Click               xpath=//div[@class='u-mr--8']
    Click               data-test=user-box-logout-button
#    Log                 ${OUTPUT_DIR}


Vysypat kos
    [Arguments]                 ${Kusu}

#    Repeat Keyword      42 times                     Click                             data-test=btnMinus
#    Repeat Keyword      ${Kusu}                      Click                             data-test=btnMinus
#    Repeat Keyword      ${Kusu}                     Odstran                    #debug, loguje cenu
    Take Screenshot
    Click               data-test=btnMinus           clickCount=${Kusu}
    Take Screenshot
    Sleep               3                                                       #timeout
    Take Screenshot
    Go to                https://www.rohlik.cz/
    Take Screenshot



Odstran
    Click               data-test=btnMinus
    ${log}=             Get Text                    data-test=headerPrice
    Log                 ${log}
#    Get Text            data-test=headerPrice       contains                        0
#    Sleep               1
    Take Screenshot




Pred Celou Sadou
    Log                 nstartuje prohlizec a novou stranku
#    Open Browser                ${URL}                              headless=false     #dá se použít pro nastavení dalších parametru - umožňuje např vypnout headless mode
#    je možné i jen použít     Open Browser     kde je standartně headless mód vypnutý
    New Page                    ${URL}



Ukonceni
    Log                 ukonci prohlizec
    Close Browser