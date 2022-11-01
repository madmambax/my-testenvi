*** Settings ***
Library  Browser

*** Variables ***
${URL}      https://www.rohlik.cz/
${title}    Online supermarket Rohlik.cz — nejrychlejší doručení ve městě

*** Test Cases ***

Přihlášení s dobrým loginem pro jankraus
    Login               jankraus92@gmail.com                OnLWgNP3                   JK

Přihlášení se špatným heslem
    Login               radek.tester@seznam.cz              dasdas                     J

Prihlaseni s dobrým loginem pro radekkitner
    Login               radek.tester@seznam.cz              tajneheslotajneheslo        JT


*** Keywords ***

Login
    [Arguments]     ${pemail}      ${pheslo}     ${user}
    New Browser     chromium    headless=false
    New Page        ${URL}
    Get Title       contains   ${title}
    Click           id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    Sleep           3
    Click           id=headerLogin
    Sleep           2
    Type Text       id=email      ${pemail}
    Type Text       id=password   ${pheslo}
    Click           text="Přihlásit se"
    Sleep           3
    ${header_icon}=   Get Text     data-test=header-user-icon

    #Ověření přihlášení uživatele pomocí iniciálů v ikonce
    IF    '${header_icon}' == '${user}'
        Log To Console    Úspěšně přihlášeno.
    ELSE IF     '${header_icon}' == 'Přihlásit'
        Log To Console    Špatné heslo
    END

    Sleep           2
    Click           data-test=header-user-icon
    Sleep           1
    ${logout}=      Run Keyword And Return Status    Get Element    text="Odhlásit se"

    #Pokud předchozí proměnná logout bude true, uživatel se odhlásí
    IF    '${logout}' == 'True'
        Click       text="Odhlásit se"
        Log To Console    Úspěšně odhlášeno
    ELSE
        Log To Console    Není co odhlašovat, bylo zadáno špatné heslo.
    END

    log             ${pemail}
    log             ${pheslo}
    log             ${user}
    Sleep           5
