#DÚ3

*** Settings ***
Library  Browser

Resource        Data_and_Config_AT/TestData.robot
Resource        Data_and_Config_AT/Configuration.robot

Test Setup      Pred_testem
#Test Teardown   Po_testu
#Suite Setup     Pred_sadou
#Suite Teardown  Po_sade


*** Variables ***


*** Test Cases ***

Prihlaseni OK
    Login           ${USER_NAME_OK}        ${USER_PASSWORD_OK}        ${USER_CHECK_OK}
    Logout
Prihlaseni NOT OK 1
    Login           ${USER_NAME_NOTOK}     ${USER_PASSWORD_OK}        ${USER_CHECK_NOTOK}
    Check not login
Prihlaseni NOT OK 2
    Login           ${USER_NAME_OK}        ${USER_PASSWORD_NOTOK}     ${USER_CHECK_NOTOK}
    Check not login
Prihlaseni NOT OK 3
    Login           ${USER_NAME_NOTOK2}    ${USER_PASSWORD_OK}        ${USER_CHECK_NOTOK}
    Check not login 2

*** Keywords ***

Login
    [Arguments]     ${pemail}      ${pheslo}     ${pnastane}

    log             ${pemail}
    log             ${pheslo}
    log             ${pnastane}

    #ověří, že se stránka otevřela
    Get Title      contains    ${TEXT_MainTitle}

    #klikne na "Povolit všechny" a tím povolí cookies
    Click          ${SEL_Cookie_AllowAll}

    #klikne na "Účet"
    Click          ${SEL_HeaderUserIcon}    #${headerusericon}
    Sleep          1

    #zadá email ${pemail} do místa pro zadání emailu
    Type Text      ${SEL_LoginEmail}    ${pemail}

    #zadá heslo ${pheslo} do místa pro zadání hesla
    Type Text      ${SEL_LoginPassword}    ${pheslo}
    Sleep          1

    #klikne na tlačítko "Přihlásit se"
    Click          ${SEL_BtnSignIn}
    Sleep          1

    #ověří, že jsem přihlášený; data-test=header-user-icon musí obsahovat to co je v ${pnastane}
    Get Text       ${SEL_HeaderUserIcon}    ==    ${pnastane}    #Get Text   text="${pnastane}"


Logout
    #klikne na data-test=header-user-icon (JŠ), kde se nachází tlačítko "Odhlásit se" a ověří jej
    Click          ${SEL_HeaderUserIcon}
    Get Text       ${SEL_UserBoxLogoutBtn}    contains     ${TEXT_Logout}
    Sleep          1

    #klikne na "Odhlásit se"
    Click          ${SEL_UserBoxLogoutBtn}

    #ověří, že došlo k odhlášení (např. tím, že ${headerusericon} obsahuje text Účet)
    Get Text       ${SEL_HeaderUserIcon}    contains     ${TEXT_Ucet}


Check not login
    Get Text       ${SEL_ErrorLogin}     contains     ${ErrorText_LoginNotOK}


Check not login 2
    Get Text       ${SEL_ErrorLogin_BadEmailFormat}     contains     ${ErrorText_BadEmailFormat}


Pred_testem
    #otevře prohlížeč
    New Browser    chromium    headless=false

    #otevře stránku https://www.rohlik.cz/
    New Page       ${URL}


#Po_testu
#
#
#Pred_sadou
#
#
#Po_sade

