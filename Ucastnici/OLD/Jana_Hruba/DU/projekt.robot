*** Settings ***
Library  Browser


*** Test Cases ***
Prihlasenie a odhlasenie sa z uctu na rohlik.cz
    #otvorenie prehliadaca a stranky rohlik.cz
    New Browser     chromium    headless=false
    New Page        https://www.rohlik.cz/

    #overenie otvorenia stranky
    Get Title       contains                                Rohlik.cz

    #prihlasit sa pomocou prihlasovacich udajov
    Click           data-test=header-user-icon
    Type Text       data-test=user-login-form-email         jana.hruba@solitea.cz
    Type Text       data-test=user-login-form-password      AutomatickeTesty
    Click           data-test=btnSignIn

    # overenie, ci som prihlasena
    Get Text        data-test=header-user-icon      ==      JT

    #odhlasenie z uctu
    Click           data-test=header-user-icon
    Click           data-test=user-box-logout-button

    #overenie, ze ma odhlasilo z uctu
    Get Text        data-test=header-user-icon      ==      Přihlásit




