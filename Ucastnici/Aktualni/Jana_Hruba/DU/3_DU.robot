*** Settings ***
Library  Browser

*** Test Cases ***
Prihlasenie sa na stranku rohlik.cz
    New Browser     chromium    headless=false
    New Page        https://www.rohlik.cz/
    Click           data-test=header-user-icon
    Type Text       data-test=user-login-form-email         jana.hruba@solitea.cz
    Type Text       data-test=user-login-form-password      AutomatickeTesty
    Click           data-test=btnSignIn
    Take Screenshot



