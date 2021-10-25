*** Settings ***
Library     Browser

*** Variables ***
${URL}      https://www.alza.cz/

*** Test Cases ***
# Zkusi se přihlásit se spravnym loginem
Prihlaseni success
    Login               tomanova.nada@post.cz              qRmuCPfuDnkK94X        Moje Alza - Naďa Tomanová


*** Keywords ***

Login
    [Arguments]         ${pemail}                           ${pheslo}                   ${pnastane}

    log                 ${pemail}
    log                 ${pheslo}
    log                 ${pnastane}

    New Browser         chromium                           headless=false
    New Page            https://www.alza.cz/
    Get Title           contains  	                       Alza.cz
    Click               id=lblLogin
    Type Text           id=userName                        ${pemail}
    Type Text           id=password                        ${pheslo}
    Click               id=btnLogin
    Get Text            xpath=//*[@id="lblUser"]     ==    ${pnastane}
