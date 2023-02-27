
*** Settings ***
Library  Browser


*** Variables ***
${URL}      https://www.saucedemo.com/


*** Test Cases ***
Login s kontrolou v parametru - přidání zboží do košíku, odebrání zboží a odhlášení
    Login s kontolou        standard_user               secret_sauce                ADD TO CART
    Přidání do košíku       Sauce Labs Backpack         4
    Odebrání z košíku
    Reset aplikace
    Odhlášení

Login - kontola zvlášť - přidání zboží do košíku, odebrání zboží a odhlášení
    Login                   standard_user               secret_sauce
    Uživatel je přihlášen
    Přidání do košíku       Sauce Labs Backpack         4
    Odebrání z košíku
    Reset aplikace
    Odhlášení

Login - špatné uživatelské jméno
    Login                   stan_user               secret_sauce
    Uživatel není přihlášen

Login - špatné heslo
    Login               standart_user               secret_sausage
    Uživatel není přihlášen


*** Keywords ***
Login s kontolou

    [Arguments]     ${user}      ${password}     ${outcome}

    log             ${user}
    log             ${password}
    log             ${outcome}


    New Browser     chromium                headless=false
    New Page        ${URL}
    Get Title       contains                Swag Labs
    Click           xpath=//*[@id="user-name"]
    Type Text       id=user-name            ${user}
    Click           data-test=password
    Type Text       id=password             ${password}
    Click           xpath=//*[@id="login-button"]
    Get Text        id=add-to-cart-sauce-labs-backpack      ==        ${outcome}

Login
    [Arguments]     ${user}      ${password}

    log             ${user}
    log             ${password}

    New Browser     chromium                headless=false
    New Page        ${URL}
    Get Title       contains                Swag Labs
    Click           xpath=//*[@id="user-name"]
    Type Text       id=user-name            ${user}
    Click           data-test=password
    Type Text       id=password             ${password}
    Click           xpath=//*[@id="login-button"]

Uživatel je přihlášen
    Get Text        id=add-to-cart-sauce-labs-backpack      contains        ADD TO CART

Uživatel není přihlášen
     Get Text       id=login-button            contains     Login

Přidání do košíku

     [Arguments]     ${zbozi}          ${cisloproduktu}
     Click           id=item_${cisloproduktu}_title_link
     Click           id=add-to-cart-sauce-labs-backpack
     Click           id=shopping_cart_container
     sleep           1

Odebrání z košíku
    Get Text        id=remove-sauce-labs-backpack           ==  REMOVE
    Click           xpath=//*[@id="remove-sauce-labs-backpack"]
    Sleep           1

Reset aplikace
    Click           xpath=//*[@id="react-burger-menu-btn"]
    Get Text        xpath=//*[@id="reset_sidebar_link"]     ==         RESET APP STATE
    Click           xpath=//*[@id="reset_sidebar_link"]
    Sleep           1

Odhlášení
    Get Text        id=logout_sidebar_link                  ==         LOGOUT
    Click           id=logout_sidebar_link
    Get Text        id=login-button                         ==         Login
    Sleep           1