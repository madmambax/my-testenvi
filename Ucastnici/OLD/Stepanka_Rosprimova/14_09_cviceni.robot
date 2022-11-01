#   požadavky
#   pip install robotframework-browser
#   rfbrowser init

*** Settings ***
Library  Browser

*** Variables ***
${URL}      https://www.rohlik.cz/

*** Test Cases ***
Prihlaseni bad login
    Login               dsadsad@sdas.cz                     dasdas                      Přihlásit

Prihlaseni bad heslo
    Login               radek.tester@seznam.cz              dasdas                      Přihlásit

Prihlaseni success
    Login               radek.tester@seznam.cz              tajneheslotajneheslo        JT

*** Keywords ***
Login
    [Arguments]     ${pemail}      ${pheslo}     ${pnastane}

    Log             ${pemail}
    Log             ${pheslo}
    Log             ${pnastane}

    New Browser     chromium    headless=false
#   New Context     viewport={'width': 1920, 'height': 1080}
    New Page        ${URL}
    Get Title       ==    Online supermarket Rohlik.cz — nejrychlejší doručení ve městě
    Click           id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    Sleep           3    # nutné z důvodu chyby na rohlik.cz
    Click           id=headerLogin
    Sleep           3
    Type Text       css=#email       ${pemail}
    Type Text       css=#password    ${pheslo}
    Sleep           3
    Click           data-test=btnSignIn
    Get Text        data-test=header-user-icon      ==      ${pnastane}

Starting a browser with a page
    New Browser    chromium    headless=false
    New Page       https://rohlik.cz
    Get Title      ==    Online supermarket Rohlik.cz — nejrychlejší doručení ve městě
    Click          id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    Sleep          3    # nutné z důvodu chyby na rohlik.cz
#   Click          text="Přihlásit"
    Click          id=headerLogin
#   Click          css=#headerLogin
#   Click          xpath=//*[@id="headerLogin"]
#   Click         data-test=username
    Sleep          3
    Type Text      css=#email       radek.tester@seznam.cz
    Type Text      css=#password    tajneheslotajneheslo
    Sleep          3
    Click          data-test=btnSignIn
    Get Text       data-test=header-user-icon
    #otevřít prohlížeč
    #otevřít stránku rohlik.cz
    #ověřit že se stránka otevřela
    #kliknout na Přihlásit
    #zadat email ${pemail} do místa pro zadání emailu
    #zadat heslo ${pheslo} do místa pro zadání hesla
    #klinout na tlačítko "Přihlasit se"
    #ověřit že jsem přihlášený data-test=header-user-icon musí obsahovat to co je v ${pnastane}
