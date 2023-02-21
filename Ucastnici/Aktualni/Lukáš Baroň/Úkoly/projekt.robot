
# požadavky
#   pip install robotframework-browser
#   rfbrowser init


*** Settings ***
Library  Browser


*** Variables ***
${URL}      https://www.rohlik.cz/vitejte
${ucet}     data-test=header-user-icon


*** Test Cases ***

Prihlaseni bad login
    Login               dsadsad@sdas.cz                     dasdas                      Účet
Prihlaseni bad heslo
    Login               radek.tester@seznam.cz              dasdas                      Účet
Prihlaseni success
    Login               lukasbaron@seznam.cz                tajneheslotajneheslo        LB


*** Keywords ***

# Cílem úkolu je doplnit toto klíčové slovo tak aby všechny testy prošly
Login
    [Arguments]     ${pemail}      ${pheslo}     ${pnastane}

    log             ${pemail}
    log             ${pheslo}
    log             ${pnastane}

    New Browser    chromium        headless=false
    New Context    viewport={'width': 1920, 'height': 1080}
    New Page       ${URL}
    Get Title      contains        Rohlik
    Click          "Povolit všechny"
    Sleep          3
    Click          ${ucet}

    Type Text      id=email        ${pemail}
    Type Text      id=password     ${pheslo}
    Click          xpath=//*[@id="modalOverlay"]/div/div/div[1]/div/div[1]/form/button
    Get Text       ${ucet}  ==     ${pnastane}
    Sleep          5

    #otevřít prohlížeč

    #otevřít stránku rohlik.cz

    #ověřit že se stránka otevřela

    #kliknout na povolit cookies

    #kliknout na Přihlásit

    #zadat email ${pemail} do místa pro zadání emailu


    #zadat heslo ${pheslo} do místa pro zadání hesla

    #klinout na tlačítko "Přihlasit se"

    #ověřit že jsem přihlášený data-test=header-user-icon musí obsahovat to co je v ${pnastane}
