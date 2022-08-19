*** Comments ***
4. testcase opravit.

*** Settings ***
Documentation   CV: Testovaci data - zaměňte uživatelské data za proměné ze souboru Cviceni/Data_and_Config/TestData.robot
Library         Browser
Resource        /home/miki/PycharmProjects/jak_automatizovat_testy/Ucastnici/OLD/Miroslav_Duris/Data&Config/Variables_CV12.robot

*** Variables ***
# Použity pouze proměnné z připojeného souboru - viz *** Settings ***

*** Test Cases ***

Login #1
    [Documentation]    Nespravny email
    [Tags]               funkční
    Login           ${Email-1}                       ${Heslo-1}                    ${Text-1}

Login #2
    [Documentation]    Nespravne heslo
    [Tags]               funkční
    Login           ${Email-2}                       ${Heslo-2}                    ${Text-2}

Login #3
    [Documentation]    Spravny email i spravne heslo
    [Tags]               funkční
    Login           ${Email-2}                       ${Heslo-1}                    ${Text-3}
    Logout

Test Objednavky
    [Documentation]    Test cele objednavky zbozi
    [Tags]               nefunkční
    ${kusu} =	        Set Variable	            5
    Login               ${Email-1}                   ${Heslo-1}                ${Text-3}
    Pridat do kosiku    mléko                       1320669                   ${kusu}
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
#    Open Browser                ${URL1}                              headless=true     #dá se použít pro nastavení dalších parametru - umožňuje např vypnout headless mode
    # Klíč. slovo 'Open Browser' má nový význam a pro potřeby tohoto testu už se nehodí. Použil jsem místo něj 'New Browser' - viz níže.
    New Browser                  browser=firefox                 headless=False     #Změnil jsem si používaný browser na Firefox (defaultně je Chromium) a vypnul headless mode
    New Page                    ${URL-1}
    Get Title                   contains                            Online supermarket Rohlik.cz
    Cookie                      AcceptAll
    Click                       id=headerLogin
    Type Text                   id=email     ${Email}
    Type Text                   id=password  ${Heslo}
#    Debug
    Click                       data-test=btnSignIn
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
    Click               css=.sc-oad7xy-0 [data-product-id="${produkt_id}"][data-test="btnPlus"]           clickCount=${Pocet}
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
    Go to               ${URL1}
    Take Screenshot

Cookie
    [Arguments]         ${type}
    IF  "${type}" == "AcceptAll"
        Click           id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    ELSE
        Click           id=CybotCookiebotDialogBodyButtonDecline
    END

    sleep               1      # Workaround: Probliknutí cele stránky po kliknutí na tlačítko
