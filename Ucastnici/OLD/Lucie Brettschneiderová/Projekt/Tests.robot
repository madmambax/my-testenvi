*** Settings ***
Library  Browser
Resource            TestData.robot

Suite Setup         Setup for suite
Suite Teardown      Finish suite

Test Setup          Setup for test
Test Teardown       Finish test


*** Test Cases ***
Negativni - Odeslani prazdneho formulare vyvola required chybu u jmena a hesla
    Click                       ${SEL_UserAccount}
    Click                       ${SEL_SignIn}
    Get text                    ${SEL_LoginMessMail}                     contains              ${errorMailReq}
    Get text                    ${SEL_LoginMessPass}                     contains              ${errorPassReq}


Negativni - Prihlaseni - error pro spatne zadane udaje
    Login                       a@a.com                                   test
    Get text                    ${SEL_LoginNotif}                         contains             ${wrongMailPass}


Pozitivni - Prihlaseni
    Login                       ${loginMail}                              ${loginPass}
    Get text                    ${SEL_UserAccount}                        contains              ${userInitials}

Pozitivni - Prihlaseni a odhlaseni
    Login                       ${loginMail}                              ${loginPass}
    Logout
    Get text                    ${SEL_UserAccount}                        contains              ${userNotLoggedIn}

*** Keywords ***
Setup for suite
    New Browser                 chromium                                   headless=false
    Set Browser Timeout         10

Setup for test
    Load Page

Finish test
    Click                       ${SEL_MainLogo}

Finish suite
    Close browser

Load page
    New Browser                 chromium                                   headless=false
    New Page                    ${url}
    Set Browser Timeout         10

Login
    [Arguments]                 ${username}                                ${password}
    Click                       ${SEL_UserAccount}
    Type text                   ${SEL_InputLoginMail}                      ${username}
    Type text                   ${SEL_InputLoginPass}                      ${password}
    Click                       ${SEL_SignIn}

Logout
    Click                       ${SEL_UserAccount}
    Click                       ${SEL_Logout}
