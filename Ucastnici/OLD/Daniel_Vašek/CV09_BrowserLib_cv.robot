
*** Settings ***

Library  Browser
Resource        Data_and_Config/TestData.robot
Resource        Data_and_Config/Configuration.robot

*** Variables ***

*** Test Cases ***
Prihlaseni bad heslo
    Login          radek.tester@seznam.cz              dasdas                      Zadal(a) jste nesprávný e-mail nebo heslo.
Prihlaseni bad login
    Login          dsadsad@sdas.cz                     dasdas                      Zadal(a) jste nesprávný e-mail nebo heslo.
Prihlaseni success
    Login          radek.tester@seznam.cz       tajneheslotajneheslo               JT
    Logout

*** Keywords ***

# Cílem úkolu je doplnit toto klíčové slovo tak aby všechny testy prošly
Login
    [Arguments]                   ${pemail}     ${pheslo}       ${pnastane}
    log                           ${pemail}
    log                           ${pheslo}
    log                           ${pnastane}

    #otevřít prohlížeč
    New Browser    chromium    headless=false
    New Context    viewport={'width': 1720, 'height': 980}

    #otevřít stránku rohlik.cz
    New Page       ${URL}

    #ověřit že se stránka otevřela
    Get Title      ==   Online supermarket Rohlik.cz — nejrychlejší doručení ve městě

    #Cooke (nastavení jejich akceptování)
    Cookie          AcceptAll

    #kliknout na Přihlásit
    Click          data-test=IconUserLogin
    sleep          2

    #zadat email ${pemail} do místa pro zadání emailu
    Click          id=email
    Type Text      id=email  ${pemail}
    sleep          2

    #zadat heslo ${pheslo} do místa pro zadání hesla
    Click          id=password
    Type Text      id=password  ${pheslo}
    sleep          2


    #klinout na tlačítko "Přihlasit se"
    Click          data-test=btnSignIn
    sleep          2

    #ověřit že jsem přihlášený data-test=header-user-icon musí obsahovat to co je v ${pnastane}
    Get Text        data-test=header-user-icon
    Take Screenshot
    sleep          2

Cookie
    [Arguments]         ${type}
    IF  "${type}" == "AcceptAll"
        Click           id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    ELSE
        Click           id="CybotCookiebotDialogBodyButtonDecline"
    END

    sleep               2   #workaround: Probliknutí cele stránky po kliknutí na tlačítko

Logout
        Go to           ${URL}
        Click           xpath=//div[@class='u-mr--8']
        Click           data-test=user-box-logout-button
        Take Screenshot
