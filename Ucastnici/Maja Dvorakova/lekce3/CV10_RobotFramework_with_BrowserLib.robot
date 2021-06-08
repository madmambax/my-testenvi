# požadavky
#   pip install robotframework-browser
#   rfbrowser init


*** Settings ***
Documentation   Automatizace rohlik.cz s BrowserLibrary
Library  Browser


*** Variables ***
${URL}      https://www.rohlik.cz/


*** Test Cases ***

Prihlaseni bad login
    Login       ejkjsa@jk.cz            jej                         Přihlásit

Prihlaseni bad heslo
    Login       radek.tester@seznam.cz  tajneheslo                  Přihlásit

Prihlaseni success
    Login       radek.tester@seznam.cz  tajneheslotajneheslo        JT

    #vytvořit vlastního uživatele

Test webu
    Open Browser
    New Page            ${URL}
    Get Title           contains                                Rohlik
    Click               id=headerLogin
    Type Text           data-test=user-login-form-email         kfjhdskjfhsadjkf
    Type Text           data-test=user-login-form-password      password
    Click               data-test="btnSignIn"
    Get Text            data-test=notification-content
    Take Screenshot




*** Keywords ***

Login

    {Arguments}         ${email}                                ${heslo}            ${validation}
    New Page            ${URL}
    Get Title           contains                                Rohlik
    Click               id=headerLogin
    Type Text           data-test=user-login-form-email         ${email}
    Type Text           data-test=user-login-form-password      ${heslo}
    Click               data-test="btnSignIn"
    Get Text            data-test=notification-content
    Take Screenshot

