# požadavky:
#   pip install robotframework-browser
#   rfbrowser init


*** Settings ***
Documentation   CV: akce pred testem a po skonceni testu
Library         Browser
Library         DebugLibrary     # knihova pro ladění, pokud chcete ledit test stačí to přislušéno místa dat KS: Debug

Resource        Data_and_Config/TestData.robot
Resource        Data_and_Config/Configuration.robot

Suite Setup     Pred_sadou
Suite Teardown  Uklid_sada

Test Setup      Pred_testem
Test Teardown   Uklid_po_testu

Test Timeout    ${TC_TIMEOUT_ROBOT_KW}      # Timeout pro všechny KS z RobotFW

*** Variables ***




*** Test Cases ***
Login spatny email
    Login           chyba                       ${USER1_PASSWORD}                       ${ERROR_TEXT_FillCorrectEmail}

Login spatne heslo
    Login           ${USER1_NAME}               bad                                     ${ERROR_TEXT_IncorrectEmailOrPwd}

Login vse OK
    Login           ${USER1_NAME}               ${USER1_PASSWORD}                    ${USER1_SHORT}
    [Teardown]      Logout         #provede se i když test zfailuje


Test Objednavky
    ${kusu} =	        Set Variable	         5
    Login               ${USER1_NAME}            ${USER1_PASSWORD}                   ${USER1_SHORT}
    Pridat do kosiku    ${ZBOZI01_NAME}          ${ZBOZI01_ID}                       ${kusu}
    Click               ${SEL_CartContent}
    Take Screenshot
    Odebrat z kosiku    ${kusu}
    Take Screenshot
    [Teardown]          Logout         #provede se i když test zfailuje
    Take Screenshot




*** Keywords ***

Login
    [Arguments]                ${Email}                            ${Heslo}                                ${Text}

    Get Title                   contains                            ${TEXT_MainTitle}

    Click                       ${SEL_HeaderLogin}
    Type Text                   ${SEL_LoginFormEmail}               ${Email}
    Type Text                   ${SEL_LoginFormPwd}                 ${Heslo}
    Click                       ${SEL_BtnSignIn}
    Get Text                    ${SEL_HeaderLoginErrorTxt}           contains                                ${Text}

Logout
    Go to               ${URL}
    Click               ${SEL_HeaderLoginErrorTxt}
    Click               ${SEL_UserBoxLogoutBtn}
    # ověřit, že došlo k odhlášení
    Get Text            ${SEL_HeaderLoginErrorTxt}          contains                                ${TEXT_Prihlasit}

Pridat do kosiku
    [Arguments]         ${Zbozi}                    ${produkt_id}        ${Kusu}
#    debug
    Type Text           ${SEL_SearchGlobal}         ${Zbozi}
    Sleep               1                           # statický timeout
    Click               ${SEL_BtnSearchGlobal}      # tlačítko Hledat
    Sleep               5                           # statický timeout

    Click               css=[${SEL_ProductID}="${produkt_id}"][${SEL_BtnAdd}]
    Sleep               1
    # Kusu - 1
    ${Pocet}            Evaluate                    ${Kusu} - 1
    Click               css=${SEL_CssForAdding} [${SEL_ProductID}="${produkt_id}"][${SEL_BtnPlus}]           clickCount=${Pocet}

    #ověří že je zboží v košíku
    ${cart_text}=       Get Text                    ${SEL_Cart}
    Log                 ${cart_text}
    Get Text            ${SEL_Cart}                 matches                             (?i)${Zbozi}    # (?i)  znamená že se bere case insensitive
    Take Screenshot


Odebrat z kosiku
    [Arguments]                 ${Kusu}

    #přidat ověření že košík obsahuje ${Kusu} kusů
    Take Screenshot


    ${old_mode} =       Set Strict Mode             False                       # zapamatovat původní nastavení

    Click                   ${SEL_BtnMinus}             clickCount=${Kusu}      delay=100ms
    Take Screenshot

    # nějakou dobu trvá než se zboží přidá do košíku, možnosti

    #Statický timeout
#    Sleep                   3 s
#    Take Screenshot

    # Dynamický timeout - čeka dokud není košík prázdný
    # je třeba vědět co je synchronyzační bod. Na co čeakt. Co se stane když se z košíku odebere X položek?
    # v případě košíku to je aktuální počet zboží v košíku

    ${CartContentText}=     Get Text                ${SEL_CartContent}
    Log                     ${CartContentText}

    FOR    ${i}    IN RANGE    100
           sleep                   ${TIME_BETWEEN_CHECKS}
           ${CartContentText}=     Get Text         ${SEL_CartContent}
           Exit For Loop If         '${ERROR_TEXT_EmptyCart}' in '''${CartContentText}'''

           Log                     ${CartContentText}
           Log                     ${i}
    END

    Set Strict Mode     ${old_mode}


Pred_testem
    Go to               ${URL}   #jdi na hlavní stránku


Pred_sadou
    ${b_timeput} =             Set Browser Timeout                 ${TIMEOUT_BROWSER}                 #20s je vhodné pro rohlik.cz
    Log                        Původní hodnota timeout ${b_timeput}
    Open Browser               ${URL}                              headless=false     #dá se použít pro nastavení dalších parametru - umožňuje např vypnout headless mode
#    je možné i jen použít     Open Browser     kde je standartně headless mód vypnutý
    New Page                   ${URL}

    Cookie                      AcceptAll


Uklid_po_testu
    Log         Uklid na konci každho testu.
    # je nutné zavřít prihlašovací form a jít na úvodní stránku
    Click       ${SEL_HeaderLogo}
    Go to       ${URL}


Uklid_sada
    New Page                ${URL}    # pro stabilitu vše dělá v novém tabu
    Login                   ${USER1_NAME}           ${USER1_PASSWORD}           ${USER1_SHORT}
    Go to                   ${URL_cart}

    #je košik prázdný?
    ${cart_overview_text}   Get Text                ${SEL_CartReview}
    Log                     ${cart_overview_text}

    #pokud ne vysypat nákupní koš
    Run Keyword If          '${TEXT_EmptyCart}' in '''${cart_overview_text}'''       Click               text="${TEXT_EmptyCart}"
    Take Screenshot

    #Logout
    Go to                   ${URL}
    Logout
    Close Browser


Cookie
    [Arguments]         ${type}
    IF  "${type}" == "AcceptAll"
        Click           ${SEL_Cookie_AllowAll}
    ELSE
        Click           ${SEL_Cookie_Decline}
    END

    sleep               1      #workaround: Probliknutí cele stránky po kliknutí na tlačítko