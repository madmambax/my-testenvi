# požadavky:
#   pip install robotframework-browser
#   rfbrowser init


*** Settings ***
Documentation   CV: Testovaci data - zaměňte uživatelské data za proměné ze souboru Cviceni/Data_and_Config/TestData.robot
Library         Browser


*** Variables ***
${URL}              https://rohlik.cz


*** Test Cases ***
Login spatny email
    Login           chyba                       tajneheslotajneheslo                    Zadejte platný email

Login spatne heslo
    Login           radek.tester@seznam.cz      bad                                     Zadal(a) jste nesprávný e-mail nebo heslo.

Login vse OK
    Login           radek.tester@seznam.cz      tajneheslotajneheslo                    JT
    Logout

Test Objednavky
    ${kusu} =	        Set Variable	            5
    Login               radek.tester@seznam.cz      tajneheslotajneheslo                JT
    Pridat do kosiku    mléko                       1320669                             ${kusu}
    Click               id=cartContent
    Take Screenshot
    Odebrat z kosiku      ${kusu}
    Take Screenshot
    Logout
    Take Screenshot




*** Keywords ***

Login
    [Arguments]                 ${Email}                            ${Heslo}                                ${Text}

    Set Browser Timeout         20                                  #20s je vhodné pro rohlik.cz
    Open Browser                ${URL}                              headless=false     #dá se použít pro nastavení dalších parametru - umožňuje např vypnout headless mode
    Sleep                       5
    New Page                    ${URL}
    Sleep                       5
    Get Title                   contains                            Online supermarket Rohlik.cz
    Cookie                      AcceptAll
    Sleep                       5
    Click                       id=headerLogin
    Type Text                   id=email                            ${Email}
    Type Text                   id=password                         ${Heslo}
    Sleep                       5
#    Debug
    Click                       data-test=btnSignIn
    Sleep                       5
    Get Text                    xpath=//div[@class='u-mr--8']       contains                                ${Text}


Logout
    Click               xpath=//div[@class='u-mr--8']
    Click               data-test=user-box-logout-button


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
#    Click               css=.sc-oad7xy-0 [data-product-id="${produkt_id}"][data-test="btnPlus"]           clickCount=${Pocet}
    Click               css=.amountCounterWrap [data-product-id="${produkt_id}"][data-test="btnPlus"]           clickCount=${Pocet}


    #ověří že je zboží v košíku
    ${cart_text}=       Get Text                    id=cart
    Log                 ${cart_text}
    Get Text            id=cart                     matches                             (?i)${Zbozi}    # (?i)  znamená že se bere case insensitive
    Take Screenshot


Odebrat z kosiku
    [Arguments]                 ${Kusu}

    Take Screenshot
    ${old_mode} =       Set Strict Mode             False                       # zapamatovat původní nastavení
    Click               data-test=btnMinus           clickCount=${Kusu}
    Set Strict Mode     ${old_mode}
    Take Screenshot
    Sleep               3                                                       # statické čekání
    Take Screenshot
    Go to               ${URL}
    Take Screenshot

Cookie
    [Arguments]         ${type}
    IF  "${type}" == "AcceptAll"
        Click           id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    ELSE
        Click           id=CybotCookiebotDialogBodyButtonDecline
    END

    sleep               1      #workaround: Probliknutí cele stránky po kliknutí na tlačítko