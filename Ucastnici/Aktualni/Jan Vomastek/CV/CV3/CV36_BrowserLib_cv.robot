
# požadavky
#   pip install robotframework-browser
#   rfbrowser init


*** Settings ***
Library  Browser


*** Variables ***
${URL}      https://www.rohlik.cz/


*** Test Cases ***

Prihlaseni bad login
    Login               ahoj.ahoj@ahoj.cz                         TajneHeslo        Přihlásit
Prihlaseni bad heslo
    Login               ymgrbwzhpjdkitarry@tmmcv.net              dasdas            Přihlásit
Prihlaseni success
    Login               ymgrbwzhpjdkitarry@tmmcv.net              TajneHeslo        RF


*** Keywords ***

# Cílem úkolu je doplnit toto klíčové slovo tak aby všechny testy prošly
Login
    [Arguments]     ${pemail}      ${pheslo}     ${pnastane}

    log             ${pemail}
    log             ${pheslo}
    log             ${pnastane}

    #otevřít prohlížeč
    New Browser     chromium  headless=false
    New Context     viewport={'width': 1920, 'height': 1080}

    #otevřít stránku rohlik.cz
    New Page        https://www.rohlik.cz

    #ověřit že se stránka otevřela
    Get Title       *=  Rohlik

    Cookie    no
    #kliknout na Přihlásit
    Click           xpath=//*[@id="headerLogin"]
    #zadat email ${pemail} do místa pro zadání emailu
    Type Text       xpath=//*[@id="email"]         ${pemail}
    #zadat heslo ${pheslo} do místa pro zadání hesla
    Type Secret     xpath=//*[@id="password"]      ${pheslo}

    #klinout na tlačítko "Přihlasit se"
    Click           data-test=btnSignIn

    #ověřit že jsem přihlášený data-test=header-user-icon musí obsahovat to co je v ${pnastane}
    Get Text    data-test=header-user-icon  ==  ${pnastane}

Cookie
    [Arguments]         ${type}
    IF  "${type}" == "AcceptAll"
        # klinout na "Vše povolit"
        Click               xpath=//*[@id="CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll"]
    ELSE
        # klinout na "Odmítnout"
        Click               xpath=//*[@id="CybotCookiebotDialogBodyButtonDecline"]
    END

    sleep                1      #workaround: Probliknutí cele stránky po kliknutí na tlačítko