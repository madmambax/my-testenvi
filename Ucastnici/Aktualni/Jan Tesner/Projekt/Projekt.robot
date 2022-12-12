*** Settings ***
Documentation   Projekt

Library  Browser

Resource        TestData.robot
Resource        Configuration.robot

Suite Setup     Pred_sadou_testu
Suite Teardown  Po_sade_testu

Test Setup      Pred_testem
Test Teardown   Po_testu

*** Test Cases ***

Pozitivni test: Pridani zbozi do kosiku s prihlasenim
    Login               ${USER1_NAME}       ${USER1_PASSWORD}     ${USER1_SHORT}
    Pridat do kosiku    ${ZBOZI01_NAME}     ${ZBOZI01_ID}         5
    Odebrat z kosiku    ${ZBOZI01_NAME}     ${ZBOZI01_ID}
    [Teardown]          Logout              ${USER1_SHORT}

Negativni test: Pridani zbozi do kosiku bez prihlaseni
    Login               ${USER1_NAME}       spatneheslo           ${TEXT_Prihlasit}
    Pridat do kosiku    ${ZBOZI01_NAME}     ${ZBOZI01_ID}         5
    Odebrat z kosiku    ${ZBOZI01_NAME}     ${ZBOZI01_ID}
    [Teardown]          Logout              ${TEXT_Prihlasit}

*** Keywords ***

Login
    [Arguments]         ${email}            ${heslo}              ${validation}

    Click               ${SEL_HeaderLogin}
    Sleep               2
    Type Text           ${SEL_LoginFormEmail}        ${email}
    Type Text           ${SEL_LoginFormPwd}          ${heslo}
    Click               ${SEL_BtnSignIn}
    Sleep               2
    Get Text            ${SEL_HeaderUserIcon}          ==      ${validation}
    ${log}=   Get Text  ${SEL_HeaderUserIcon}
    Log                 ${log}
    Take Screenshot

Logout
   [Arguments]         ${validation}
   Go to               ${URL}
   IF  "${validation}" == "${USER1_SHORT}"
        Click           ${SEL_HeaderUserIcon}
        Click           ${SEL_UserBoxLogoutBtn}
        Get Text        ${SEL_HeaderUserIcon}    ==    ${TEXT_Prihlasit}
    ELSE
        Get Text        ${SEL_HeaderUserIcon}    ==    ${validation}
    END
    Take Screenshot

Cookie
    [Arguments]         ${type}
    IF  "${type}" == "AcceptAll"
        Click           ${SEL_Cookie_AllowAll}
    ELSE
        Click           ${SEL_Cookie_Decline}
    END

Pridat do kosiku
    [Arguments]             ${Zbozi}            ${produkt_id}       ${Kusu}
    ${old_mode} =           Set Strict Mode     False
    Type Text               ${SEL_SearchGlobal}     ${Zbozi}
    Click                   ${SEL_BtnSearchGlobal}
    Click                   css=[${SEL_ProductID}="${produkt_id}"][${SEL_BtnAdd}]
    #ověří že je zboží v košíku
    ${cart_text}=           Get Text            ${SEL_Cart}
    Log                     ${cart_text}
    Get Text                ${SEL_Cart}             matches             (?i)${Zbozi}
    Take Screenshot

Odebrat z kosiku
    [Arguments]             ${Zbozi}            ${produkt_id}
    Click                   css=[${SEL_ProductID}="${produkt_id}"][${SEL_BtnMinus}]
    Take Screenshot

Pred_testem
    New Page            ${URL}
    Get Title           contains            ${TEXT_MainTitle}
    Cookie              AcceptAll

Po_testu
    Go to              ${URL}

Pred_sadou_testu
    ${b_timeput} =     Set Browser Timeout        ${TIMEOUT_BROWSER}
    New Browser        headless=false

Po_sade_testu
    Close Browser