*** Settings ***
Library     Browser

*** Variables ***
${URL}      https://www.rohlik.cz/

*** Test Cases ***

Pridani zbozi do kosiku
    Login                   hahacip784@dmonies.com      mojeheslo1      NU
    Add to the cart         máslo           726539      5
    Remove from the cart    Košík funguje i jako nákupní seznam
    Logout                  Přihlásit

Pridani do kosiku - maximalni pocet 50 ks
    Login                   hahacip784@dmonies.com      mojeheslo1      NU
    Add to the cart         máslo           726539      50
    Remove from the cart    Košík funguje i jako nákupní seznam
    Logout                  Přihlásit

Pridani do kosiku - negativni test 51 ks
    Login                   hahacip784@dmonies.com      mojeheslo1      NU
    Add to the cart         máslo           726539      51
    Remove from the cart    Košík funguje i jako nákupní seznam
    Logout                  Přihlásit


*** Keywords ***

Login
    [Arguments]         ${email}  ${password}  ${validation}

    Log                 ${email}
    Log                 ${password}
    Log                 ${validation}

    New Browser         chromium    headless=false
    New Page            ${URL}
    Get Title           ==          Online supermarket Rohlik.cz — nejrychlejší doručení ve městě
    Click               id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    Click               data-test=header-user-icon
    Sleep               1
    Type Text           id=email                    ${email}
    Type Text           id=password                 ${password}
    Click               data-test=btnSignIn

    Get Text            data-test=header-user-icon  ==  ${validation}
    ${log}=  Get Text   data-test=header-user-icon
    Log                 ${log}
    Take Screenshot


Logout
    [Arguments]         ${validation}
    #Go To              ${URL}
    Click               data-test=header-user-icon
    Click               data-test=user-box-logout-button

    Get Text            id=headerLogin  ==  ${validation}
    ${log}=  Get Text   id=headerLogin
    Log                 ${log}
    Take Screenshot


Add to the cart
    [Arguments]         ${product}  ${product_id}  ${number}
    Type Text           id=searchGlobal             ${product}
    Click               data-test=header-search-button
    Sleep               5
    Click               css=[data-product-id="${product_id}"][data-test="btnAdd"]
    ${num_click}=       Evaluate  ${number}-1
    Click               css=[data-product-id="${product_id}"][data-test="btnPlus"]   clickCount=${num_click}
    Sleep               2

    ${cart_text}=       Get Text        data-test=cart-item
    Log                 ${cart_text}
    Get Text            data-test=cart-item         matches         (?i)${product}
    Take Screenshot


Remove from the cart
    [Arguments]          ${empty_cart}
    Click                [aria-label^="Odstranit z košíku"]
    Sleep                2

    ${cart_content}=     Get Text       data-test=cart-content
    Log                  ${cart_content}
    Get Text             data-test=cart-content     matches         (?i)${empty_cart}
    Take Screenshot


    #Click               data-test=cart
    #Sleep               5
    #Click               text="Vysypat košík"
    #Go To               ${URL}
    #Sleep               10
    #Take Screenshot
