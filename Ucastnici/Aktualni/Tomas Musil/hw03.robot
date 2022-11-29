*** Settings ***
Library  Browser

*** Variables ***
${EMAIL}        najadi6083@kuvasin.com
${PASSWORD}     hesloveslo
${INITIALS}     NK

*** Test Cases ***

Login-logout Test
    Login
    Check logged in
    Logout
    Check logged out


*** Keywords ***

Login
    New Browser    chromium  headless=false
    New Page       https://www.rohlik.cz/
    Get Title      *=       Rohlik.cz
    Log            Opened website
    Close cookie popup      decline
    Click          id=headerLogin
    Type Text      id=email       ${EMAIL}
    Type Text      id=password    ${PASSWORD}
    Click          data-test=btnSignIn
    Log            Logged in with credentials ${EMAIL}:${PASSWORD}


Logout
    Click          data-test=header-user-icon
    Click          data-test=user-box-logout-button
    Log            Logged out


Close cookie popup
    [Arguments]         ${type}
    IF  "${type}" == "accept"
        Click      id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    ELSE
        Click      id=CybotCookiebotDialogBodyButtonDecline
    END
    Log            Closed cookies popup


Check logged in
    Get Text       data-test=header-user-icon      ==      ${INITIALS}
    Log            Sucessfully logged in


Check logged out
    Get Text       data-test=header-user-icon      ==      Přihlásit
    Log            Sucessfully logged out