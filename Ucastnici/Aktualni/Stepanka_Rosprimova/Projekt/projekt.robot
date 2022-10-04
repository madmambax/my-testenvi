*** Settings ***
Library     Browser
Resource    Variables/TestData.robot
Resource    Variables/Configuration.robot
Test Setup              Start Page
Test Teardown           End Page
Suite Setup             Start Browser
Suite Teardown          End Browser

*** Test Cases ***
Prihlaseni chybny login
    Login               bad.login                       ${USER_PASSWORD}                   ${TEXT_LOGIN}

Prihlaseni chybne heslo
    Login               ${USER_LOGIN}                   bad.password                       ${TEXT_LOGIN}

Prihlaseni uspesne a odhlaseni
    Login               ${USER_LOGIN}                   ${USER_PASSWORD}                   ${USER_FULLNAME}
    Logout              ${USER_FULLNAME}

*** Keywords ***
Login
    [Arguments]        ${login}      ${password}     ${headerText}
    [Documentation]    Prihlaseni uzivatele do JIS
    Log                ${login}
    Log                ${password}
    Log                ${headerText}

    Click              ${SEL_HEADER_BUTTON}                          delay=${TIME_BETWEEN_CLICKS}

    Type Text          ${SEL_LOGIN_USERNAME}                         ${login}
    Type Text          ${SEL_LOGIN_PASSWORD}                         ${password}
    Click              ${SEL_LOGIN_BUTTON}                           delay=${TIME_BETWEEN_CLICKS}
    Get Text           ${SEL_HEADER_TEXT}    ==    ${headerText}

Logout
    [Arguments]        ${headerText}
    [Documentation]    Odhlaseni uzivatele z JIS

    Log                ${headerText}

    Get Text           ${SEL_HEADER_TEXT}    ==    ${headerText}
    Click              ${SEL_HEADER_BUTTON}        delay=${TIME_BETWEEN_CLICKS}
    Click              ${SEL_LOGOUT_BUTTON}        delay=${TIME_BETWEEN_CLICKS}
    Get Text           ${SEL_HEADER_TEXT}    ==    ${TEXT_LOGIN}
    Take Screenshot    screenshot

Start Page
    New Page                    ${WEB_URL}
    Get Title                   ==                  ${TEXT_TITLE}

End Page
    Close Page

Start Browser
    Set Browser Timeout         ${TIMEOUT_BROWSER}
    New Browser                 ${BROWSER_NAME}     headless=${BROWSER_HEADLESS}

End Browser
    Close Browser