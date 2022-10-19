# požadavky:
#   pip install robotframework-browser
#   rfbrowser init
#   pip install robotframework-debuglibrary

*** Settings ***
Documentation   CV: akce pred testem a po skonceni testu
Library         Browser
Library         DebugLibrary     # knihova pro ladění, pokud chcete ledit test stačí to přislušéno místa dat KS: Debug
Library         RequestsLibrary
Library         String

Resource        Data_and_Config/TestData.robot
Resource        Data_and_Config/Configuration.robot

Suite Setup     Pred_sadou
Suite Teardown  Uklid_sada

Test Setup      Pred_testem
Test Teardown   Uklid_po_testu

#Test Timeout    ${TIMEOUT_ROBOT_KW}      # pro debug knihovnu je vhodné vypnout

*** Variables ***

*** Test Cases ***
Test Objednavky
    ${kusu} =	        Set Variable	         5
    Login               ${USER1_NAME}            ${USER1_PASSWORD}                   ${USER1_SHORT}
    Debug
    Pridat do kosiku    banán                    ${kusu}
    Click               ${SEL_CartContent}
    Odebrat z kose      ${kusu}
    [Teardown]          Logout         #provede se i když test zfailuje

*** Keywords ***
Login
    [Arguments]                ${Email}                            ${Heslo}                                ${Text}

#    Get Element
    Get Title                   contains                            ${TEXT_MainTitle}

    Click                       ${SEL_HeaderLogin}
    Type Text                   ${SEL_LoginFormEmail}               ${Email}
    Type Text                   ${SEL_LoginFormPwd}                 ${Heslo}
    Debug
    Click                       ${SEL_BtnSignIn}

    Get Text                    ${SEL_HeaderLoginErrorTxt}           contains                                ${Text}

Pridat do kosiku
    [Arguments]         ${Zbozi}                    ${Kusu}
    Type Text           ${SEL_SearchGlobal}         ${Zbozi}
    Sleep               1                           # statický timeout
    #1x
    Click               ${SEL_BtnSearchGlobal}      # tlačítko Hledat
#    Sleep               5                           # statický timeout

    Click               ${SEL_BtnAdd}               delay=${TIME_BETWEEN_CLICKS}     # způsobuje někdy zmizení uživatele, scrol donwn, důvod někdy klikne na zboží níže

    # Kusu - 1
    ${Pocet}            Evaluate                    ${Kusu} - 1
    Click               ${SEL_BtnPlus}              clickCount=${Pocet}
    Sleep               1                           #Statický timeout -  čeká na aktualizaci košíku
    ${cart_text}=       Get Text                    ${SEL_Cart}
    Log                 ${cart_text}
    Get Text            ${SEL_Cart}                 matches                             (?i)${Zbozi}    # (?i)  znamená že se bere case insensitive
    Take Screenshot

Logout
#    Hover               xpath=//div[@class='u-mr--8']
    Go to               ${URL}
    Click               ${SEL_HeaderLoginErrorTxt}
    Click               ${SEL_UserBoxLogoutBtn}
#    Log                 ${OUTPUT_DIR}

Odebrat z kose
    [Arguments]                 ${Kusu}

    #přidat ověření že košík obsahuje ${Kusu} kusů
    Take Screenshot


    Click                   ${SEL_BtnMinus}             clickCount=${Kusu}      delay=100ms
    Take Screenshot

    Debug

Pred_testem
    Go to               ${URL}   #jdi na hlavní stránku

Pred_sadou
#    Set Browser Timeout                 ${TIMEOUT_BROWSER}         #20s je vhodné pro rohlik.cz

    Open Browser        ${URL}                                     headless=false     #dá se použít pro nastavení dalších parametru - umožňuje např vypnout headless mode
#    je možné i jen použít     Open Browser     kde je standartně headless mód vypnutý
    New Page                    ${URL}
    Cookie                      AcceptAll
    ${old_mode} =               Set Strict Mode             False

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