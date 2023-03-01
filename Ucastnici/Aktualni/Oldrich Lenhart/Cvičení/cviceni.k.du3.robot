*** Settings ***
Library  Browser


*** Variables ***
${HM web}      https://www2.hm.com/cs_cz/index.html


*** Test Cases ***

Úspěšné přihlášení
    Login           tester.olda@gamil.com       Test12345       MŮJ ÚČET

*** Keywords ***

Login
    [Arguments]     ${pemail}      ${pheslo}    ${pnastane}

    log             ${pemail}
    log             ${pheslo}
    log             ${pnastane}

    #otevřít prohlížeč, novou stránku a ověř title
    New Browser     chromium        headless==false
    New Page        ${HM web}
    Get title       contains        H&M

    #kliknout na povolit cookies
    Click           id="onetrust-accept-btn-handler"
    Sleep           2

    #kliknout na Účet
    Click           xmlns:xlink="http://www.w3.org/1999/xlink"
    Sleep           2

    #zadat email ${pemail} do místa pro zadání emailu
    Type text       id="email"      ${pemail}
    Sleep           2

    #zadat heslo ${pheslo} do místa pro zadání hesla
    Type text       id="password"      ${pheslo}
    Sleep           2

    #klinout na tlačítko "Přihlasit se"
    Click           data-testid="submitButton"

    #ověřit že jsem přihlášený data-test=header-user-icon musí obsahovat to co je v ${pnastane}
    Get text        css=[class="SignInBox-module--signInText__xGKRM"] == @{pnastane}