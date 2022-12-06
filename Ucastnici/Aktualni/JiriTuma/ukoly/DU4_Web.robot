*** Settings ***
Library  Browser

*** Variables ***
${URL}      https://www.rohlik.cz/


*** Test Cases ***

Login Logout positive
    Login          kayob47290@teknowa.com              hesloheslo
    Check logged in  AA
    Logout
    Check logged out

Login Negative
    Login          kayob47290@teknowa.com              hesloheslo111
    Check logged out

To cart positive
    Login          kayob47290@teknowa.com              hesloheslo
    Add item       banan                               1349777
    Sleep  2
    Check in cart  Banán 1 ks
    Sleep  1
    Remove item

To cart negative
    Login          kayob47290@teknowa.com              hesloheslo
    Add item       banan                               1349777
    Sleep  2
    Check not in cart  Jablko 1 ks
    Sleep  1
    Remove item


Remove from cart
    Login          kayob47290@teknowa.com              hesloheslo
    Add item       banan                               1349777
    Sleep  2
    Check in cart  Banán 1 ks
    Remove item
    Sleep  1
    Check cart empty


*** Keywords ***

Login
    [Arguments]     ${pemail}      ${pheslo}

    New Browser    chromium  headless=false
    New Context    viewport={'width': 1920, 'height': 1080}
    New Page       ${URL}
    Get Title      ==    Online supermarket Rohlik.cz — nejrychlejší doručení ve městě

    sleep  1
    Click          id=headerLogin

    Type Text      id=email       ${pemail}
    Fill Secret    id=password    ${pheslo}


    Click          data-test=btnSignIn

Logout
    Click          \#headerUser
    Click          data-test=user-box-logout-button

Check logged in
    [Arguments]    ${user}
    Get Text       data-test=header-user-icon      ==      ${user}

Check logged out
    Get Text       data-test=header-user-icon      ==      Přihlásit


Add item
    [Arguments]    ${product}  ${id}
    Type Text      id=searchGlobal            ${product}
    Click          data-test=header-search-button
    Sleep          1
    Click          css=[data-product-id="${id}"][data-test="btnAdd"]
    Log            Added item ${id} to cart

Check in cart
    [Arguments]    ${label}
    Click          data-test=headerPrice
    Get Text       xpath=//*[@id="pageFullWidth"]/main/div/main/section/div/div[1]/h3/a/span[1]  contains   ${label}


Check not in cart
    [Arguments]    ${label}
    Click          data-test=headerPrice
    Get Text       xpath=//*[@id="pageFullWidth"]/main/div/main/section/div/div[1]/h3/a/span[1]  not contains   ${label}


Remove item
    Click          data-test=btnMinus


Check cart empty
    Get Text       id=cartReviewMainTitle     contains         Košík funguje i jako nákupní seznam