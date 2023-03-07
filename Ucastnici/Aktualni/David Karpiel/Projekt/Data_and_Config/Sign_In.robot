*** Settings ***
Library     Browser

Resource    Selectors.robot
Resource    InputData.robot

*** Keywords ***

Check user
    ${login_email_text} =  Get Text    ${SEL_USER_LOGIN_BUTTON}
    Log To Console    ${login_email_text}
    IF    "${login_email_text}" == "Přihlásit"
          Go To    ${BASE_URL.${ENVIRONMENT}}
    ELSE
          Click           ${SEL_LOGOUT_ICON}
          Go To    ${BASE_URL.${ENVIRONMENT}}
    END

Click on "Přihlásit"
    Click              ${SEL_USER_LOGIN_BUTTON}

Verify "Přihlásit" page loaded
    ${text_login} =    Get Text    id=loginIframe >>> text=Přihlášení
    Log To Console    ${text_login}
    Should Contain    ${text_login}    Přihlášení

# SUCCESFUL LOGIN

Login
    [Arguments]     ${LOGIN_EMAIL}  ${LOGIN_PASSWORD}
    Fill "email" field              ${LOGIN_EMAIL}
    Fill "password" field           ${LOGIN_PASSWORD}
    Click "Přihlásit se" button

Fill "email" field
    [Arguments]     ${LOGIN_EMAIL}
    Fill Text       ${SEL_EMAIL_TEXT_FIELD}      ${LOGIN_EMAIL}

Fill "password" field
    [Arguments]     ${LOGIN_PASSWORD}
    Fill Text       ${SEL_PASSWORD_TEXT_FIELD}      ${LOGIN_PASSWORD}
Click "Přihlásit se" button
    Click           ${SEL_LOGIN_BUTTON}

Verify login
    Get Text        id=lblUser   contains   ${LOGIN_EMAIL}

Logout
    Click           ${SEL_LOGOUT_ICON}

Verify logout
    Get Text        ${SEL_USER_LOGIN_BUTTON}  contains  Přihlásit

#LOGIN FAILED

Navigate to
    ${SignInUrl} =  Catenate  SEPARATOR=/  ${BASE_URL.${ENVIRONMENT}}  ${LOGIN_URL}
    New Page  ${SignInUrl}


Enter credentials
    [Arguments]    ${Credentials}
    ${Input_email_text} =      Fill Text    id=userName      ${Credentials.Email}
    ${Input_password_text} =   Fill Text    id=password      ${Credentials.Password}

    Run Keyword If    '${Credentials.Email}' == '#BLANK'  ${Input_email_text}
    Run Keyword If    '${Credentials.Password}' == '#BLANK'  ${Input_password_text}

Click on "Přihlásit se"
    Click           id=loginButtonText

Verify Login Page Error Message and close page
    [Arguments]   ${ExpectedErrorMessage}
    ${fields} =  Get Text        id=loginButtonText
    IF  "${fields}" == "${ExpectedErrorMessage}"
        Get Text        id=loginButtonText  ==    ${ExpectedErrorMessage}
    ELSE
        Get Text  xpath=/html/body/div/div/form/div[1]/div[2]/span  ==  ${ExpectedErrorMessage}
    END

    Sleep    1s
    Close Page