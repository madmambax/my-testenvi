# set test activates robot protection, there is need click on checkbox for repetitive testing
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

*** Test Cases ***
# 3 basic tests
Test czc bad user
        Login            somebody@gmail.com               Smoula2023!          ${NoUser}

Test czc bad password
        Login1            martin.manns@gmail.com           BadPass              ${NoUser}

Test czc
        Login2           martin.manns@gmail.com           Smoula2023!          ${UserMatch}

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
    Check logout
    Sleep          5
    Close Browser

Login1
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
    Check logout
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
    Click          ${NoRobot}
    Sleep          5
    Click          ${SignIN}
    Check Logon
    Sleep          5
    Click          ${Logged}
    Sleep          5
    Click          ${LogOut}
    Sleep          5
    Check logout
    Sleep          5
    Close Browser


Check logon
    ${res} =  Get Text               ${LogonUser}
    Log                              ${res}
    Should Contain                   ${res}       ${UserMatch}


Check logout
    ${res} =  Get Text               ${LogOutText}
    Log                              ${res}
    Should Contain                   ${res}       ${NoUser}

