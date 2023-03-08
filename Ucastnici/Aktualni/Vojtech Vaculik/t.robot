# požadavky:
#   pip install robotframework-browser
#   rfbrowser init


*** Settings ***
Documentation   CV: Testovaci data - pripravit ciselnik chybovych hlasek
Library         Browser


Resource        TestData.robot
Resource        ../../../Cviceni/Data_and_Config/TestData.robot


*** Variables ***
${URL}              https://rohlik.cz



*** Test Cases ***
Login spatny email
    Login           chyba                   ${USER1_PASSWORD}       ${ERROR_TEXT_FillCorrectEmail}

    # je nutné zavřít prihlašovací form
    Click           id=logo


Login spatne heslo
    Login               ${USER1_NAME}       bad                     ${ERROR_TEXT_IncorrectEmailOrPwd}

    # je nutné zavřít prihlašovací form
    Click               id=logo

Login vse OK
    Login               ${USER1_NAME}       ${USER1_PASSWORD}       ${USER1_SHORT}
    Logout

Test Objednavky
    ${kusu} =	        Set Variable	    5
    Login               ${USER1_NAME}       ${USER1_PASSWORD}        ${USER1_SHORT}
    Pridat do kosiku    ${ZBOZI01_NAME}     ${ZBOZI01_ID}            ${kusu}
    Click               id=cartContent
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

    New Browser        headless=false     #dá se použít pro nastavení dalších parametru - umožňuje např vypnout headless mode

    New Page                    ${URL}

    Get Title                   contains                            Online supermarket Rohlik.cz
    Cookie                      AcceptAll

    Click                       ${SEL_HeaderLogin}
    Type Text                   id=email                            ${Email}
    Type Text                   id=password                         ${Heslo}

    Click                       ${SEL_BtnSignIn}

    Get Text                    ${SEL_HeaderLoginErrorTxt}       contains                                ${Text}


Logout
    Click               ${SEL_HeaderLoginErrorTxt}
    Click               ${SEL_UserBoxLogoutBtn}


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
    Click               css=.amountCounterWrap [data-product-id="${produkt_id}"][data-test="btnPlus"]      clickCount=${Pocet}

    #ověří že je zboží v košíku
    ${cart_text}=       Get Text                    id=cart
    Log                 ${cart_text}
    Get Text            id=cart                     matches                             (?i)${Zbozi}    # (?i)  znamená že se bere case insensitive
    Take Screenshot


Odebrat z kosiku
    [Arguments]                 ${Kusu}

    Take Screenshot
    ${old_mode} =       Set Strict Mode             False        # Does not fail if selector points to one or more elements
    Click               data-test=btnMinus          clickCount=${Kusu}
    Set Strict Mode     ${old_mode}
    Take Screenshot
    Sleep               3                                                       #statické čekání
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


