*** Settings ***
Library  Browser
Documentation   Ukazuje jak vytvořit automatické testy pokud NEMÁTE jedno místo (selektor) kde
...             kontrolovat jestli je nebo není uživatel přihlášen. Tedy potřebujete se podívat na jedno
...             místo pokud je uživatel přihlášen a na jiné pokud přihlášen není
...             v našem případě to bude selektor id=headerLogin pokud nejsem přihlášen
...             id=headerUser pokud jsem přihlášen
...             Všiměnte si, že pokud používat variantu kontrola pomocí dalšího paramteru KS je třeba
...             přidat podmínku


*** Variables ***
${URL}      https://www.rohlik.cz/


*** Test Cases ***

Login - Uspesne prihlaseni - varianta kontrola v parametru klicoveho slova
    Login_s_kontrolou           bavemal543@cebaike.com              tajneheslotajneheslo        MS

Login - Uspesne prihlaseni i varianta kontrola po klicovem slovu
    Login_bez_kontroly          bavemal543@cebaike.com              tajneheslotajneheslo
    Uživatel je přihlášen       MS


Login - Chybne heslo - varianta kontrola v parametru klicoveho slova
    Login_s_kontrolou           bavemal543@cebaike.com              chyba        Přihlásit

Login - Chybne heslo - Uspesne prihlaseni i varianta kontrola po klicovem slovu
    Login_bez_kontroly          bavemal543@cebaike.com              chyba
    Uživatel není přihlášen



*** Keywords ***
Login_s_kontrolou
   [Arguments]      ${Email}            ${Heslo}            ${Text}
#   Open Browser     ${URL}             headless=false     #dá se použít místo New Page - umožňuje např vypnout headless mode
   New Page         ${URL}
   Get Title        contains            Online supermarket Rohlik.cz

   Cookie           AcceptAll

   Click            id=headerLogin
   Type Text        id=email            ${Email}
   Type Text        id=password         ${Heslo}
   Click            data-test=btnSignIn

#   Potřebuji vědět zda budu kontrolovat zda uživatel je nebo není přihlášen
#   mohl bych přidat 4. parametr, který by obsahoval ANO nebo NE, pokud má být uživatel
#   přihlášen. Abych nemusel přidávat 4. paramter, využil jsem 3. Parametr který mi tut informaci
#   také poskytuje. Pokud uživatel nemá být přihlášen má hodnotu "Přihlásit"
   IF    "${Text}" == "Přihlásit"
       Get Text     id=headerLogin         contains            Přihlásit
   ELSE
       Get Text     id=headerUser          contains            ${Text}
   END



Login_bez_kontroly
   [Arguments]          ${Email}            ${Heslo}

   New Page             ${URL}
   Get Title            contains            Online supermarket Rohlik.cz

   Cookie               AcceptAll

   Click                id=headerLogin
   Type Text            id=email                        ${Email}
   Type Text            id=password                     ${Heslo}
   Click                data-test=btnSignIn

Uživatel je přihlášen
    [Arguments]     ${Text}
    Get Text        id=headerUser       contains        ${Text}


Uživatel není přihlášen

    Get Text        id=headerLogin      contains        Přihlásit



Cookie
    [Arguments]         ${type}
    IF  "${type}" == "AcceptAll"
        Click           id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    ELSE
        Click           id=CybotCookiebotDialogBodyButtonDecline
    END

    sleep               1      #workaround: Probliknutí cele stránky po kliknutí na tlačítko

