*** Settings ***
Library  Browser

*** Variables ***
${URL}      https://www.mypillow.cz/
${pemail}   dvasek1
${pheslo}   Kalendar66.

#robot .\Pillow.robot

*** Test Cases ***

Prihlaseni bad login
    Login          dvasek1                     Kalendar66.                      Přihlásit
    New Browser    chromium    headless=false
    New Context    viewport={'width': 1720, 'height': 980}
    New Page       ${URL}
    Get Title      ==   Pillow pojišťovna
    Click          text="Přihlásit se"
    sleep          2
    Click          id=username
    Type Text      id=username    ${pemail}
    sleep          2
    Click          id=password
    Type Text      id=password    ${pheslo}
    sleep          2
    Click          text="Pokračovat"
    sleep          4
    Take Screenshot
    sleep          2

*** Keywords ***
Login

    [Arguments]     ${pemail}      ${pheslo}     ${pnastane}
    log             ${pemail}
    log             ${pheslo}
    log             ${pnastane}

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

#Prihlaseni success
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
    #Login          radek.tester@seznam.cz              tajneheslotajneheslo        JT
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
