*** Comments ***

*** Settings ***
Documentation
Library  Browser

*** Variables ***
${URL}      https://www.rohlik.cz/

*** Test Cases ***

1. Case (prihlaseni 'bad login')
    Login               dsadsad@sdas.cz                     dasdas                      Přihlásit

2. Case (prihlaseni 'bad heslo')
    Login               radek.tester@seznam.cz              dasdas                      Přihlásit

3. Case (prihlaseni 'success')
    Login               radek.tester@seznam.cz              tajneheslotajneheslo        JT

*** Keywords ***

Login
    [Arguments]     ${pemail}      ${pheslo}     ${pnastane}

    log             ${pemail}
    log             ${pheslo}
    log             ${pnastane}

    #otevřít prohlížeč
    New Browser     firefox        headless=false

    #otevřít stránku rohlik.cz
    New Page    ${URL}

    #ověřit že se stránka otevřela
    Get Title   contains    Rohlik.cz

    #Kliknout na tlačítko 'Odmítnout' (týká se Cookies).
    Click  id=CybotCookiebotDialogBodyButtonDecline

    #kliknout na tlačítko Přihlásit
    Click    id=headerLogin

    #zadat email ${pemail} do místa pro zadání emailu
    Type Text    id=email    ${pemail}
    # V Devoloper Tools na stránce rohlik.cz vidím u polí 'Vaše heslo' a 'Váš email' stejný data-test !!!

    #zadat heslo ${pheslo} do místa pro zadání hesla
    Type Text    id=password     ${pheslo}
    # V Devoloper Tools na stránce rohlik.cz vidím u polí 'Vaše heslo' a 'Váš email' stejný data-test !!!

    #kliknout na tlačítko "Přihlasit se"
    Click       data-test=btnSignIn
    #RBF ho nemůže najít pod jeho data-testem...proč?!  data-test=btnSignIn

    #ověřit že jsem přihlášený data-test=header-user-icon musí obsahovat to co je v ${pnastane}
    Get Text    data-test=header-user-icon      ==  ${pnastane}
