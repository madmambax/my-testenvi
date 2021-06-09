# požadavky:
#   pip install robotframework-browser
#   rfbrowser init


*** Settings ***
Documentation   CV: akce pred testem a po skonceni testu
Library         Browser
Library         DebugLibrary     # knihova pro ladění, pokud chcete ledit test stačí to přislušéno místa dat KS: Debug

Resource        Data_and_Config/TestData.robot
Resource        Data_and_Config/Configuration.robot

*** Variables ***




*** Test Cases ***
Login spatny email
    Login           chyba                       ${USER1_PASSWORD}                       ${ERROR_TEXT_FillCorrectEmail}

    # je nutné zavřít prihlašovací form
    Click           ${SEL_HeaderLogo}


Login spatne heslo
    Login           ${USER1_NAME}               bad                                     ${ERROR_TEXT_IncorrectEmailOrPwd}

    # je nutné zavřít prihlašovací form
    Click           ${SEL_HeaderLogo}



Login vse OK
    Login           ${USER1_NAME}               ${USER1_PASSWORD}                    JT
    Logout


Test Objednavky
    ${kusu} =	        Set Variable	         5
    Login               ${USER1_NAME}            ${USER1_PASSWORD}                   JT
    Pridat do kosiku    Losos                    ${kusu}
    Click               ${SEL_CartContent}
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
    [Arguments]                ${Email}                            ${Heslo}                                ${Text}
    ${b_timeput} =             Set Browser Timeout                 20                 #20s je vhodné pro rohlik.cz

#    Open Browser        ${URL}                                    headless=false     #dá se použít pro nastavení dalších parametru - umožňuje např vypnout headless mode
#    je možné i jen použít     Open Browser     kde je standartně headless mód vypnutý
    New Page            ${URL}

#    Get Element
    Get Title                   contains                            ${TEXT_MainTitle}

    Click                       ${SEL_HeaderLogin}
    Type Text                   ${SEL_LoginFormEmail}               ${Email}
    Type Text                   ${SEL_LoginFormPwd}                 ${Heslo}
#    Debug
    Click                       ${SEL_BtnSignIn}

    Get Text                    ${SEL_HeaderLoginErrorTxt}           contains                                ${Text}



Pridat do kosiku
    [Arguments]         ${Zbozi}                    ${Kusu}
    Type Text           ${SEL_SearchGlobal}         ${Zbozi}
    #1x
    Sleep               1
    Click               ${SEL_BtnSearchGlobal}      # tlačítko Hledat
    Sleep               1                           # čeká 1 sekundu
    Click               ${SEL_BtnAdd}               # způsobuje někdy zmizení uživatele, scrol donwn, důvod někdy klikne na zboží níže
    Sleep               1
    # Kusu - 1
    ${Pocet}            Evaluate                    ${Kusu} - 1
    Click               ${SEL_BtnPlus}              clickCount=${Pocet}
    Get Text            ${SEL_Cart}                 contains                            ${Zbozi}
    Take Screenshot


Logout
#    Hover               xpath=//div[@class='u-mr--8']
    Click               ${SEL_HeaderLoginErrorTxt}
    Click               ${SEL_UserBoxLogoutBtn}
#    Log                 ${OUTPUT_DIR}


Odebrat z kose
    [Arguments]                 ${Kusu}

    Take Screenshot
    #přidat ověření že košík obsahuje ${Kusu} kusů
    Click               ${SEL_BtnMinus}             clickCount=${Kusu}
    #přidat ověření že košík obsahuje 0 kusů
    Take Screenshot
    Sleep               3                                                       #timeout
    Take Screenshot
    Go to               ${URL}
    Take Screenshot



Odstran
    Click               ${SEL_BtnMinus}
    ${log}=             Get Text                    data-test=headerPrice
    Log                 ${log}
#    Get Text            data-test=headerPrice       contains                        0
#    Sleep               1
    Take Screenshot







