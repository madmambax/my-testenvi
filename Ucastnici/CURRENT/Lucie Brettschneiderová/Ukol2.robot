*** Settings ***
Library	SeleniumLibrary

*** Variables ***
${url}		        https://www.rohlik.cz/
${textLogin}        Přihlášení
${errorMailReq}     Email je povinný
${errorPassReq}     Heslo je povinné
${wrongMailPass}    Zadal(a) jste nesprávný e-mail nebo heslo.

*** Test Cases ***
Pozitivni - Vyhleda existujici zbozi
    open browser                        ${url}                                          chrome
    log to console                      Moje url je ${url}
    log                                 Moje url je ${url}
    NajdiZbozi                          okurka
    element should contain              data-test=product-1                             okurka

Pozitivni - Kliknuti na tlacitko "Prihlasit" otevre login formular
    click element                       headerLogin
    wait until page contains            ${textLogin}
    log to console                      Muj text na login strance je ${textLogin}
    log                                 Muj text na login strance je ${textLogin}
    page should contain element         xpath://h3[text()='${textLogin}']

Negativni - Odeslani prazdneho formulare vyvola required chybu u jmena a hesla
    click button                        Přihlásit se
    page should contain                 ${errorMailReq}
    log to console                      Chyba loginu je: ${errorMailReq}
    log                                 Chyba loginu je: ${errorMailReq}
    page should contain                 ${errorPassReq}
    log to console                      Chyba hesla je: ${errorPassReq}
    log                                 Chyba hesla je: ${errorPassReq}

Negativni - Prihlaseni - error pro spatne zadane udaje
    Login                               a@a.com                                         test
    wait until page contains            ${wrongMailPass}
    log to console                      Chyba pro spatne udaje je: ${wrongMailPass}
    log                                 Chyba pro spatne udaje je: ${wrongMailPass}
    [Teardown]                          close browser

*** Keywords ***
Login
    [Arguments]                         ${username}                                     ${password}
    input text                          email                                           ${username}
    input text                          password                                        ${password}
    click button                        Přihlásit se

NajdiZbozi
    [Arguments]                         ${zbozi}
    click element                       searchGlobal
    input text                          searchGlobal                                    ${zbozi}
    wait until page contains element    id:whisperer
    click button                        xpath://*[@id="searchForm"]/button
