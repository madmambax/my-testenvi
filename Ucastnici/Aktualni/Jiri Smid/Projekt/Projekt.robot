#DÚ5

*** Settings ***
Library         Browser
Documentation   DÚ5

Resource        Data_and_Config_AT/TestData.robot
Resource        Data_and_Config_AT/Configuration.robot

Suite Setup     Pred_sadou
Test Setup      Pred_testem
Test Teardown   Po_testu
Suite Teardown  Po_sade

Test Timeout    ${TC_TIMEOUT_ROBOT_KW}


*** Variables ***


*** Test Cases ***

Prihlaseni OK
    Login           ${USER_NAME_OK}        ${USER_PASSWORD_OK}        ${USER_CHECK_OK}
    [Teardown]      Logout                 #k odhlášení dojde vždy, i kdyby test spadnul
    Log To Console  ${TEXT_LogToConsole} OK

Prihlaseni NOT OK 1 (spatny email, heslo ok)
    Login           ${USER_NAME_NOTOK}     ${USER_PASSWORD_OK}        ${USER_CHECK_NOTOK}
    Check not login
    Log To Console  ${TEXT_LogToConsole} NOT OK 1 (spatny email, heslo ok)

Prihlaseni NOT OK 2 (email ok, spatne heslo)
    Login           ${USER_NAME_OK}        ${USER_PASSWORD_NOTOK}     ${USER_CHECK_NOTOK}
    Check not login
    Log To Console  ${TEXT_LogToConsole} NOT OK 2 (email ok, spatne heslo)

Prihlaseni NOT OK 3 (spatny format emailu, heslo ok)
    Login           ${USER_NAME_NOTOK2}    ${USER_PASSWORD_OK}        ${USER_CHECK_NOTOK}
    Check not login 2
    Log To Console  ${TEXT_LogToConsole} NOT OK 3 (spatny format emailu, heslo ok)

Prihlaseni NOT OK 4 (email a heslo nevyplneno)
    Login           ${USER_NAME_EMPTY}     ${USER_PASSWORD_EMPTY}     ${USER_CHECK_NOTOK}
    Check not login 3
    Log To Console  ${TEXT_LogToConsole} NOT OK 4 (email a heslo nevyplneno)

*** Keywords ***

Login
    [Arguments]     ${pemail}      ${pheslo}     ${pnastane}

    log             ${pemail}
    log             ${pheslo}
    log             ${pnastane}

    #ověří, že se stránka otevřela
    Get Title      contains       ${TEXT_MainTitle}

    #klikne na "Účet"
    Click          ${SEL_HeaderUserIcon}      #${headerusericon}

    #zadá email ${pemail} do místa pro zadání emailu
    Type Text      ${SEL_LoginEmail}       ${pemail}

    #zadá heslo ${pheslo} do místa pro zadání hesla
    Type Text      ${SEL_LoginPassword}    ${pheslo}

    #klikne na tlačítko "Přihlásit se"
    Click          ${SEL_BtnSignIn}

    #ověří, že jsem přihlášený/nepřihlášený; data-test=header-user-icon musí obsahovat to co je v ${pnastane}
    Get Text       ${SEL_HeaderUserIcon}    ==    ${pnastane}    #Get Text   text="${pnastane}"


Logout
    #klikne na data-test=header-user-icon (JŠ), kde se nachází tlačítko "Odhlásit se" a ověří jej
    Click          ${SEL_HeaderUserIcon}
    Get Text       ${SEL_UserBoxLogoutBtn}    contains     ${TEXT_Logout}

    #klikne na "Odhlásit se"
    Click          ${SEL_UserBoxLogoutBtn}

    #ověří, že došlo k odhlášení (např. tím, že ${headerusericon} obsahuje text Účet)
    Get Text       ${SEL_HeaderUserIcon}      contains     ${TEXT_Ucet}


Check not login
    Get Text       ${SEL_ErrorLogin}          contains     ${ErrorText_LoginNotOK}


Check not login 2
    Get Text       ${SEL_ErrorLogin_BadEmailFormat}        contains     ${ErrorText_BadEmailFormat}


Check not login 3
    Get Text       ${SEL_ErrorEmptyEmail}      contains       ${ErrorText_EmptyEmail}
    Get Text       ${SEL_ErrorEmptyPassword}   contains       ${ErrorText_EmptyPassword}


Pred_sadou
    Set Browser Timeout     ${TIMEOUT_BROWSER}

    #otevře prohlížeč
    New Browser    chromium    headless=false

    #otevře stránku https://www.rohlik.cz/
    New Page       ${URL}

    #klikne na "Povolit všechny" a tím povolí cookies
    Click          ${SEL_Cookie_AllowAll}


Pred_testem
    Go To          ${URL}


Po_testu
    Log            Úklid po testu
    Go To          ${URL}
    Click          ${SEL_LogoMain}


Po_sade
    Log            Úklid po sadě
    #Go To         ${URL}
    Close Browser