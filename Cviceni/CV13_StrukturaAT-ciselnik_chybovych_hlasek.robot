# požadavky:
#   pip install robotframework-browser
#   rfbrowser init


*** Settings ***
Documentation   Automatizace rohlik.cz s BrowserLibrary
Library         Browser
Library         DebugLibrary     # knihova pro ladění, pokud chcete ledit test stačí to přislušéno místa dat KS: Debug

Resource        Data_and_Config/TestData.robot


*** Variables ***
${URL}              https://rohlik.cz



*** Test Cases ***
Login spatny email
    Login           chyba                       ${USER1_PASSWORD}                       Zadejte platný email

    # je nutné zavřít prihlašovací form
    Click           id=logo


Login spatne heslo
    Login           ${USER1_NAME}               bad                                     Zadal(a) jste nesprávný e-mail nebo heslo.

    # je nutné zavřít prihlašovací form
    Click                       id=logo



Login vse OK
    Login           ${USER1_NAME}               ${USER1_PASSWORD}                    JT
    Logout


Test Objednavky
    ${kusu} =	        Set Variable	            5
    Login               ${USER1_NAME}               ${USER1_PASSWORD}                    JT
    Pridat do kosiku    Losos                       ${kusu}
    Click               id=cartContent
    Take Screenshot
    Take Screenshot
    Odebrat z kose      ${kusu}
    Take Screenshot
    Take Screenshot
    Logout
    Take Screenshot
    Take Screenshot




*** Keywords ***

Login
    [Arguments]                 ${Email}                            ${Heslo}                                ${Text}
#    Open Browser        ${URL}                                    headless=false     #dá se použít pro nastavení dalších parametru - umožňuje např vypnout headless mode
#    je možné i jen použít     Open Browser     kde je standartně headless mód vypnutý
    New Page            ${URL}
     ${b_timeput} =             Set Browser Timeout                 20                 #20s je vhodné pro rohlik.cz

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
    Sleep               1                           # čeká 1 sekundu
    Click               data-test=btnAdd            # způsobuje někdy zmizení uživatele, scrol donwn, důvod někdy klikne na zboží níže
    Sleep               1
    # Kusu - 1
    ${Pocet}            Evaluate                    ${Kusu} - 1
    Click               data-test=btnPlus           clickCount=${Pocet}
    Get Text            id=cart                     contains                            ${Zbozi}
    Take Screenshot


Logout
    Click               xpath=//div[@class='u-mr--8']
    Click               data-test=user-box-logout-button


Odebrat z kose
    [Arguments]                 ${Kusu}

    Take Screenshot
    #přidat ověření že košík obsahuje ${Kusu} kusů
    Click               data-test=btnMinus           clickCount=${Kusu}
    #přidat ověření že košík obsahuje 0 kusů
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
#    Open Browser        ${URL}                                    headless=false     #dá se použít pro nastavení dalších parametru - umožňuje např vypnout headless mode
#    je možné i jen použít     Open Browser     kde je standartně headless mód vypnutý
    New Page            ${URL}

    #Timeouty
    ${b_timeput} =      Set Browser Timeout                       20                 #20s je vhodné pro rohlik.cz
    Log                 Browser timeout is ${b_timeput}



Ukonceni
#    Log                nastavení do "výchozí polohy"    # pro stabilní funkci testů je nutné např: zavřít prihlašovací
                                                         # form, nebo košík atd. vše se vyřeší kliknutím na logo
    Clic                id=logo

#    Log                 ukonci prohlizec
#    Close Browser