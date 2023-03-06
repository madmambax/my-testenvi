*** Settings ***
Library  Browser

Resource     DataConfig_Grab/Config_Grab.robot
Resource     DataConfig_Grab/Test_data_grab.robot

*** Keywords ***

# Cílem úkolu je doplnit toto klíčové slovo tak aby všechny testy prošly
Login_with_control
    [Arguments]     ${pemail}      ${pheslo}     ${validation}

    
    #New Page       ${URL}
    #Get Title    contains    ${Title_URL}
    Cookie       ${DATA_cookies}
    
    Sleep        ${sleep_short}
    Click        ${sel_login_btn}
    Sleep        ${sleep_short}
    Click        ${sel_user_name}
    Type text    ${sel_user_name}       ${pemail}


    Click        ${sel_user_psw}
    Type Text    ${sel_user_psw}      ${pheslo}
    Sleep        ${sleep_short}
    Click        ${sel_show_password}
    Click        ${sel_SignIn_btn}

User_logged_in
    Get Text     ${sel_HeaderLogin}    contains   MS
User_is_not_logged_in
    Get Text     ${sel_HeaderLogin}    contains    Účet
    Log To Console    ${TEXT_IncorrectPSW}

Cookie
    [Arguments]     ${type}
    IF  "${type}" == "${DATA_cookies}"
        Click         ${sel_cookie_allow}
    ELSE
        Click         ${sel_cookie_decline}
    END
    Sleep        ${sleep_short}
Logout
    Go To           ${URL}
    Click           ${sel_Header_user}
    Click           ${sel_logout_btn}
Add_to_cart

    [Arguments]       ${itema}       ${itema_id}        ${quantity}

    Type Text           ${sel_search_field}      ${itema}
    Sleep                1
    Click               ${sel_search_btn}
    Sleep                5
    Click               css=[data-product-id="${itema_id}"][${sel_btnADD}]
    Sleep               5
    ${amount}           Evaluate                    ${quantity} - 1
    ${old_mode} =      Set Strict Mode    False
    Click              css=[data-product-id="${itema_id}"][${sel_btnPlus}]   clickCount=${amount}
    #Go To              ${URL}
    Sleep              ${sleep_short}

Remove
    Click               ${sel_cart}
    Click               ${sel_cart_remove}

Before_set
    Set Browser Timeout    20
    New Browser         headless=false
After_set
    Close Browser
Before_Test
    New Browser    chromium         headless=false
    New Page                        ${URL}
    Get Title      contains         ${Title_URL}

After_Test
    Sleep                           ${timeout_browser}
    Go To                           ${URL}
    Close Browser
