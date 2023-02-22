*** Settings ***
Library  Browser
Documentation   Ukazuje jak vytvořit automatické testy pokud máte jedno místo (selektor) kde
...             kontrolovat jestli je nebo není uživatel přihlášen. V našem případě je to
...             selektor xpath=//div[@class='u-mr--8'] který obsahuje buďto iniciály uživatele (např MS)
...             nebo text "Účet" pokud se uživatel nepřihlásí


*** Variables ***
${URL}      https://www.rohlik.cz/


*** Test Cases ***

Login - Uspesne prihlaseni - varianta kontrola v parametru klicoveho slova
    Login_s_kontrolou           bavemal543@cebaike.com              tajneheslotajneheslo        MS

Login - Uspesne prihlaseni i varianta kontrola po klicovem slovu
    Login_bez_kontroly          bavemal543@cebaike.com              tajneheslotajneheslo
    Uživatel je přihlášen       MS


Login - Chybne heslo - varianta kontrola v parametru klicoveho slova
    Login_s_kontrolou           bavemal543@cebaike.com              chyba        Účet

Login - Chybne heslo - Uspesne prihlaseni i varianta kontrola po klicovem slovu
    Login_bez_kontroly          bavemal543@cebaike.com              chyba
    Uživatel není přihlášen



*** Keywords ***
Login_s_kontrolou
   [Arguments]      ${Email}         ${Heslo}            ${Text}

#   New Browser        headless=false     #dá se použít pro nastavení dalších parametru - umožňuje např vypnout headless mode
   New Page         ${URL}
   Get Title        contains                         Online supermarket Rohlik.cz

   Cookie           AcceptAll

   Click            data-test=header-user-icon
   Type Text        id=email                        ${Email}
   Type Text        id=password                     ${Heslo}
   Click            data-test=btnSignIn

   Get Text         xpath=//div[@class='u-mr--8']   contains                                ${Text}


Login_bez_kontroly
   [Arguments]      ${Email}                        ${Heslo}

   New Page         ${URL}
   Get Title        contains                         Online supermarket Rohlik.cz

   Cookie           AcceptAll

   Click            data-test=header-user-icon
   Type Text        id=email                        ${Email}
   Type Text        id=password                     ${Heslo}
   Click            data-test=btnSignIn

Uživatel je přihlášen
    [Arguments]     ${Text}
    Get Text        xpath=//div[@class='u-mr--8']   contains                                ${Text}


Uživatel není přihlášen

    Get Text        xpath=//div[@class='u-mr--8']   contains                                Účet



Cookie
    [Arguments]     ${type}
    IF  "${type}" == "AcceptAll"
        Click       id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    ELSE
        Click       id=CybotCookiebotDialogBodyButtonDecline
    END

    sleep           1      #workaround: Probliknutí cele stránky po kliknutí na tlačítko

