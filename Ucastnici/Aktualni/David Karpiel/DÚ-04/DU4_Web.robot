*** Settings ***
Library    Browser
Library    Dialogs
Library    Process

*** Variables ***
@{MANY_BROWSERS} =          chromium    webkit  firefox

${BROWSER} =                chromium
${URL} =                    https://www.alza.cz
${URL_TITLE} =              Alza.cz
${ACCEPT_COOKIE_BUTTON} =   xpath=//*[@id="rootHtml"]/body/div[7]/div/div/div[2]/a[1]
${DECLINE_COOKIE_BUTTON} =  xpath=//*[@id="rootHtml"]/body/div[7]/div/div/div[2]/a[3]
${LOGIN_EMAIL} =            pemake5422@mustbeit.com
${LOGIN_PASSWORD} =         Password123
${ERROR_TEXT} =             Neplatné uživatelské jméno nebo heslo
${SIGN_IN_EMAIL} =          id=loginIframe >>> id=userName
${SIGN_IN_PASSWORD} =       id=loginIframe >>> id=password
${LOGIN_BUTTON} =           id=loginIframe >>> id=loginButtonText
${SEARCH_TERM} =            notebook
${BASKET_ICON} =            xpath=//*[@id="basketLink"]/span[2]
${USER_LOGIN_BUTTON} =      id=lblLogin
${EMAIL_TEXT_FIELD} =       id=loginIframe >>> id=userName
${PASSWORD_TEXT_FIELD} =    id=loginIframe >>> id=password
${LOGOUT_ICON} =            css=[class="alzaico-l-logout"]
${SEARCH_FIELD} =           id=edtSearch
${SEARCH_BUTTON} =          id=btnSearch
${BUY_BUTTON} =             css=[class="btnx new green buy js-buy-button"]
${DOWN_ARROW_IN_BASKET} =   css=[class="item-options__trigger js-item-options-trigger"]
${REMOVE_BUTTON} =          css=[class="item-options__option item-options__option--del js-item-options-del"] >> nth=1

@{INVALID_LOGIN} =     Honza@gmail.com    jhjhjhjhgk123
@{INVALID_EMAIL} =     Pepa@seznam.cz     ${LOGIN_PASSWORD}
@{INVALID_PASSWORD} =  ${LOGIN_EMAIL}     JGZJZUGHHJJKG


*** Test Cases ***
The website "Alza.cz" and login window should load
    [Tags]   Test_1
    FOR    ${COUNTER}    IN RANGE    3
        Open Browsers      ${COUNTER}
        Open website "Alza.cz"
        Verify page loaded
        Close cookies
        Close pop-up
        Click on "Přihlásit"
        Verify "Přihlásit" page loaded
        Close Browser
    END

User should be able to login and logout (positive test)
    [Tags]  Test_2
    Open Browser
    Open website "Alza.cz"
    Verify page loaded
    Close cookies
    Close pop-up
    Click on "Přihlásit"
    Verify "Přihlásit" page loaded
    Login with valid credentials    ${LOGIN_EMAIL}  ${LOGIN_PASSWORD}
    Verify login
    Logout and verify logout

User shouls see correct error messages with invalid logins (negative test)
    [Tags]  Test_3
    Open Browser
    Open website "Alza.cz"
    Verify page loaded
    Close cookies
    Close pop-up
    Click on "Přihlásit"
    Verify "Přihlásit" page loaded
    Login with invalid credentials    ${INVALID_LOGIN}    ${INVALID_EMAIL}    ${INVALID_PASSWORD}


User can search and add products to the cart
    [Tags]  Test_4
    Open Browser
    Open website "Alza.cz"
    Verify page loaded
    Close cookies
    Close pop-up
    #Check if basket is empty
    Search products
    Select product
    Verify "notebook" page loaded
    Click on "Koupit"
    Verify the addition of the product to the cart
    Increase the number of products in the cart and verify the addition
    Remove the product from the cart and verify the removal


*** Keywords ***
Open Browsers
    [Arguments]     ${COUNTER}
    Log             ${MANY_BROWSERS}[${COUNTER}]
    New Browser     ${MANY_BROWSERS}[${COUNTER}]    headless=False
Open Browser
    New Browser     ${BROWSER}      headless=False     slowMo=00:00:00

Open website "Alza.cz"
    ${old_timeout} =    Set Browser Timeout    10 seconds
    New Page               ${URL}
    Set Browser Timeout    ${old_timeout}
Verify page loaded
    Get Title              contains      ${URL_TITLE}
Close cookies
    ${acceptAll} =  Get Text    ${ACCEPT_COOKIE_BUTTON}
    IF    "${acceptAll}" == "Rozumím"
        Click    ${ACCEPT_COOKIE_BUTTON}
    ELSE
        Click    ${DECLINE_COOKIE_BUTTON}
    END
Close pop-up
    ${passed} =  Run Keyword And Return Status    Click    css=[class=close] >> nth=1
    Run Keyword If  ${passed}  Log  The previous step FAILED!
Click on "Přihlásit"
    Click              ${USER_LOGIN_BUTTON}
Verify "Přihlásit" page loaded
    ${text_login} =    Get Text    id=loginIframe >>> text=Přihlášení
    Log To Console    ${text_login}
    Should Contain    ${text_login}    Přihlášení

# SUCCESFUL LOGIN

Login with valid credentials
    [Arguments]     ${LOGIN_EMAIL}  ${LOGIN_PASSWORD}
    Fill "email" field              ${LOGIN_EMAIL}
    Fill "password" field           ${LOGIN_PASSWORD}
    Click "Přihlásit se" button

Fill "email" field
    [Arguments]     ${LOGIN_EMAIL}
    Sleep    1s
    Fill Text       ${EMAIL_TEXT_FIELD}      ${LOGIN_EMAIL}
Fill "password" field
    [Arguments]     ${LOGIN_PASSWORD}
    Fill Text       ${PASSWORD_TEXT_FIELD}      ${LOGIN_PASSWORD}
Click "Přihlásit se" button
    Click           ${LOGIN_BUTTON}
Verify login
    Get Text        id=lblUser  contains  ${LOGIN_EMAIL}
Logout and verify logout
    Click           ${LOGOUT_ICON}
    Get Text        ${USER_LOGIN_BUTTON}  contains  Přihlásit
    Sleep    3s

# LOGIN FAILED

Login with invalid credentials
    [Arguments]       ${INVALID_LOGIN}     ${INVALID_EMAIL}    ${INVALID_PASSWORD}
    Invalid login     ${INVALID_LOGIN}
    Invalid email     ${INVALID_EMAIL}
    Invalid password  ${INVALID_PASSWORD}
    Empty email and password field

Invalid login
    [Arguments]     ${INVALID_LOGIN}
    Sleep    1s
    Fill Text       ${SIGN_IN_EMAIL}       ${INVALID_LOGIN}[0]
    Fill Text       ${SIGN_IN_PASSWORD}    ${INVALID_LOGIN}[1]
    Click           ${LOGIN_BUTTON}
    Get Text        ${LOGIN_BUTTON}  ==    ${ERROR_TEXT}
    Sleep    1s
Invalid email
    [Arguments]     ${INVALID_EMAIL}
    Sleep    1s
    Fill Text       ${SIGN_IN_EMAIL}       ${INVALID_EMAIL}[0]
    Fill Text       ${SIGN_IN_PASSWORD}    ${INVALID_EMAIL}[1]
    Click           ${LOGIN_BUTTON}
    Get Text        ${LOGIN_BUTTON}  ==    ${ERROR_TEXT}
    Sleep    1s
Invalid password
    Sleep    1s
    [Arguments]     ${INVALID_PASSWORD}
    Fill Text       ${SIGN_IN_EMAIL}       ${INVALID_PASSWORD}[0]
    Fill Text       ${SIGN_IN_PASSWORD}    ${INVALID_PASSWORD}[1]
    Click           ${LOGIN_BUTTON}
    Get Text        ${LOGIN_BUTTON}  ==    ${ERROR_TEXT}
    Sleep    1s
Empty email and password field
    Fill Text       ${SIGN_IN_EMAIL}       ${EMPTY}
    Fill Text       ${SIGN_IN_PASSWORD}    ${EMPTY}
    Click           ${LOGIN_BUTTON}
    Get Text        id=loginIframe >>> xpath=/html/body/div/div/form/div[1]/div[2]/span  ==  Zadejte e-mailovou adresu
    Get Text        id=loginIframe >>> xpath=/html/body/div/div/form/div[1]/div[3]/span  ==  Zadejte prosím heslo
    Sleep    1s

# SEARCH PRODUCTS

#Check if basket is empty
#    ${basket} =  Get Text    ${BASKET_ICON}
#    Log To Console    ${basket}
#
#    IF   "${basket}" == "${EMPTY}"
#        Run Keyword    Search products
#    ELSE
#        Click    id=basket
#        Click    ${DOWN_ARROW_IN_BASKET}
#        Click    ${REMOVE_BUTTON}
#        Click    id=logo
#    END
Search products
    Fill Text      ${SEARCH_FIELD}    ${SEARCH_TERM}
    Click          ${SEARCH_BUTTON}
Select product
    Click          id=img6243351
Verify "notebook" page loaded
    Get Text       id=hlOrderFast   contains    Koupit zrychleně
Click on "Koupit"
    Click          ${BUY_BUTTON}
    Sleep    1s
Verify the addition of the product to the cart
    Get Text       css=[class="productInfo__texts__message"]  ==  Zboží bylo přidáno do košíku
    Click          id=varBToBasketButton
    Sleep    3s
    Get Text       ${BASKET_ICON}  ==  1
    Sleep    1s
Increase the number of products in the cart and verify the addition
    IF  "${BROWSER}" != "firefox"
        Click       css=[class="countPlus"]    clickCount=2
        Get Text    ${BASKET_ICON}  ==  3
    ELSE
        # Repair for firefox
        Click      css=[class="countPlus"]
        Click      css=[class="countPlus"]
        Get Text   ${BASKET_ICON}  ==  3
    END
Remove the product from the cart and verify the removal
    Click          ${DOWN_ARROW_IN_BASKET}
    Click          ${REMOVE_BUTTON}
    Get Text       ${BASKET_ICON}  ==  0
    Get Text       id=blocke  contains  Jsem tak prázdný...
    Sleep    3s