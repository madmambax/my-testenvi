# požadavky:
#   pip install robotframework-browser
#   rfbrowser init


*** Settings ***
Documentation   CV: Testovaci data
Library         Browser
#Library         DebugLibrary     # knihova pro ladění, pokud chcete ledit test stačí to přislušéno místa dat KS: Debug




*** Variables ***
${URL}              https://rohlik.cz


*** Test Cases ***
#Login spatny email
#    Login           chyba                       tajneheslotajneheslo                    Zadejte platný email
#
#    # je nutné zavřít prihlašovací form
#    Click           id=logo
#
#
#Login spatne heslo
#    Login           radek.tester@seznam.cz      bad                                     Zadal(a) jste nesprávný e-mail nebo heslo.
#
#    # je nutné zavřít prihlašovací form
#    Click                       id=logo
#
#
#
#Login vse OK
#    Login           radek.tester@seznam.cz      tajneheslotajneheslo                    JT
#    Logout
#

Test Objednavky
    ${kusu} =	        Set Variable	            5
    Login               radek.tester@seznam.cz      tajneheslotajneheslo                JT
    Pridat do kosiku    Losos                       1353945                             ${kusu}
    Click               id=cartContent
    Take Screenshot
    Odebrat z kosiku      ${kusu}
    Take Screenshot
    Logout
    Take Screenshot




*** Keywords ***

Login
    [Arguments]                 ${Email}                            ${Heslo}                                ${Text}

    Set Browser Timeout        20                                  #20s je vhodné pro rohlik.cz
    Open Browser               ${URL}                               headless=false     #dá se použít pro nastavení dalších parametru - umožňuje např vypnout headless mode

    New Page            ${URL}

    Get Title                   contains                            Online supermarket Rohlik.cz
    Cookie                      AcceptAll

    Click                       id=headerLogin
    Type Text                   data-test=user-login-form-email     ${Email}
    Type Text                   data-test=user-login-form-password  ${Heslo}
#    Debug
    Click                       data-test=btnSignIn

    Get Text                    xpath=//div[@class='u-mr--8']       contains                                ${Text}


Logout
#    Hover               xpath=//div[@class='u-mr--8']
    Click               xpath=//div[@class='u-mr--8']
    Click               data-test=user-box-logout-button
#    Log                 ${OUTPUT_DIR}


Pridat do kosiku
    [Arguments]         ${Zbozi}                    ${produkt_id}        ${Kusu}
    Type Text           id=searchGlobal             ${Zbozi}
    Sleep               1                           #Statický timeout
    Click               text="Hledat"               # tlačítko Hledat
    Sleep               5                           #Statický timeout

    Click               css=[data-product-id="${produkt_id}"][data-test="btnAdd"]            # způsobuje někdy zmizení uživatele, scrol donwn, důvod někdy klikne na zboží níže
    Sleep               1
    # Kusu - 1
    ${Pocet}            Evaluate                    ${Kusu} - 1
    Click               css=.sc-oad7xy-0 [data-product-id="${produkt_id}"][data-test="btnPlus"]           clickCount=${Pocet}

    #ověří že je zboží v košíku
    ${cart_text}=       Get Text                    id=cart
    Log                 ${cart_text}
    Get Text            id=cart                     matches                             (?i)${Zbozi}    # (?i)  znamená že se bere case insensitive
    Take Screenshot






Odebrat z kosiku
    [Arguments]                 ${Kusu}

    Take Screenshot
    ${old_mode} =       Set Strict Mode             False        # Does not fail if selector points to one or more elements
    Click               data-test=btnMinus           clickCount=${Kusu}
    Set Strict Mode     ${old_mode}
    Take Screenshot
    Sleep               3                                                       #statické čekání
    Take Screenshot
    Go to                https://www.rohlik.cz/
    Take Screenshot

Cookie
    [Arguments]         ${type}
    IF  "${type}" == "AcceptAll"
        Click           id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    ELSE
        Click           id="CybotCookiebotDialogBodyButtonDecline"
    END

    sleep               1      #workaround: Probliknutí cele stránky po kliknutí na tlačítko
