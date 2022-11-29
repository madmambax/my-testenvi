
# požadavky
#   pip install robotframework-browser
#   rfbrowser init


*** Settings ***
Library  Browser


*** Variables ***
${URL}                   https://www.rohlik.cz/
${pemail}                a.byrtusova1@gmail.com
${pheslo}                testovaci
${BUTTON_COOKIES}        \#CybotCookiebotDialogBodyButtonDecline


*** Test Cases ***

#Prihlaseni bad login
  #  Login               dsadsad@sdas.cz                     dasdas                      Přihlásit
#Prihlaseni bad heslo
#  Login               a.byrtusova1@gmail.com              dasdas                      Přihlásit
Prihlaseni success
    Login            a.byrtusova1@gmail.com              testovaci                      AB
    Logout


*** Keywords ***

# Cílem úkolu je doplnit toto klíčové slovo tak aby všechny testy prošly
Login
    [Arguments]     ${pemail}      ${pheslo}     ${pnastane}

    log             ${pemail}
    log             ${pheslo}
    log             ${pnastane}

    #otevřít prohlížeč
    New Browser    chromium    headless=false
    #otevřít stránku rohlik.cz
    New Page       ${URL}
    sleep  5
    #ověřit že se stránka otevřela
    Get Title      ==       Online supermarket Rohlik.cz — nejrychlejší doručení ve městě
    Cookies
    #kliknout na Přihlásit
    Click          data-test=IconUserLogin
    #zadat email ${pemail} do místa pro zadání emailu
    Type Text         id=email    ${pemail}
    #zadat heslo ${pheslo} do místa pro zadání hesla
    Type Text      id=password      ${pheslo}
    #klinout na tlačítko "Přihlasit se"
    Click           data-test=btnSignIn
    sleep  5
    #ověřit že jsem přihlášený data-test=header-user-icon musí obsahovat to co je v ${pnastane}
    ${text} =     Get Text    css=[data-test=header-user-icon]
    log to console  ${text}
    Should Contain  ${text}  ${pnastane}


Logout
    Click   data-test=header-user-icon
    Click   data-test=user-box-logout-button
    sleep   5

Cookies
    Click    ${BUTTON_COOKIES}