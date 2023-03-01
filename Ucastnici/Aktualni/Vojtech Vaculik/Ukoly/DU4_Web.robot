*** Settings ***
Library     Browser

*** Variables ***
${URL}      https://www.rohlik.cz/
${email}    vojta.vaculik@gmail.com
${passw}    wH2cMTmiXUT+umM
${valid}    VV


*** Test Cases ***

Přihlášení a odhlasení
    LogIn   ${email}  ${passw}  ${valid}
    LogOut  Přihlásit

Add to cart - pokus se koupit přes 50 másel
    Login                   ${email}  ${passw}  ${valid}
    Add to the cart         máslo           726539      52
    Remove from the cart    Košík funguje i jako nákupní seznam
    Logout                  Přihlásit

Add to cart - pridat do kosiku 10 masel
    Login                   ${email}  ${passw}  ${valid}
    Add to the cart         máslo           726539      10
    Remove from the cart    Košík funguje i jako nákupní seznam
    Logout                  Přihlásit


*** Keywords ***
LogIn
    [Arguments]         ${email}  ${passw}  ${valid}
    Log                 ${email}
    Log                 ${passw}
    Log                 ${valid}

    New Browser         chromium    headless=false
    New Page            ${URL}
    Get Title           ==          Online supermarket Rohlik.cz — nejrychlejší doručení ve městě
    Click               id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    Click               data-test=header-user-icon
    Sleep               1
    Type Text           id=email                    ${email}
    Type Text           id=password                 ${passw}
    Click               data-test=btnSignIn

    Get Text            data-test=header-user-icon  ==  ${valid}
    ${log}=  Get Text   data-test=header-user-icon
    Log                 ${log}


LogOut
    [Arguments]         ${valid}
    Go To               https://www.rohlik.cz/
    Click               xpath=//div[@class='u-mr--8']
    Click               data-test=user-box-logout-button

    


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



