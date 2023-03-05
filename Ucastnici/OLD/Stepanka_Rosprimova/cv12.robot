# požadavky:
#   pip install robotframework-browser
#   rfbrowser init

*** Settings ***
Documentation   CV: Testovaci data - zaměňte uživatelské data za proměné ze souboru Resources/TestData.robot
Library         Browser
Resource        Resources/TestData.robot
#Resource        ../../../Cviceni/Projekt/TestData.robot

*** Variables ***
${URL}                 https://rohlik.cz
${COUNT_SORTIMENT}     5

*** Test Cases ***
Login spatny email
    Login               chyba                       ${USER1_PASSWORD}                    ${ERROR_TEXT_FillCorrectEmail}

Login spatne heslo
    Login               ${USER1_NAME}               bad                                  ${ERROR_TEXT_IncorrectEmailOrPwd}

Login vse OK
    Login               ${USER1_NAME}               ${USER1_PASSWORD}                    ${USER1_SHORT}
    Logout

Test Objednavky
    ${kusu} =	        Set Variable	            ${COUNT_SORTIMENT}
    Login               ${USER1_NAME}               ${USER1_PASSWORD}                    ${USER1_SHORT}
    Pridat do kosiku    ${ZBOZI01_NAME}             ${ZBOZI01_ID}                        ${kusu}
    Click               ${SEL_CartContent}
    Take Screenshot
    Odebrat z kosiku    ${kusu}
    Take Screenshot
    Logout
    Take Screenshot

*** Keywords ***
Login
    [Arguments]                 ${Email}                            ${Heslo}                                ${Text}
    Set Browser Timeout         20                                  #20s je vhodné pro rohlik.cz
    Open Browser                ${URL}                              headless=false     #dá se použít pro nastavení dalších parametru - umožňuje např vypnout headless mode
    New Page                    ${URL}
    Get Title                   contains                            ${TEXT_MainTitle}
    Cookie                      AcceptAll
    Click                       ${SEL_HeaderLogin}
    Type Text                   ${SEL_LoginFormEmail}               ${Email}
    Type Text                   ${SEL_LoginFormPwd}                 ${Heslo}
#    Debug
    Click                       ${SEL_BtnSignIn}
    Get Text                    ${SEL_HeaderLoginErrorTxt}          contains                                ${Text}
Logout
    Click               ${SEL_HeaderLoginErrorTxt}
    Click               ${SEL_UserBoxLogoutBtn}
Pridat do kosiku
    [Arguments]         ${Zbozi}                    ${produkt_id}        ${Kusu}
    Type Text           ${SEL_SearchGlobal}         ${Zbozi}
    Sleep               1                           #Statický timeout
    Click               ${SEL_BtnSearchGlobal}      #tlačítko Hledat
    Sleep               3                           #Statický timeout
    Click               css=[${SEL_ProductID}="${produkt_id}"][${SEL_BtnAdd}]            # způsobuje někdy zmizení uživatele, scrol donwn, důvod někdy klikne na zboží níže
    Sleep               1
    # Kusu - 1
    ${Pocet}            Evaluate                    ${Kusu} - 1
#    Click               css=.sc-oad7xy-0 [data-product-id="${produkt_id}"][data-test="btnPlus"]           clickCount=${Pocet}
    Click               css=${SEL_CssForAdding} [${SEL_ProductID}="${produkt_id}"][${SEL_BtnPlus}]           clickCount=${Pocet}
    #ověří že je zboží v košíku
    ${cart_text}=       Get Text                    ${SEL_Cart}
    Log                 ${cart_text}
    Get Text            ${SEL_Cart}                  matches                             (?i)${Zbozi}    # (?i)  znamená že se bere case insensitive
    Take Screenshot

Odebrat z kosiku
    [Arguments]                 ${Kusu}
    Take Screenshot
    ${old_mode} =       Set Strict Mode             False                       # zapamatovat původní nastavení
    Click               ${SEL_BtnMinus}             clickCount=${Kusu}
    Set Strict Mode     ${old_mode}
    Take Screenshot
    Sleep               3                                                       # statické čekání
    Take Screenshot
    Go to               ${URL}
    Take Screenshot

Cookie
    [Arguments]         ${type}
    IF  "${type}" == "AcceptAll"
        Click           ${SEL_Cookie_AllowAll}
    ELSE
        Click           ${SEL_Cookie_Decline}
    END

    sleep               1      #workaround: Probliknutí cele stránky po kliknutí na tlačítko
