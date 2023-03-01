# set test activates robot protection, there is need click on checkbox for repetitive testing,need run negative
# test seldom, because it can enable captcha protoction against robot, then there is need manual looon and a few times
# logon with correct credentials
# test increase items in the shopping basket

# necessary libraries
*** Settings ***
Library  Browser
Library  String

*** Variables ***
${URL}                    https://czc.cz
${Title}                  CZC
${Cookies}                xpath=//*[@id="ccp-popup"]/div/div[2]/button[3]
${UserMatch}              Martin Mannsbarth (marmanx25)
${LogonUser}              //*[@id="logged-user"]
${LoginForm}              css=\#login > svg
${InputUser}              xpath=//*[@id="frm-name"]
${InputPasswd}            xpath=//*[@id="frm-password"]
${SignIN}                 xpath=//*[@id="login-form"]/div[4]/button
${LogOutText}             xpath=//*[@id="login"]
${NoUser}                 Přihlášení
${Logged}                 id=logged-user
${LogOut}                 xpath=//*[@id="blue-menu-wrapper"]/ul[2]/li[2]/div/div[2]/a[1]
${NoRobot}                xpath=//*[@id="login-form"]/div[3]/label/span
${Pcs}                    3
${Clear}                  css=[class="btn-circle-remove"][title="Odstranit z košíku"]
${VerifyGoods}            xpath=//*[@id="basket-table"] >> nth=1
${VerifyItemAmount}       xpath=//*[@id="frm-quantity-272572"]
${Goods}                  Microsoft Bluetooth Mouse, Pastel Blue\n272572
${item}                   mouse
${Find}                   id=fulltext
${ButtonSearch}           xpath=//*[@id="wrapper"]/header/div[2]/div/div[1]/form/button
${AddToBasket}            css=[data-product-code="272572"][data-label="Přidat zboží do košíku"]
${OpenBasket}             xpath=//*[@id="basket-preview"]/a
${IncreaseNumber}         xpath=//*[@id="frm-quantity-272572"]
${ConfirmIncrease}        xpath=//*[@id="basket-visibility-container"]/h1

*** Test Cases ***
 # basic tests for czc
#Test czc bad user
#        Login            somebody@gmail.com               Smoula2023!          ${NoUser}

#Test czc bad password
#        Login1            martin.manns@gmail.com           BadPass              ${NoUser}

Test czc
        Login2            martin.manns@gmail.com           Smoula2023!          ${UserMatch}


*** Keywords ***
Login
    [Arguments]     ${User}           ${Passwd}           ${ValueText}

    Log    ${User}
    Log    ${Passwd}
    Log    ${ValueText}

    # Open browser and check, that page is correct
    New Browser    chromium         headless=false
    New Page                        ${URL}
    Get Title      contains         ${Title}

    # accept cookies
    Click                           ${Cookies}
    Sleep                           5

    # logon - type username, password and signin
    Click          ${LoginForm}
    Sleep          5
    Type Text      ${InputUser}      ${User}
    Sleep          2
    Type Text      ${InputPasswd}    ${Passwd}
    Sleep          2
    Click          ${SignIN}
    Sleep          5
    Get Text       text="Nesprávné přihlašovací jméno"
#    Check logout
    Sleep          5
    Close Browser

Login1
    [Arguments]     ${User}           ${Passwd}           ${ValueText}

    Log    ${User}
    Log    ${Passwd}
    Log    ${ValueText}

    # Open browser and check, that page is correct
    New Browser    chromium         headless=false
#    New Context    viewport={'width': 1920, 'height': 1080}
    New Page                        ${URL}
    Get Title      contains         ${Title}

    # accept cookies
    Click                           ${Cookies}
    Sleep                           5

    # logon - type username, password and signin
    Click          ${LoginForm}
    Sleep          5
    Type Text      ${InputUser}      ${User}
    Sleep          2
    Type Text      ${InputPasswd}    ${Passwd}
    Sleep          2
    Click          ${SignIN}
    Sleep          5
#    Check logout
    Sleep          5
    Close Browser

Login2
    [Arguments]     ${User}           ${Passwd}           ${ValueText}

    Log    ${User}
    Log    ${Passwd}
    Log    ${ValueText}

    # Open browser and check, that page is correct
    New Browser    chromium         headless=false
    New Page                        ${URL}
    Get Title      contains         ${Title}

    # accept cookies
    Click                           ${Cookies}
    Sleep                           5

    # logon - type username, password and signin,  czc protection against robots -checkbox I am not robot
    Click          ${LoginForm}
    Sleep          5
    Type Text      ${InputUser}      ${User}
    Sleep          2
    Type Text      ${InputPasswd}    ${Passwd}
    Sleep          2
    Click          ${SignIN}
    Sleep          5
#    Click          ${NoRobot}
#    Sleep          5
#    Click          ${SignIN}
#    Check Logon
    Sleep          5
    Add Goods      ${item}    ${Pcs}
#    Clear Basket
    Logout shop

# add goods to shopping basket, then increase number, verify kind and amount of goods
Add Goods
    [Arguments]                 ${Thing}               ${Pcs}

    Type Text                   ${Find}                ${Thing}
    Sleep                       2
    Click                       ${ButtonSearch}
    Sleep                       5
    Take Screenshot
    Click                       ${AddToBasket}
    Sleep                       2
    Take Screenshot
    Sleep                       2
    CLick                       ${OpenBasket}
    Sleep                       5
    Click                       css=.up     clickCount=2
#    Type Text                   ${IncreaseNumber}         ${Pcs}
#    Sleep                       1
#    Click                       ${ConfirmIncrease}
#    Sleep                       2
#    Verify goods
#    Verify amount
    Sleep                       5
    Take Screenshot

## verify if correct goods has been added to basket
#Verify goods
#    ${res} =  Get Text               ${VerifyGoods}
#    Log                              ${res}
#    Should Contain                   ${res}       ${Goods}
#
## check right amount/ pcs in shopping basket
#Verify amount
#    ${res} =  Get Text               ${VerifyItemAmount}
#    Log                              ${res}
#    Should Be Equal As Numbers       ${res}       ${Pcs}
#
## clear basket, there is possible other way - write 0 as count of items and confirm by click
#Clear Basket
#    Click                              ${Clear}
#    Sleep                              2
#    Take Screenshot

# logout from shop and verify logoff
Logout shop
    Sleep                              5
    Go To                              ${URL}
    Sleep                              2
    Click                              ${Logged}
    Sleep                              5
    Click                              ${LogOut}
    Sleep                              5
#    Check logout
    Sleep                              5
    Close Browser

# verify correct logon
#Check logon
#    ${res} =  Get Text               ${LogonUser}
#    Log                              ${res}
#    Should Contain                   ${res}       ${UserMatch}
#
## verify correct logoff
#Check logout
#    ${res} =  Get Text               ${LogOutText}
#    Log                              ${res}
#    Should Contain                   ${res}       ${NoUser}

