# požadavky:
#   pip install robotframework-browser
#   rfbrowser init


*** Settings ***
Documentation   CV: Testovaci data
Library         Browser
Library         DebugLibrary     # knihova pro ladění, pokud chcete ledit test stačí to přislušéno místa dat KS: Debug
Resource        testovacidata.robot


*** Test Cases ***
Login spatny email
    Login           chyba                       ${USER1_PASSWORD}                   ${Errtext1}

    # je nutné zavřít prihlašovací form
    Click           id=logo


Login spatne heslo
    Login           ${USER1_EMAIL}      bad                                     ${Errtext2}

    # je nutné zavřít prihlašovací form
    Click                       id=logo



Login vse OK
    Login          ${USER1_EMAIL}      ${USER1_PASSWORD}                    JT
    Logout


Test Objednavky
    ${kusu} =	        Set Variable	            5
    Login               radek.tester@seznam.cz      tajneheslotajneheslo                JT
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

    Set Browser Timeout        20                                  #20s je vhodné pro rohlik.cz
#    Open Browser               ${URL}                               headless=false     #dá se použít pro nastavení dalších parametru - umožňuje např vypnout headless mode
#    je možné i jen použít     Open Browser     kde je standartně headless mód vypnutý
    New Page            ${URL}


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
    Sleep               1                           # čeká 1 sekundu
    Click               text=Hledat                 # ???
    Sleep               1                           # čeká 1 sekundu
    Click               data-test=btnAdd            # způsobuje někdy zmizení uživatele, scrol donwn, důvod někdy klikne na zboží níže
    Sleep               1
    # Kusu - 1
    ${Pocet}            Evaluate                    ${Kusu} - 1
    Click               data-test=btnPlus           clickCount=${Pocet}
    Get Text            id=cart                     matches                             (?i)${Zbozi}    # (?i)  znamená že se bere case insensitive
    Take Screenshot


Logout
#    Hover               xpath=//div[@class='u-mr--8']
    Click               xpath=//div[@class='u-mr--8']
    Click               data-test=user-box-logout-button
#    Log                 ${OUTPUT_DIR}


Odebrat z kose
    [Arguments]                 ${Kusu}

    Take Screenshot
    Click               data-test=btnMinus           clickCount=${Kusu}
    Take Screenshot
    Sleep               3                                                       #statické čekání
    Take Screenshot
    Go to                https://www.rohlik.cz/
    Take Screenshot


