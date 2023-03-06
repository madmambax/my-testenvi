
*** Settings ***
Library  Browser

Resource        TestData_Saucedemo/TestData.robot
Resource        TestData_Saucedemo/Configuration.robot

Suite Setup     Před_sadou
Test Setup      Před_testem
Test Teardown   Po_testu

Test Timeout    ${TC_TIMEOUT_ROBOT_KW}

*** Variables ***


*** Test Cases ***
Login s kontrolou v parametru - přidání zboží do košíku, odebrání zboží a odhlášení
    Login s kontolou        ${USER_NAME_CORRECT}    ${USER_PASSWORD_CORRECT}            ${TEXT_LOGINCHECK}
    Přidání do košíku       ${ITEM_NAME}            ${ITEM_NUMBER}
    Odebrání z košíku
    Reset aplikace
    Odhlášení

Login - kontola zvlášť - přidání zboží do košíku, odebrání zboží a odhlášení
    Login                   ${USER_NAME_CORRECT}     ${USER_PASSWORD_CORRECT}
    Uživatel je přihlášen
    Přidání do košíku       ${ITEM_NAME}             ${ITEM_NUMBER}
    Odebrání z košíku
    Reset aplikace
    Odhlášení

Login - špatné uživatelské jméno
    Login                   ${USER_NOTCORRECT}        ${USER_PASSWORD_CORRECT}
    Uživatel není přihlášen

Login - špatné heslo
    Login                   ${USER_NAME_CORRECT}      ${USER_PASSWORD_NOTCORRECT}
    Uživatel není přihlášen


*** Keywords ***
Login s kontolou

    [Arguments]     ${user}      ${password}     ${outcome}

    log             ${user}
    log             ${password}
    log             ${outcome}


    Click           ${SEL_USER_FIELD}
    Type Text       ${SEL_USERNAME}                  ${user}
    Click           ${SEL_PASSW_FIELD}
    Type Text       ${SEL_USERPASSW}                 ${password}
    Click           ${SEL_LOGIN_BTN}
    Get Text        ${SEL_LOGINCHECK}      ==        ${outcome}

Login
    [Arguments]     ${user}      ${password}

    log             ${user}
    log             ${password}


    Click           ${SEL_USER_FIELD}
    Type Text       ${SEL_USERNAME}               ${user}
    Click           ${SEL_PASSW_FIELD}
    Type Text       ${SEL_USERPASSW}              ${password}
    Click           ${SEL_LOGIN_BTN}

Uživatel je přihlášen
    Get Text        ${SEL_LOGINCHECK}        contains        ${TEXT_LOGINCHECK}

Uživatel není přihlášen
     Get Text       ${SEL_LOGIN_BTN}         contains        ${TEXT_LOGIN}

Přidání do košíku

     [Arguments]     ${item}          ${itemnumber}
     Click           ${ITEM_CHOSEN}
     Click           ${ITEM_ADDTOCART}
     Click           ${CART}


Odebrání z košíku
    Get Text        ${ITEM_REMOVE}             ==        ${TEXT_REMOVE_CART}
    Click           ${ITEM_REMOVE}


Reset aplikace
    Click           ${SEL_MENU_BTN}
    Get Text        ${SEL_RESET_BTN}           ==        ${TEXT_APP_RESET}
    Click           ${SEL_RESET_BTN}


Odhlášení
    Get Text        ${SEL_LOGOUT_BTN}          ==        ${TEXT_LOGOUT}
    Click           ${SEL_LOGOUT_BTN}
    Get Text        ${SEL_LOGIN_BTN}           ==        ${TEXT_LOGIN}

Před_sadou
    Set Browser Timeout         ${TIMEOUT_BROWSER}
    Log                         Browser timeout is ${TIMEOUT_BROWSER}


Před_testem
    New Browser     chromium                headless=false
    New Page        ${URL}
    Get Title       contains                Swag Labs

Po_testu
    Close Browser