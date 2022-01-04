*** Settings ***
Library  Browser


*** Variables ***
${URL}      https://www.drmax.cz/


*** Test Cases ***

Prihlaseni ok
    Login               jitka.malachova@gmail.com              HesloHeslo123456        Jitka Malachová
Odhlášení
    Logout

*** Keywords ***

Login
    [Arguments]     ${pemail}      ${pheslo}     ${pnastane}

    log             ${pemail}
    log             ${pheslo}
    log             ${pnastane}

    #otevřít prohlížeč
    NEW BROWSER     chromium    headless=false
    #otevřít stránku rohlik.cz
    new page        https://www.drmax.cz/
    #ověřit že se stránka otevřela
    get title       contains    Dr. Max
    #kliknout na Přihlásit
    click           id=header-login-link
    Set Browser Timeout                 200
#    zadat email ${pemail} do místa pro zadání emailu
    type text       id=username    ${pemail}
    set browser timeout                 100
    #zadat heslo ${pheslo} do místa pro zadání hesla
    type text       id=password   ${pheslo}
    set browser timeout                 100
    #klinout na tlačítko "Přihlasit se"
    click           id=submit
    set browser timeout                 100
    #ověřit že jsem přihlášený data-test=header-user-icon musí obsahovat to co je v ${pnastane}
   get text        data-test-id=header-login-link-logged-in  ==  ${pnastane}
   set browser timeout                  200

Logout

    Click          data-test-id=header-login-link-logged-in
    Click          data-test-id=header-login-popover-logout-link
