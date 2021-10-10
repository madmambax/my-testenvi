*** Settings ***
Library	SeleniumLibrary


*** Variables ***
${url}		https://www.rohlik.cz/


*** Test Cases ***
Pozitivni - Redirect vede ke spravne url
    open browser    ${url}   chrome
    location should be  ${url}vitejte
    [Teardown]      close browser

Pozitivni - Kliknuti na tlacitko "Prihlasit" otevre login formular
    open browser    ${url}   chrome
    click element   headerLogin
    wait until page contains    Přihlášení
    page should contain element     xpath://h3[text()='Přihlášení']
    [Teardown]      close browser

Negativni - Odeslani prazdneho formulare vyvola required chybu u jmena a hesla
    open browser    ${url}   chrome
    click element   headerLogin
    wait until page contains    Přihlášení
    click button    Přihlásit se
    page should contain     Email je povinný
    page should contain     Heslo je povinné
    [Teardown]      close browser

Negativni - Prihlaseni - error pro spatne zadane udaje
    open browser    ${url}      chrome
    click element   headerLogin
    wait until page contains    Přihlášení
    input text      email       a@a.com
    input text      password    test
    click button    Přihlásit se
    wait until page contains    Zadal(a) jste nesprávný e-mail nebo heslo.
    [Teardown]      close browser

*** Keywords ***

