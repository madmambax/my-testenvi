*** Settings ***
Library     Browser
#propojeni na soubor s promennymi
Resource    test_data.robot
Test Setup  New Browser         ${browser}                    headless=false


*** Test Cases ***

Prihlaseni success a odhlaseni
    Login               ${pemail}            ${pheslo}        JT

    Logout



#spravny mail, spatne heslo
Spatne heslo
    Login               ${pemail}            hesloheslo             ${hlaska}



#spatny mail, dobre heslo
Spatny mail
    Login               tomanova.nadatttt@post.cz        ${pheslo}       ${hlaska}





*** Keywords ***

Login
    [Arguments]         ${pemail}                   ${pheslo}                   ${pnastane}
    ${timeout}          Set Browser Timeout         20

    log                 ${pemail}
    log                 ${pheslo}
    log                 ${pnastane}

    #New Browser je nepovinne, ale pak vidime/nevidime otevreny prohlizec
    #New Browser         ${browser}                    headless=false

    New Page            ${URL}
    Get Title           contains                    ${SEL_title_rohlik}
    Click               id=headerLogin

    Type Text           id=email                    ${pemail}

    Type Text           id=password                 ${pheslo}

    Click               data-test=btnSignIn

Logout
    #Kliknutim na inicialy, vyvolame odhlasovaci okno
    Click                xpath=//*[@id="headerUser"]/div
    #Klik na odhlasovaci tlacitko
    Click                 data-test=user-box-logout-button
