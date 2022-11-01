# požadavky
#   pip install robotframework-browser
#   rfbrowser init


*** Settings ***
Library  Browser


*** Variables ***
${URL}      https://rohlik.cz/vitejte

*** Test Cases ***
Prihlaseni bad login
    Login               dsadsad@sdas.cz                     dasdas                      Přihlásit

Prihlaseni bad heslo
    Login               radek.tester@seznam.cz              dasdas                      Přihlásit

Prihlaseni success
    Login               radek.tester@seznam.cz              tajneheslotajneheslo        JT
    odhlasit

*** Keywords ***
Login

    [Arguments]     ${pemail}      ${pheslo}     ${pnastane}

    Log             ${pemail}
    Log             ${pheslo}
    Log             ${pnastane}

    Set Browser Timeout  ${60}
    New Browser        chromium    headless=false
    New Context        viewport={'width': 1920, 'height': 1080}
    New Page           ${URL}
    Get Title          ==    Online supermarket Rohlik.cz — nejrychlejší doručení ve městě
    sleep              2
    Click              id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    sleep              2        # nutné z důvodu chyby na rohlik.cz
    click              id=headerLogin
    sleep              10
    Type Text          css=#email       ${pemail}
    Type Text          css=#password    ${pheslo}
    Click              data-test=btnSignIn
    Get Text           data-test=header-user-icon      ==      ${pnastane}

odhlasit
    Sleep              5
    Click              id=headerUser
    Click              text="Odhlásit se"


Prihlaseni bad heslo
    Set Browser Timeout  ${60}
    New Browser        chromium    headless=false
    New Context        viewport={'width': 1920, 'height': 1080}
    New Page           ${URL}
    Get Title          ==    Online supermarket Rohlik.cz — nejrychlejší doručení ve městě
    sleep              2
    Click              id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    sleep              2        # nutné z důvodu chyby na rohlik.cz
    click              id=headerLogin
    sleep              10
    Type Text          css=#email       ${pemail}
    Type Text          css=#password    ${pheslo}
    Click              data-test=btnSignIn
    Get Text        data-test=header-user-icon      ==      ${pnastane}


Prihlaseni success
    Set Browser Timeout  ${60}
    New Browser        chromium    headless=false
    New Context        viewport={'width': 1920, 'height': 1080}
    New Page           ${URL}
    Get Title          ==    Online supermarket Rohlik.cz — nejrychlejší doručení ve městě
    sleep              2
    Click              id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    sleep              2        # nutné z důvodu chyby na rohlik.cz
    click              id=headerLogin
    sleep              10
    Login              radek.tester@seznam.cz              tajneheslotajneheslo        JT
    Click              text="Přihlásit se"
    data-test=header-user-icon ${pnastane}



#*** Keywords ***

#Login
#    [Arguments]     ${pemail}      ${pheslo}     ${pnastane}

#    log             ${pemail}
#    log             ${pheslo}
#    log             ${pnastane}

    #otevřít prohlížeč

    #otevřít stránku rohlik.cz

    #ověřit že se stránka otevřela

    #kliknout na Přihlásit

    #zadat email ${pemail} do místa pro zadání emailu

    #zadat heslo ${pheslo} do místa pro zadání hesla

    #klinout na tlačítko "Přihlasit se"

    #ověřit že jsem přihlášený data-test=header-user-icon musí obsahovat to co je v ${pnastane}