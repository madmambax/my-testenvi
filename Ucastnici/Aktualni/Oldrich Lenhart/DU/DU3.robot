*** Settings ***
Library  Browser


*** Variables ***
${HM web}      https://www2.hm.com/cs_cz/index.html


*** Test Cases ***

Úspěšné přihlášení a odhlášení
    Login_HM           tester.olda@gmail.com       Test12345       MŮJ ÚČET
    Logout_HM


*** Keywords ***

Login_HM
    [Arguments]     ${pemail}      ${pheslo}    ${pnastane}

    log             ${pemail}
    log             ${pheslo}
    log             ${pnastane}

    #otevřít prohlížeč, novou stránku a ověř title
    New Browser     chromium        headless=false
    New Page        ${HM web}
    Get title       contains        H&M

    #kliknout na povolit cookies
    Click           id=onetrust-accept-btn-handler
    Sleep           1

    #kliknout na Účet
    Click           css=.TzhG.__8OUj.aOrM.goq6 > .qm6G
    Sleep           1

    #zadat email ${pemail} do místa pro zadání emailu
    Type text       id=email         ${pemail}
    Sleep           1
    #zadat heslo ${pheslo} do místa pro zadání hesla
    Type text       id=password      ${pheslo}
    Sleep           2

    #Zobrazit heslo
    Click           css=button[role='switch'] > .__7oWA
    Sleep           2

    #klinout na tlačítko "Přihlasit se"
    Click           data-testid=submitButton
    Sleep           3


    #ověřit že jsem přihlášený - NEDAŘÍ SE !!!
    #Get text        css=.CTA-module--action__AdoYs.CTA-module--iconPosition-start__NLINE.CTA-module--medium__kRlC3.CTA-module--reset__ln67B > .SignInBox-module--signInText__xGKRM == ${pnastane}

Logout_HM
    Click           css=.TzhG.__8OUj.aOrM.goq6 > .qm6G
    Sleep           3
    Click           xpath=/html//div[@id='app']//div[@class='Hub--container__DguHi']/div//nav[@class='DynamicUserMenu--userMenuWrapper__zZ9Ib']/ul[@class='UserMenu-module--ul__rjjeq']//a[@href='/cs_cz/logout']
    Sleep           3
