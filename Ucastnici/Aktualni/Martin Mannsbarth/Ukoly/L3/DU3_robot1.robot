*** Settings ***
Library  Browser

*** Variables ***
${URL}                  https://www.rohlik.cz/
${LoginFormEmail}       id=email
${LoginFormPwd}         id=password
${UserHeader}           data-test=header-user-icon
${BtnSignIn}            data-test=btnSignIn
${logout}               data-test=user-box-logout-button
${logout_verify}        Účet
${Cookies}              id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll

*** Test Cases ***

Logon and logout rohlik
    Login               mann.m@seznam.cz                    Plostice2023!               MM


*** Keywords ***

# log and login
Login
    [Arguments]     ${pemail}      ${passwd}     ${pmessage}

    log             ${pemail}
    log             ${passwd}
    log             ${pmessage}

    #open browser
    New Browser    chromium    headless=false
    #open page  rohlik.cz
    New Page       ${URL}
    #verify page
    Get Title      contains    Rohlik
    #alĺow cookies
    Click          ${Cookies}
    Sleep          5
    #logon form
    Click          ${UserHeader}
    #insert user name / e-mail
    Type Text      ${LoginFormEmail}    ${pemail}

    #insert password
    Type Text        ${LoginFormPwd}    ${passwd}
    #logon button
    Click            ${BtnSignIn}
    # verify logon rohlik.cz
    Get Text         text="${pmessage}"

    # logout from rohlik.cz
    Click           ${UserHeader}
    Click           ${logout}
    Sleep           5

    # verify logout
    Get Text         text="${logout_verify}"