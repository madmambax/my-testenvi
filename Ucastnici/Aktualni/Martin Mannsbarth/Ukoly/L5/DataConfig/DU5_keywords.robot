#all important keywords
*** Settings ***
Library   Browser
Library   String
Resource  DU5_TestDataM.robot
Resource  DU5_configrobo.robot

*** Keywords ***
Login
    [Arguments]     ${User}           ${Passwd}           ${ValueText}

    Log    ${User}
    Log    ${Passwd}
    Log    ${ValueText}

    # Open browser and check, that page is correct - moved to Setup Test
#    New Browser    chromium         headless=false
#    New Page                        ${URL}
#    Get Title      contains         ${Title}

    # accept cookies
    Click                           ${SEL_Cookies}
    Sleep                           ${CommonSleep}

    # logon - type username, password and signin
    Click          ${SEL_LoginForm}
    Sleep          ${CommonSleep}
    Type Text      ${SEL_InputUser}      ${User}
    Sleep          ${ShortSleep}
    Type Text      ${SEL_InputPasswd}    ${Passwd}
    Sleep          ${ShortSleep}
    Click          ${SEL_SignIN}
    Sleep          ${CommonSleep}
    Get Text       text= ${DATA_IncorrectLogonName}
    Check logout


Login1
    [Arguments]     ${User}           ${Passwd}           ${ValueText}

    Log    ${User}
    Log    ${Passwd}
    Log    ${ValueText}

    # Open browser and check, that page is correct -moved to Setup Test
#    New Browser    chromium         headless=false
##    New Context    viewport={'width': 1920, 'height': 1080}
#    New Page                        ${URL}
#    Get Title      contains         ${Title}

    # accept cookies
    Click                           ${SEL_Cookies}
    Sleep                           ${CommonSleep}

    # logon - type username, password and signin
    Click          ${SEL_LoginForm}
    Sleep          ${CommonSleep}
    Type Text      ${SEL_InputUser}          ${User}
    Sleep          ${ShortSleep}
    Type Text      ${SEL_InputPasswd}        ${Passwd}
    Sleep          ${ShortSleep}
    Click          ${SEL_SignIN}
    Sleep          ${CommonSleep}
    Check logout

Login2
    [Arguments]     ${User}           ${Passwd}           ${ValueText}

    Log    ${User}
    Log    ${Passwd}
    Log    ${ValueText}

    # Open browser and check, that page is correct - moved to Setup Test
#    New Browser    chromium         headless=false
#    New Page                        ${URL}
#    Get Title      contains         ${Title}

    # accept cookies
    Click                           ${SEL_Cookies}
    Sleep                           ${CommonSleep}

    # logon - type username, password and signin,  czc protection against robots -checkbox I am not robot
    Click          ${SEL_LoginForm}
    Sleep          ${CommonSleep}
    Type Text      ${SEL_InputUser}       ${User}
    Sleep          ${ShortSleep}
    Type Text      ${SEL_InputPasswd}         ${Passwd}
    Sleep          ${ShortSleep}
    Click          ${SEL_SignIN}
    Sleep          ${CommonSleep}
#    Click          ${SEL_NoRobot}
#    Sleep          ${CommonSleep}
#    Click          ${SEL_SignIN}
    Check Logon
    Sleep          ${CommonSleep}
    Add Goods      ${DATA_item}    ${Data_Pcs}
    Clear Basket
    Logout shop

# add goods to shopping basket, then increase number, verify kind and amount of goods
Add Goods
    [Arguments]                 ${Thing}                   ${Data_Pcs}

    Type Text                   ${SEL_Find}                ${Thing}
    Sleep                       ${ShortSleep}
    Click                       ${SEL_ButtonSearch}
    Sleep                       ${CommonSleep}
    Take Screenshot
    Click                       ${SEL_AddToBasket}
    Sleep                       ${ShortSleep}
    Take Screenshot
    Sleep                       ${ShortSleep}
    CLick                       ${SEL_OpenBasket}
    Sleep                       ${CommonSleep}
    Type Text                   ${SEL_IncreaseNumber}         ${Data_Pcs}
    Sleep                       ${ShortSleep}
    Click                       ${SEL_ConfirmIncrease}
    Sleep                       ${ShortSleep}
    Verify goods
    Verify amount
    Sleep                       ${CommonSleep}
    Take Screenshot

# verify if correct goods has been added to basket
Verify goods
    ${res} =  Get Text               ${SEL_VerifyGoods}
    Log                              ${res}
    Should Contain                   ${res}       ${DATA_Goods}

# check right amount/ pcs in shopping basket
Verify amount
    ${res} =  Get Text               ${SEL_VerifyItemAmount}
    Log                              ${res}
    Should Be Equal As Numbers       ${res}       ${Data_Pcs}

# clear basket, there is possible other way - write 0 as count of items and confirm by click
Clear Basket
    Click                              ${SEL_Clear}
    Sleep                              ${ShortSleep}
    Take Screenshot

# logout from shop and verify logoff
Logout shop
    Sleep                              ${CommonSleep}
    Go To                              ${URL}
    Sleep                              ${ShortSleep}
    Click                              ${SEL_Logged}
    Sleep                              ${CommonSleep}
    Click                              ${SEL_LogOut}
    Sleep                              ${CommonSleep}
    Check logout

# verify correct logon
Check logon
    ${res} =  Get Text               ${SEL_LogonUser}
    Log                              ${res}
    Should Contain                   ${res}             ${DATA_UserMatch}

# verify correct logoff
Check logout
    ${res} =  Get Text               ${SEL_LogOutText}
    Log                              ${res}
    Should Contain                   ${res}              ${DATA_NoUser}

Before_Test
    New Browser    chromium         headless=false
    New Context                     viewport={'width': 1920, 'height': 1080}
    New Page                        ${URL}
    Get Title      contains         ${Title}

After_Test
    Sleep                           ${CommonSleep}
    Close Browser

