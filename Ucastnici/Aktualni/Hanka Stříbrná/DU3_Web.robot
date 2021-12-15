*** Settings ***
Library  Browser




*** Test Cases ***

Správné heslo

    Login           stribrna.hana@gmail.com             zkusebniheslo       HS
    Take Screenshot

Špatné heslo

    Login           spatnyemail                         spatneheslo         Přihlásit
    Take Screenshot

Odlášení
    Login           stribrna.hana@gmail.com             zkusebniheslo       HS
    Click           data-test=header-user-icon
    Click           data-test=user-box-logout-button
    Get Text        data-test=header-user-icon      ==      Přihlásit
    Take Screenshot




*** Keywords ***

Login
    [Arguments]     ${můjemail}      ${mojeheslo}     ${odezva}

    log             ${můjemail}
    log             ${mojeheslo}
    log             ${odezva}

    New Browser    chromium    headless=true
    New Context    viewport={'width': 1920, 'height': 1080}
    New Page       https://www.rohlik.cz/
    Get Title       Contains    Rohlik.cz
    Click           "Přihlásit"
    Type Text       data-test=user-login-form-email     ${můjemail}
    Type Text       id=password                         ${mojeheslo}
    Click           data-test=btnSignIn
    Get Text        data-test=header-user-icon      ==      ${odezva}

