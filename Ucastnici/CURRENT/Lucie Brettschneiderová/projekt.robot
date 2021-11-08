*** Settings ***
Library  Browser    auto_closing_level=SUITE

*** Variables ***
${url}		        https://www.rohlik.cz/
${textLogin}        Přihlášení
${loginMail}        rohlikaccount@mail.com
${loginPass}        TestovaciHeslo
${userInitials}     KP
${userNotLoggedIn}  Přihlásit

*** Test Cases ***
Prihlaseni
    Set Browser Timeout         10
    Load page
    Login                       ${loginMail}                            ${loginPass}
    get text                    data-test=header-user-icon              contains              ${userInitials}

Odhlaseni
    Set Browser Timeout         10
    Logout
    get text                    data-test=header-user-icon              contains              ${userNotLoggedIn}

*** Keywords ***
Load page
    New Browser                 chromium                                headless=false
    New Page                    ${url}

Login
    [Arguments]                 ${username}                             ${password}
    click                       data-test=header-user-icon
    type text                   data-test=user-login-form-email         ${username}
    type text                   data-test=user-login-form-password      ${password}
    click                       data-test=btnSignIn

Logout
    click                       data-test=header-user-icon
    click                       data-test=user-box-logout-button
