*** Settings ***
Library     Browser
Resource    Configuration.robot
Resource    TestData.robot

*** Keywords ***

#test setup and teardown
Before_Test
    New Browser    chromium         headless=false
    New Page                        ${URL}
    Get Title      contains         ${TEXT_MainTitle}

After_Test
    Sleep                           ${timeout_browser}
    Go To                           ${URL}
    Close Browser


LogIn
    [Arguments]         ${email}  ${passw}  ${valid}
    Log                 ${email}
    Log                 ${passw}
    Log                 ${valid}

    New Browser         chromium    headless=false
    New Page            ${URL}
    Get Title           ==                          ${TEXT_MainTitle}
    Click               id=CybotCookiebotDialogBodyLevelButtonLevelOptinAllowAll
    Click               ${SEL_HeaderLogin}
    Sleep               1
    Type Text           id=email                    ${email}
    Type Text           id=password                 ${passw}
    Click               ${SEL_BtnSignIn}

    Get Text            ${SEL_HeaderLogin}  ==  ${valid}
    ${log}=  Get Text   ${SEL_HeaderLogin}
    Log                 ${log}


LogOut
    [Arguments]         ${valid}
    Go To               ${URL}
    Click               xpath=//div[@class='u-mr--8']
    Click               ${SEL_UserBoxLogoutBtn}



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