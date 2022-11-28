*** Settings ***
Library     Browser

*** Variables ***
${URL}      https://www.grizly.cz/

*** Test Cases ***

Login valid
    Login    haparic327@teknowa.com    mojeheslo1       Přihlášen:
    Logout

Login wrong email
    Login   spatnymail@seznam.cz       mojeheslo1       Přihlášení / Registrace

Login wrong password
    Login   haparic327@teknowa.com     spatneheslo      Přihlášení / Registrace

Login empty email
    Login   ${EMPTY}                   mojeheslo1       Přihlášení / Registrace

Login empty password
    Login   haparic327@teknowa.com     ${EMPTY}         Přihlášení / Registrace

*** Keywords ***
Login
    [Arguments]     ${email}  ${password}  ${happen}

    Log     ${email}
    Log     ${password}
    Log     ${happen}

    New Browser     chromium    headless=false
    New Page        ${URL}
    Get Title       ==          Potraviny a doplňky pro zdravou cestu životem | GRIZLY
    Click           //*[@id="js:cookies:barInitWrapper"]/div[2]/div/div[2]/button[2]
    Click           text="Přihlášení / Registrace"
    Type Text       //*[@id="js-reg-popup-login"]/div[2]/form/div[1]/input               ${email}
    Type Text       //*[@id="js-reg-popup-login"]/div[2]/form/div[2]/input               ${password}
    Click           //*[@id="js-reg-popup-login"]/div[2]/form/button
    Take Screenshot
    Get Text        //*[@id="skrollr-body"]/div[2]/div[2]/div[1]/div/div[4]/div/div/span[1]  ==  ${happen}

Logout
    Click           //*[@id="skrollr-body"]/div[2]/div[2]/div[1]/div/div[4]
    Click           //*[@id="skrollr-body"]/div[2]/div[2]/div[1]/div/div[4]/div/div/div/ul/li[6]/div







