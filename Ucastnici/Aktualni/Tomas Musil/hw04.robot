*** Settings ***
Library  Browser


*** Variables ***
${EMAIL}        najadi6083@kuvasin.com
${PASSWORD}     hesloveslo
${INITIALS}     NK
${PRODUCT_NAME}     banán
${PRODUCT_ID}       1349777


*** Test Cases ***

Login Successful
    Login          ${EMAIL}  ${PASSWORD}
    Check logged in

Login Unsuccessful
    Login          test.test@test.test  password
    Check logged out

Logout Successful
    Login          ${EMAIL}  ${PASSWORD}
    Sleep          1
    Logout
    Check logged out

Logout Unsuccessful
    Login          ${EMAIL}  ${PASSWORD}
    Click          data-test=logo-main
    Check logged in

Add item to cart Successful
    Login          ${EMAIL}  ${PASSWORD}
    Search         ${PRODUCT_NAME}
    Sleep          1
    Add item to cart  ${PRODUCT_ID}
    Sleep          1
    Check item in cart  ${PRODUCT_NAME}
    Log            Cleanup
    Sleep          1
    Remove item from cart  ${PRODUCT_ID}

Add item to cart Unsuccessful
    Login          ${EMAIL}  ${PASSWORD}
    Search         test
    Sleep          1
    Click          data-test=logo-main
    Sleep          1
    Check item not in cart  test

Remove item from cart Successful
    Login          ${EMAIL}  ${PASSWORD}
    Add item to cart  ${PRODUCT_ID}
    Sleep          1
    Check item in cart  ${PRODUCT_NAME}
    Sleep          1
    Remove item from cart  ${PRODUCT_ID}
    Sleep          1
    Check item not in cart  ${PRODUCT_NAME}

Remove item from cart Unsuccessful
    Login          ${EMAIL}  ${PASSWORD}
    Add item to cart  ${PRODUCT_ID}
    Sleep          1
    Check item in cart  ${PRODUCT_NAME}
    Sleep          1
    Click          data-test=logo-main
    Sleep          1
    Check item in cart  ${PRODUCT_NAME}
    Log            Cleanup
    Sleep          1
    Remove item from cart  ${PRODUCT_ID}


*** Keywords ***

Login
    [Arguments]    ${email}  ${pswd}
    Set Browser Timeout  100
    New Browser    chromium  headless=false
    New Page       https://www.rohlik.cz/
    Get Title      *=       Rohlik.cz
    Log            Opened website
    Close cookie popup      decline
    Click          id=headerLogin
    Type Text      id=email       ${email}
    Type Text      id=password    ${pswd}
    Click          data-test=btnSignIn
    Log            Logged in with credentials ${email}:${pswd}

Logout
    Click          data-test=header-user-icon
    Click          data-test=user-box-logout-button
    Log            Logged out

Close cookie popup
    [Arguments]         ${type}
    IF  "${type}" == "accept"
        Click      id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    ELSE
        Click      id=CybotCookiebotDialogBodyButtonDecline
    END
    Log            Closed cookies popup

Check logged in
    Get Text       data-test=header-user-icon      ==      ${INITIALS}
    Log            Sucessfully logged in

Check logged out
    Get Text       data-test=header-user-icon      ==      Přihlásit
    Log            Sucessfully logged out

Search
    [Arguments]    ${keyword}
    Type Text      id=searchGlobal            ${keyword}
    Sleep          1
    Click          data-test=header-search-button
    Log            Searched for ${keyword}

Add item to cart
    [Arguments]    ${id}
    Click          css=[data-product-id="${id}"][data-test="btnAdd"]
    Log            Added item ${id} to cart

Remove item from cart
    [Arguments]    ${id}
    Hover          data-test=cart-header
    Type Text      css=[id=product_${id}] input     0
    Sleep          1
    Log            Removed item ${id} from cart

Check item in cart
    [Arguments]    ${name}
    Hover          data-test=cart-header
    Get Text       id=cart     matches         (?i)${name}
    Log            Item ${name} is in cart

Check item not in cart
    [Arguments]    ${name}
    Hover          data-test=cart-header
    Get Text       id=cart     not contains         ${name}
    Log            Item ${name} is not in cart