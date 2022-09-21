*** Settings ***
Library  Browser


*** Variables ***
${URL}      https://www.rohlik.cz/


*** Test Cases ***

Prihlaseni bad login
#Login               dsadsad@sdas.cz                     dasdas                      Přihlásit
    New Browser         chromium                         headless=false
    New Context
#Otevre stranku rohlik.cz
    New Page            ${URL}
    Get Title           contains                         Rohlik  #Kontrola
# odklikne cookies
    Click               id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    Click               id=headerLogin
#Vyplni spatne udaje do Vas e-mail
    Fill Text           id=email                         dsadsad@sdas.cz
#Vyplni sptane udaje do Vase heslo
    Fill Text           id=password                      dasdas
    Sleep               1
    Take Screenshot
#Zkusi se prihlasit
    Click               text="Přihlásit se"
    Sleep               1
    Take Screenshot

Prihlaseni bad heslo
#Login               radek.tester@seznam.cz              dasdas                      Přihlásit
    New Browser          chromium                        headless=false
    New Context
#Otevre stranku rohlik.cz
    New Page            ${URL}
    Get Title           contains                         Rohlik  #Kontrola
# odklikne cookies
    Click               id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    Click               id=headerLogin
#Vyplni spravne udaje do 'Vas e-mail'
    Fill Text           id=email                          radek.tester@seznam.cz
#Vyplni sptane udaje do 'Vase heslo'
    Fill Text           id=password                     dasdas
    Sleep               1
    Take Screenshot
#Zkusi se prihlasit
    Click               text="Přihlásit se"
    Sleep               1
    Take Screenshot


Prihlaseni success
#Login               radek.tester@seznam.cz              tajneheslotajneheslo        JT
    New Browser          chromium                        headless=false
    New Context
#Otevre stranku rohlik.cz
    New Page            ${URL}
    Get Title           contains                         Rohlik  #Kontrola
# odklikne cookies
    Click               id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    Click               id=headerLogin
#Vyplni spravne udaje do 'Vas e-mail'
    Fill Text           xpath=//*[@id="email"]                         radek.tester@seznam.cz
#Vyplni spravne udaje do 'Vase heslo'
    Fill Text           xpath=//*[@id="password"]                      tajneheslotajneheslo
    Sleep               1
    Take Screenshot
#Zkusi se prihlasit
    Click               text="Přihlásit se"
    Sleep               1
    Take Screenshot
#Zkusi se odhlasit
    Get Text            data-test=header-user-icon   ==   JT   #Kontrola
    Click               id=headerUser
    Sleep               1
    Click               text="Odhlásit se"
    Sleep               1
    Take Screenshot







*** Keywords ***

Login
    [Arguments]     ${pemail}      ${pheslo}     ${pnastane}





    log             ${pemail}
    log             ${pheslo}
    log             ${pnastane}

    #otevřít prohlížeč

    #otevřít stránku rohlik.cz

    #ověřit že se stránka otevřela

    #kliknout na Přihlásit

    #zadat email ${pemail} do místa pro zadání emailu

    #zadat heslo ${pheslo} do místa pro zadání hesla

    #klinout na tlačítko "Přihlasit se"

    #ověřit že jsem přihlášený data-test=header-user-icon musí obsahovat to co je v ${pnastane}