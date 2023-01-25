# požadavky
#   pip install robotframework-browser
#   rfbrowser init


*** Settings ***
Documentation   Automatizace rohlik.cz s BrowserLibrary
Library  Browser
Library    Screenshot
Resource        Data/TestData1.robot
Resource        Data/Configuration1.robot
Resource    ../../../OLD/Katerina Benova/projekt_API/Data_and_Config/var_and_keywords.robot


Suite Setup         Pred_sadou
Suite Teardown      Po_sade
Test Setup          Pred_testem
Test Teardown       Uklid_po_testu

Test Timeout       ${TC_TIMEOUT_ROBOT_KW}

*** Test Cases ***

Pridani zbozi do kosiku

    Login               ${USER1_NAME}             ${USER1_PASSWORD}        ${USER1_SHORT}
    #zvažte kolik parametrů bude třeba
    #Pridat Do Kosiku                        ${ZBOZI01_NAME}
    #Pridat do kosiku varianta pocet         ${ZBOZI01_NAME}               3
    Pridat do kosiku varianta produkt id     ${ZBOZI01_NAME}               ${ZBOZI01_ID}                  3
    [Teardown]     Logout                    ${TEXT_Prihlasit}


*** Keywords ***

Login
    [Arguments]         ${email}                            ${heslo}                    ${USER1_SHORT}

    Click               ${SEL_HeaderLogin}

    Type Text           ${SEL_LoginFormEmail}              ${email}
    Type Text           ${SEL_LoginFormPwd}                ${heslo}
    Click               ${SEL_BtnSignIn}
    Get Text            ${SEL_UserIcon}             ==      ${USER1_SHORT}
    ${log}=   Get Text  ${SEL_UserIcon}
    Log                 ${log}
    Take Screenshot


Cookie
    [Arguments]         ${type}
    IF  "${type}" == "AcceptAll"
        Click           ${SEL_Cookie_AllowAll}
    ELSE
        Click           ${SEL_Cookie_Decline}
    END
    sleep               1      #workaround: Probliknutí cele stránky po kliknutí na tlačítko


Logout
   [Arguments]         ${USER1_SHORT}
   Go to               ${URL}
   Click               ${SEL_UserIcon}
   Click               ${SEL_UserBoxLogoutBtn}
   Get Text            ${SEL_HeaderLogin}  ==  ${USER1_SHORT}
   ${log}=  Get Text   ${SEL_HeaderLogin}
   Log                 ${log}
   Take Screenshot


Pridat do kosiku
    [Arguments]         ${Zbozi}

    ${old_mode} =      Set Strict Mode    False
    #zde DOPLNIT ks pro napsání textu, který je v ${Zbozi} do vyhledávání
    Sleep               2
    Type Text           ${SEL_SearchGlobal}              ${Zbozi}
    #zde DOPLNIT ks pro kliknutí na hledat, selektor bude text "Hledat"
    Hledat
    #zde DOPLNIT ks pro kliknout talčítko "Do košíku"
    Do kosiku
    Go to               ${URL}
    #ověří že je zboží v košíku
    ${cart_text}=       Get Text                    ${SEL_Cart}
    Log                 ${cart_text}
    # zde DOPLNIT porovnání zda text z košíku obsahuje zboží
    # použijte příkaz Get Text a parametr  matches  (?i)${Zbozi}
    # (?i)  znamená že se bere case insensitive
    Get Text            ${SEL_Cart}                      matches          (?i)${Zbozi}

    Take Screenshot


Pridat do kosiku varianta pocet
    [Arguments]         ${Zbozi}                    ${Kusu}
    Type Text           ${SEL_SearchGlobal}          ${Zbozi}
    Hledat
    Click               ${SEL_BtnAdd} >> nth=1   clickCount=${Kusu}




Pridat do kosiku varianta produkt id

    [Arguments]         ${Zbozi}     ${produkt_id}     ${Kusu}

    Type Text           ${SEL_SearchGlobal}            ${Zbozi}
    Hledat
    Click               css=[${SEL_ProductID}="${produkt_id}"][${SEL_BtnAdd}]
    ${old_mode} =      Set Strict Mode    False
    ${ZbylyPocetKusu}           Evaluate                    ${Kusu} - 1
    Click               css=[${SEL_ProductID}="${produkt_id}"][${SEL_BtnPlus} "]   clickCount=${ZbylyPocetKusu}



Odebrat z kosiku
    [Arguments]                 ${Kusu}

    Take Screenshot
    ${old_mode} =       Set Strict Mode             False
    Click               ${SEL_BtnMinus}             clickCount=${Kusu}
    Set Strict Mode     ${old_mode}
    Take Screenshot
    Sleep               3
    Take Screenshot
    Go to               ${URL}
    Take Screenshot


Hledat
    Click               ${SEL_BtnSearchGlobal}

Do kosiku
    Click               ${SEL_BtnAdd}


Pred_sadou
    ${b_timeout} =      Set Browser Timeout                   ${TIMEOUT_BROWSER}
    Log                 Původní hodnota timeout ${b_timeout}
    New Browser         ${BROWSER_CHROME}                   headless=false
    New Page            ${URL}
    Cookie              AcceptAll

Po_sade
    Go To               ${URL}
    Login               ${USER1_NAME}             ${USER1_PASSWORD}        ${USER1_SHORT}
    Go To               ${URL_cart}
    Click               ${SEL_CartReview}
    Logout              ${TEXT_Prihlasit}
    Close Browser


Pred_testem
   New Page       ${URL}


Uklid_po_testu
    Go to                ${URL}