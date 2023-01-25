*** Settings ***
Library  Browser


*** Variables ***
${URL}                           https://www.rohlik.cz/
${LOGIN_MENU_BUTTON}             \#headerLogin
${LOGIN_BUTTON}                  data-test=btnSignIn
${EMAIL_FIELD}                   \#email
${PASSWORD_FIELD}                \#password
${USER_ICON}                     data-test=header-user-icon
${COOKIES_DECLINE_BUTTON}        \#CybotCookiebotDialogBodyButtonDecline
${USER_ICON_UNSUCCESSFUL_LOGIN}  Přihlásit


*** Test Cases ***

Prihlaseni bad login
    Login                     dsadsad@sdas.cz         dasdas
    Login Was Not Successful
Prihlaseni bad heslo
    Login                     radek.tester@seznam.cz  dasdas
    Login Was Not Successful
Prihlaseni success
    Login                     joxose9044@xegge.com    josexose
    Login Was Successful      JX
    Logout
    Logout Was Successful


*** Keywords ***

Logout
    Click  \#headerUser
    Click  data-test=user-box-logout-button

Login
    [Arguments]     ${pemail}      ${pheslo}

    log             ${pemail}
    log             ${pheslo}

    Open Rohlik Homepage
    Decline Cookies
    Open Login Menu
    Fill Credentials    ${pemail}    ${pheslo}
    Execute Login

Login Was Not Successful
    Get Text  ${USER_ICON}  ==  ${USER_ICON_UNSUCCESSFUL_LOGIN}

Login Was Successful
    [Arguments]  ${pnastane}
    Get Text     ${USER_ICON}  ==  ${pnastane}

Logout Was Successful
    Get Text  ${USER_ICON}  ==  ${USER_ICON_UNSUCCESSFUL_LOGIN}

Open Rohlik Homepage
   New Browser    firefox    headless=true
   New Page       ${URL}
   Get Title      ==         Online supermarket Rohlik.cz — nejrychlejší doručení ve městě

Fill Credentials
    [Arguments]  ${email}           ${password}
    Type Text    ${EMAIL_FIELD}     ${email}
    Type Text    ${PASSWORD_FIELD}  ${password}

Open Login Menu
    Click  ${LOGIN_MENU_BUTTON}

Decline Cookies
    Click  ${COOKIES_DECLINE_BUTTON}

Execute Login
    Click  ${LOGIN_BUTTON}
