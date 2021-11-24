*** Settings ***
Library     Browser

*** Variables ***
${URL}      https://www.rohlik.cz


*** Test Cases ***

Prihlaseni success a odhlaseni
    Login               tomanova.nada@post.cz            qRmuCPfuDnkK94X        JT


*** Keywords ***

Login
    [Arguments]         ${pemail}                           ${pheslo}                   ${pnastane}

    log                 ${pemail}
    log                 ${pheslo}
    log                 ${pnastane}

    New Browser         chromium                    headless=false
    New Page            https://www.rohlik.cz/
    Get Title           contains                    Rohlik
    Click               id=headerLogin

    Type Text           id=email                    ${pemail}

    Type Text           id=password                 ${pheslo}

    Click               data-test=btnSignIn

    Click               id=headerUser
    Sleep               3
    #Click               data-test=user-box-logout-button
    Click               xpath=//*[@id="header"]/div[1]/div[1]/div/div[2]/div/div[2]/div[5]/a
    Sleep               3
