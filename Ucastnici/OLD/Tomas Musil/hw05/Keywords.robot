*** Settings ***
Library  Browser
Resource  Configuration.robot
Resource  TestData.robot

*** Keywords ***

Open site
    Set Browser Timeout  ${TIMEOUT_BROWSER}
    New Browser    chromium  headless=false
    New Page       ${URL}
    Get Title      *=       ${TITLE}
    Log            Opened website
    Close cookie popup      ${COOKIE_ACTION}


Cleanup
    Log            Cleanup
    Sleep          1
    ${timeout} =   Set Browser Timeout   1
    ${log_level} =  Set Log Level    NONE
    TRY

        Remove item from cart
    EXCEPT
        Sleep    0
    END
    TRY
        Logout
    EXCEPT
        Sleep    0
    END
    Set Log Level  ${log_level}
    Set Browser Timeout   ${timeout}
    Sleep    1


Login
    [Arguments]    ${USER1_NAME}  ${pswd}
    Click          ${SEL_HeaderLogin}
    Type Text      ${SEL_LoginFormEmail}       ${USER1_NAME}
    Type Text      ${SEL_LoginFormPwd}    ${pswd}
    Click          ${SEL_BtnSignIn}
    Log            Logged in with credentials ${USER1_NAME}:${pswd}

Logout
    Click          ${SEL_HeaderUser}
    Click          ${SEL_UserBoxLogoutBtn}
    Log            Logged out

Close cookie popup
    [Arguments]         ${type}
    IF  "${type}" == "accept"
        Click      ${SEL_Cookie_AllowAll}
    ELSE
        Click      ${SEL_Cookie_Decline}
    END
    Log            Closed cookies popup

Check logged in
    Get Text       ${SEL_HeaderUser}      ==      ${USER1_SHORT}
    Log            Sucessfully logged in

Check logged out
    Get Text       ${SEL_HeaderLogin}      ==      Přihlásit
    Log            Sucessfully logged out

Search
    [Arguments]    ${keyword}
    Type Text      ${SEL_SearchGlobal}            ${keyword}
    Sleep          1
    Click          ${SEL_BtnSearchGlobal}
    Log            Searched for ${keyword}

Add item to cart
    [Arguments]    ${id}
    Click          css=[${SEL_ProductID}="${id}"][${SEL_BtnAdd}]
    Log            Added item ${id} to cart

Remove item from cart
    Hover          ${SEL_CartHeader}
    Click          ${SEL_RemoveBasket}
    Sleep          1
    Log            Removed item from cart

Check item in cart
    [Arguments]    ${name}
    Hover          ${SEL_CartHeader}
    Get Text       ${SEL_Cart}     matches         (?i)${name}
    Log            Item ${name} is in cart

Check item not in cart
    [Arguments]    ${name}
    Hover          ${SEL_CartHeader}
    Get Text       ${SEL_Cart}     not contains         ${name}
    Log            Item ${name} is not in cart