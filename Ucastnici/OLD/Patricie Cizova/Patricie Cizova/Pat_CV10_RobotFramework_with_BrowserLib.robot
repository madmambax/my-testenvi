# požadavky
#   pip install robotframework-browser
#   rfbrowser init


*** Settings ***
Documentation   Automatizace rohlik.cz s BrowserLibrary
Library  Browser


*** Variables ***
${URL}      https://www.rohlik.cz/


*** Test Cases ***

Test webu
    New Page            ${URL}
    Get Title           contains                                    Rohlik
    Click               id=headerLogin
    Type Text           data-test=user-login-form-email             neexistujici@uzivatel.cz
    Type Text           data-test=user-login-form-password           badpass
    Click               data-test=btnSignIn
    Get Text            data-test=notification-content       ==      Zadal(a) jste nesprávný e-mail nebo heslo.
    Take Screenshot