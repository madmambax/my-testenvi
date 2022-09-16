*** Settings ***
Library  Browser

*** Variables ***
${URL}      https://www.rohlik.cz/vitejte
#${pemail}   radek.tester@seznam.cz
#${pheslo}   tajneheslotajneheslo
#robot CV09_BrowserLib_cv.robot

*** Test Cases ***

Prihlaseni success
    Login          radek.tester@seznam.cz       tajneheslotajneheslo        JT
    New Browser    chromium    headless=false
    New Context    viewport={'width': 1720, 'height': 980}
    New Page       ${URL}
    Get Title      ==   Online supermarket Rohlik.cz — nejrychlejší doručení ve městě
    Click          id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    sleep          2
    Click          data-test=IconUserLogin
    sleep          2
    Click          id=email
    Type Text      id=email
    sleep          2
    Click          id=password
    Type Text      id=password
    sleep          2
    Click          text="Přihlásit se"
    sleep          2
    Get text       data-test=header-user-icon
    Take Screenshot
    sleep          2

*** Keywords ***
Login
    [Arguments]                   ${pemail}     ${pheslo}       ${pnastane}
    @{seznam} =     Create list   ${pemail}     ${pheslo}       ${pnastane}
    log                           ${pemail}
    log                           ${pheslo}
    log                           ${pnastane}

#Prihlaseni bad heslo
    #New Browser    chromium    headless=false
    #New Context    viewport={'width': 1920, 'height': 1080}
    #New Page       ${URL}
    #Get Title      ==   Online supermarket Rohlik.cz — nejrychlejší doručení ve městě
    #Click          data-test=IconUserLogin
    #sleep          10
    #Click          id=header
    #sleep          10
    #Click          id=pageFullWidth
    #sleep          10
    #Login          radek.tester@seznam.cz              dasdas                      Přihlásit
    #Click          text="Přihlásit se"
    #Take Screenshot
    #sleep           5

#Prihlaseni bad login
    #New Browser    chromium    headless=false
    #New Context    viewport={'width': 1920, 'height': 1080}
    #New Page       ${URL}
    #Get Title      ==   Online supermarket Rohlik.cz — nejrychlejší doručení ve městě
    #Click          data-test=IconUserLogin
    #sleep          10
    #Click          id=header
    #sleep          10
    #Click          id=pageFullWidth
    #sleep          10
    #Login          dsadsad@sdas.cz                     dasdas                      Přihlásit
    #Click          text="Přihlásit se"
    #Take Screenshot
    #sleep           5




    #otevřít prohlížeč

    #otevřít stránku rohlik.cz

    #ověřit že se stránka otevřela

    #kliknout na Přihlásit

    #zadat email ${pemail} do místa pro zadání emailu

    #zadat heslo ${pheslo} do místa pro zadání hesla

    #klinout na tlačítko "Přihlasit se"

    #ověřit že jsem přihlášený data-test=header-user-icon musí obsahovat to co je v ${pnastane}
