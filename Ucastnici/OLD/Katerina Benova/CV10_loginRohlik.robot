# požadavky
#   pip install robotframework-browser
#   rfbrowser init


*** Settings ***
Documentation   Automatizace rohlik.cz s BrowserLibrary
Library  Browser


*** Variables ***

${URL}              https://www.rohlik.cz/
${pw_msg}           data-test=user-login-form-password-message
${email_msg}        data-test=user-login-form-email-message
${login_msg}        data-test=notification-content
${user_icon}        data-test=header-user-icon
${wrong_login}      Zadal(a) jste nesprávný e-mail nebo heslo.
${invalid_email}    Zadejte platný email
${empty_email}      Email je povinný
${empty_pw}         Heslo je povinné


*** Test Cases ***

Login valid
    Login   ${user_icon}    JT                  radek.tester@seznam.cz      tajneheslotajneheslo

Login wrong email
    Login   ${login_msg}    ${wrong_login}      ab@ce.df                    kkkkkk

Login wrong password
    Login   ${login_msg}    ${wrong_login}      radek.tester@seznam.cz      kkkkkk

Login invalid email
    Login   ${email_msg}    ${invalid_email}    abcdf                       kkkkkk

Login empty email
    Login   ${email_msg}    ${empty_email}

Login empty password
    Login   ${pw_msg}       ${empty_pw}         radek.tester@seznam.cz



*** Keywords ***

Login
    [Documentation]  Evaluates Login where email and password can be empty
    [Arguments]  ${validation_id}      ${validation_text}       ${email}=    ${password}=
    New Page        ${URL}
    Get Title       contains                            Rohlik
    Click           id=headerLogin
    Type Text       data-test=user-login-form-email     ${email}
    Type Text       data-test=user-login-form-password  ${password}
    Click           data-test=btnSignIn
    Get Text        ${validation_id}                     ==         ${validation_text}
    Take Screenshot
