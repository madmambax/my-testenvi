*** Settings ***
Library  Browser


*** Variables ***
${URL}      https://www2.hm.com/cs_cz/index.htmll


*** Test Cases ***

Login - incorrect login
    Login               testtest@seynam.cz                     ghjghj                      Přihlásit se

Login - incorrect password
   Login               testerkabunova@seznam.cz               ghjghj                      Přihlásit se

Login successful
    Login               testerkabunova@seznam.cz              Testerka2021                MŮJ ÚČET
    Logout              Přihlásit se

*** Keywords ***

Login
    [Arguments]     ${useremail}      ${userpassword}     ${result}
    log             ${useremail}
    log             ${userpassword}
    log             ${result}

    New Browser     chromium    headless=false

    New Page        https://www2.hm.com/cs_cz/index.html

    Get Title       contains    Online móda

    Mouse Move Relative To      css=body > header > nav > ul.menu__session > li:nth-child(1) > div > a:nth-child(1)

    Click          css=body > header > nav > ul.menu__session > li:nth-child(1) > div > div:nth-child(3) > button

    Type Text      css=#modal-txt-signin-email         ${useremail}

    Type Text      css=#modal-txt-signin-password       ${userpassword}

    Click          css=#modal-theLoginForm > button


#   Get Text       css=body > header > nav > ul.menu__session > li:nth-child(1) > div > a:nth-child(2)     ==      ${result}
    sleep    5
    Get Text       css=body > header > nav > ul.menu__session > li:nth-child(1) > div > a:nth-child(1)     ==      ${result}
#   Get Text       text="MŮJ ÚČET"      ==          ${result}

Logout
    [Arguments]     ${result}
    log             ${result}
    Sleep       4
    Take Screenshot
    Mouse Move Relative To      css=body > header > nav > ul.menu__session > li:nth-child(1) > div > a:nth-child(2)
    Click                       css=body > header > nav > ul.menu__session > li:nth-child(1) > div > div:nth-child(4) > ul > li:nth-child(3) > a
    Sleep       10
    Get Title                   ==      Přihlásit se | H&M
