*** Settings ***
Library  Browser
Resource    ../domaci_procvicovani.robot

*** Variables ***

${URL}      https://www.saucedemo.com/
${user}     standard_user
${psw}      secret_sauce
${outcome}          ADD TO CART
*** Test Cases ***
Prihlasit se
   Login                     ${user}             ${psw}      ${outcome}


*** Keywords ***

# Cílem úkolu je doplnit toto klíčové slovo tak aby všechny testy prošly
Login
    [Arguments]     ${user}      ${psw}     ${outcome}

    log             ${user}
    log             ${psw}
    log             ${outcome}



    New Browser    chromium    headless=false

    New Page       ${URL}

    Get Title      contains     Swag



    click           id=user-name
    Sleep           2
    Type text       id=user-name    ${user}

    Click           xpath=//*[@id="password"]
    Sleep           2
    Type Text       xpath=//*[@id="password"]  ${psw}

    Click           xpath=//*[@id="login-button"]
    Sleep           2
    Get Text    id=add-to-cart-sauce-labs-onesie  ==  ${outcome}

    Click           id=react-burger-menu-btn

    Get Text        id=logout_sidebar_link     ==     LOGOUT

    Sleep           2

    Click           id=logout_sidebar_link

    Sleep           5

    Get Text        id=login-button             ==      Login

    Sleep           2




    


