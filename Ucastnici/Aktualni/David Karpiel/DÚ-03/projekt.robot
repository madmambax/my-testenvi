*** Settings ***
Library    Browser
Library    re
Library    Dialogs
Library    Collections

# robot -d Results -i Test_4 '.\David Karpiel\david\Rohlik_Login.robot'
*** Variables ***
${URL} =               https://www.rohlik.cz/
${BROWSER} =           chromium
${LOGIN_EMAIL} =       pemake5422@mustbeit.com
${LOGIN_PASSWORD} =    Password123
${GET_ERROR_TEXT} =    data-test=notification-content
${ERRO_TEXT} =         Zadal(a) jste nesprávný e-mail nebo heslo.
${SIGN_IN_EMAIL} =     id=email
${SIGN_IN_PASSWORD} =  id=password
${LOGIN_BUTTON} =      data-test=btnSignIn
${USER_ICON} =         DK
${USER_LOGIN_ICON} =   data-test=header-user-icon

@{INVALID_LOGIN} =     Honza@gmail.com    jhjhjhjhgk123
@{INVALID_EMAIL} =     Pepa@seznam.cz     ${LOGIN_PASSWORD}
@{INVALID_PASSWORD} =  ${LOGIN_EMAIL}     JGZJZUGHHJJKG

*** Test Cases ***
The website "Rohlík.cz" should load
    [Tags]  Test_1
    Open Browser
    Open website "Rohlík.cz"
    Verify page loaded
    Click on refuse cookies

User should be able to see login window
    [Tags]  Test_2
    Open Browser
    Open website "Rohlík.cz"
    Verify page loaded
    Click on refuse cookies
    Click on "Účet"
    Verify "Přihlásit" page loaded

User should be able to login and logout (positive test)
    [Tags]  Test_3
    Open Browser
    Open website "Rohlík.cz"
    Verify page loaded
    Click on refuse cookies
    Click on "Účet"
    Verify "Přihlásit" page loaded
    Login with valid credentials    ${LOGIN_EMAIL}  ${LOGIN_PASSWORD}
    Verify login
    Logout and verify logout

User shouls see correct error messages with invalid logins (negative test)
    [Tags]    Test_4
    Open Browser
    Open website "Rohlík.cz"
    Verify page loaded
    Click on refuse cookies
    Click on "Účet"
    Verify "Přihlásit" page loaded
    Login with invalid credentials    ${INVALID_LOGIN}    ${INVALID_EMAIL}    ${INVALID_PASSWORD}

*** Keywords ***
Open browser
    New Browser             ${BROWSER}    headless=False
Open website "Rohlík.cz"
    New Page                ${URL}
Verify page loaded
    Get Title               contains    Rohlik.cz
Click on refuse cookies
    Click                   id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
Click on "Účet"
    Click                   data-test=header-user-icon
Verify "Přihlásit" page loaded
    Sleep    2s
    Get Text                //*[@id="modalOverlay"]/div/div/div[1]/div/div[1]/h3    ==    Přihlášení

#successful login

Login with valid credentials
    [Arguments]  ${LOGIN_EMAIL}  ${LOGIN_PASSWORD}
    Fill "email" field           ${LOGIN_EMAIL}
    Fill "password" field        ${LOGIN_PASSWORD}
    Click "Přihlásit se" button
Fill "email" field
    [Arguments]  ${LOGIN_EMAIL}
    Fill Text    ${SIGN_IN_EMAIL}          ${LOGIN_EMAIL}

Fill "password" field
    [Arguments]  ${LOGIN_PASSWORD}
    Fill Text    ${SIGN_IN_PASSWORD}       ${LOGIN_PASSWORD}

Click "Přihlásit se" button
    Click        ${LOGIN_BUTTON}
Verify login
    Get Text     ${USER_LOGIN_ICON}  ==  ${USER_ICON}
Logout and verify logout
    Click        ${USER_LOGIN_ICON}
    Click        data-test=user-box-logout-button
    Get Text     ${USER_LOGIN_ICON}  !=  ${USER_ICON}

#login failed

Login with invalid credentials
    [Arguments]       ${INVALID_LOGIN}     ${INVALID_EMAIL}    ${INVALID_PASSWORD}
    Invalid login     ${INVALID_LOGIN}
    Invalid email     ${INVALID_EMAIL}
    Invalid password  ${INVALID_PASSWORD}
    Empty email and password field

Invalid login
    [Arguments]     ${INVALID_LOGIN}
    Fill Text       ${SIGN_IN_EMAIL}       ${INVALID_LOGIN}[0]
    Fill Text       ${SIGN_IN_PASSWORD}    ${INVALID_LOGIN}[1]
    Click           ${LOGIN_BUTTON}
    Get Text        ${GET_ERROR_TEXT}  ==  ${ERRO_TEXT}
    Sleep        1s
Invalid email
    [Arguments]     ${INVALID_EMAIL}
    Fill Text       ${SIGN_IN_EMAIL}       ${INVALID_EMAIL}[0]
    Fill Text       ${SIGN_IN_PASSWORD}    ${INVALID_EMAIL}[1]
    Click           ${LOGIN_BUTTON}
    Get Text        ${GET_ERROR_TEXT}  ==  ${ERRO_TEXT}
    Sleep        1s
Invalid password
    [Arguments]     ${INVALID_PASSWORD}
    Fill Text       ${SIGN_IN_EMAIL}       ${INVALID_PASSWORD}[0]
    Fill Text       ${SIGN_IN_PASSWORD}    ${INVALID_PASSWORD}[1]
    Click           ${LOGIN_BUTTON}
    Get Text        ${GET_ERROR_TEXT}  ==  ${ERRO_TEXT}
    Sleep        1s
Empty email and password field
    Fill Text       ${SIGN_IN_EMAIL}       ${EMPTY}
    Fill Text       ${SIGN_IN_PASSWORD}    ${EMPTY}
    Click           ${LOGIN_BUTTON}
    Get Text        ${GET_ERROR_TEXT}  ==  ${ERRO_TEXT}
    Sleep        1s