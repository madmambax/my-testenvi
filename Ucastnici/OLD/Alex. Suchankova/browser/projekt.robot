*** Settings ***
Library  Browser

*** Variables ***
${URL}      https://www.rohlik.cz/

*** Test Cases ***

#Prihlaseni bad login
#    Login               dsadsad@sdas.cz                     dasdas                      Přihlásit

#Prihlaseni bad heslo
#    Login               radek.tester@seznam.cz              dasdas                      Přihlásit

Prihlaseni success
    Login               radek.tester@seznam.cz              tajneheslotajneheslo        JT


*** Keywords ***

Login
    [Arguments]     ${pemail}      ${pheslo}     ${pnastane}

    log             ${pemail}
    log             ${pheslo}
    log             ${pnastane}

    #otevřít prohlížeč
    New Browser    chromium    headless=false
    #otevřít stránku rohlik.cz
    New Page        https://www.rohlik.cz/
    #ověřit že se stránka otevřela
    get title       contains    Online supermarket
    #kliknout na Přihlásit
    click           id=headerLogin
    #zadat email ${pemail} do místa pro zadání emailu
    type Text       data-test=user-login-form-email    ${pemail}
    #zadat heslo ${pheslo} do místa pro zadání hesla
    type text       data-test=user-login-form-password  ${pheslo}
    #klinout na tlačítko "Přihlasit se"
    click           data-test=btnSignIn
    #ověřit že jsem přihlášený data-test=header-user-icon musí obsahovat to co je v ${pnastane}
    get text        data-test=header-user-icon  ==  ${pnastane}
    #klik na iniciály
    click           data-test=header-user-icon
    #kliknout na odhlásit
    click           data-test=user-box-logout-button
    #ověřit, že je odhlášeno (kliknutím na Přihlásit)
    click           //*[@id="headerLogin"]

