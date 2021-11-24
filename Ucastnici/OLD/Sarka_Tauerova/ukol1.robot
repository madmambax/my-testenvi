*** Settings ***
Library	SeleniumLibrary

*** Variables ***
${url}		https://dev.wadmp.com/

*** Test Cases ***
Pozitivni - Redirect vede ke spravne url
    open browser    ${url}   chrome
    wait until page contains    Welcome!
    log             Adresa webu je ${url}
    [Teardown]      close browser

Negativni - Prihlaseni - error pro spatne zadane udaje
    open browser    ${url}      chrome
    wait until page contains    Welcome!
    input text      Email       xxx@xxx.com
    input text      Password    xxx
    click button    SIGN IN
    wait until page contains    Invalid login attempt.
    [Teardown]      close browser

Negativni - Odeslani prazdneho formulare vyvola required chybu u jmena a hesla
    open browser    ${url}   chrome
    wait until page contains    Welcome!
    click button    SIGN IN
    page should contain     The E-mail field is required.
    page should contain     The Password field is required.
    [Teardown]      close browser

Pozitivni - Prihlaseni - Vede k prihlaseni
    open browser    ${url}      chrome
    wait until page contains    Welcome!
    Login
        log             Adresa webu je ${url}
        wait until page contains    Dashboard
        [Teardown]      close browser
*** Keywords ***
Login
    input text      Email       testbrno@email.cz
    input text      Password    Test1234
    click button    SIGN IN