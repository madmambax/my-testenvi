*** Comments ***
U 4. testcasu opravit selektor.

*** Settings ***
Documentation   Zkouska importu test. dat/promennych z ext. souboru
Library         Browser
Resource        /home/miki/PycharmProjects/jak_automatizovat_testy/Ucastnici/OLD/Miroslav_Duris/Data&Config/TestDataUpdated.robot
Resource        /home/miki/PycharmProjects/jak_automatizovat_testy/Ucastnici/OLD/Miroslav_Duris/Data&Config/Selektory-CV13.robot
Resource        /home/miki/PycharmProjects/jak_automatizovat_testy/Ucastnici/OLD/Miroslav_Duris/Data&Config/Variables_CV12.robot

*** Variables ***

*** Test Cases ***

Test loginu #1
    [Documentation]    nespravny email
    [Tags]              funkční
    Login           ${Email-1}                       ${Heslo-1}                       ${Text-1}

    # je nutné zavřít prihlašovací form - opravdu? A jak?
    Click           ${Sel-1}

Test loginu #2
    [Documentation]    nespravne heslo
    [Tags]              funkční
    Login           ${Email-2}               ${Heslo-2}                                ${Text-2}

    # je nutné zavřít prihlašovací form - opravdu? A jak?
    Click                       ${Sel-1}

Test loginu #3
    [Documentation]    zadan spravny email i spravne heslo
    [Tags]              funkční
    Login           ${Email-2}               ${Heslo-1}                    ${Text-3}
    Logout

Test objednavky zbozi #4
    [Documentation]    Test cele objednavky zbozi
    [Tags]              nefunkční
    ${kusu} =	        Set Variable	            5
    Login               ${Email-2}                    ${Heslo-1}                    ${Text-3}
    Pridat do kosiku    ${ZBOZI01_NAME}             ${ZBOZI01_ID}                    ${kusu}
    Click               ${Sel-2}
    Take Screenshot
    Take Screenshot
    Odebrat z kosiku    ${kusu}
    Take Screenshot
    Take Screenshot
    Logout
    Take Screenshot
    Take Screenshot

*** Keywords ***

Login
    [Arguments]                 ${Email}                            ${Heslo}                                ${Text}

    Set Browser Timeout         20                                  #20s je vhodné pro rohlik.cz
#    Open Browser                ${URL-1}                              headless=false     #dá se použít pro nastavení dalších parametru - umožňuje např vypnout headless mode
    New Browser                 firefox                             headless=true
    New Page                    ${URL-1}

    Get Title                   contains                            Online supermarket Rohlik.cz
    Cookie                      AcceptAll

    Click                       ${Sel-3}
    Type Text                   ${Sel-4}     ${Email}
    Type Text                   ${Sel-5}     ${Heslo}

    Click                       ${Sel-6}

    Get Text                    ${Sel-7}       contains                                ${Text}

Logout
    Click               ${Sel-7}
    Click               ${Sel-8}

Pridat do kosiku
    [Arguments]         ${Zbozi}                    ${produkt_id}        ${Kusu}
    Type Text           ${Sel-9}                   ${Zbozi}
    Sleep               1                           #Statický timeout
    Click               ${Sel-10}                 # tlačítko Hledat
    Sleep               5                           #Statický timeout

    Click               css=[data-product-id="${SEL_ProductID}"][data-test="btnAdd"]            # způsobuje někdy zmizení uživatele, scrol donwn, důvod někdy klikne na zboží níže
    Sleep               1
    # Kusu - 1
    ${Pocet}            Evaluate                    ${Kusu} - 1
    Click               css=.sc-oad7xy-0 [data-product-id="${SEL_CssForAdding}"][data-test="btnPlus"]           clickCount=${Pocet}

    #ověří že je zboží v košíku
    ${cart_text}=       Get Text                    ${Sel-11}
    Log                 ${cart_text}
    Get Text            ${Sel-11}                     matches                             (?i)${Zbozi}    # (?i)  znamená že se bere case insensitive
    Take Screenshot

Odebrat z kosiku
    [Arguments]                 ${Kusu}

    Take Screenshot
    ${old_mode} =       Set Strict Mode             False        # Does not fail if selector points to one or more elements
    Click               ${Sel-12}          clickCount=${Kusu}
    Set Strict Mode     ${old_mode}
    Take Screenshot
    Sleep               3                                                       #statické čekání
    Take Screenshot
    Go to               ${URL-1}
    Take Screenshot

Cookie
    [Arguments]         ${type}
    IF  "${type}" == "AcceptAll"
        Click           id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    ELSE
        Click           id=CybotCookiebotDialogBodyButtonDecline
    END

    sleep               1      #workaround: Probliknutí cele stránky po kliknutí na tlačítko


