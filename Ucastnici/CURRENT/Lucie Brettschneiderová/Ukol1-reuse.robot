*** Settings ***
Library	SeleniumLibrary


*** Variables ***
${url}		https://www.rohlik.cz/


*** Test Cases ***
Pozitivni - Redirect vede ke spravne url
    open browser    ${url}   chrome
    location should be  ${url}vitejte

Pozitivni - Kliknuti na tlacitko "Prihlasit" otevre login formular
    click element   headerLogin
    wait until page contains    Přihlášení
    page should contain element     xpath://h3[text()='Přihlášení']

Negativni - Odeslani prazdneho formulare vyvola required chybu u jmena a hesla
    click button    Přihlásit se
    page should contain     Email je povinný
    page should contain     Heslo je povinné

Negativni - Prihlaseni - error pro spatne zadane udaje
    input text      email       a@a.com
    input text      password    test
    click button    Přihlásit se
    wait until page contains    Zadal(a) jste nesprávný e-mail nebo heslo.
    [Teardown]      close browser


