*** Settings ***

Library         Browser
Resource        TestData.robot
Resource        Configuration.robot
Test Setup     Test Setup
Test Teardown  Test Teardown
Suite Setup     Suite Setup
Suite Teardown  Suite Teardown


*** Test Cases ***

Login Logout positive
    Login              ${USER1_NAME}         ${USER1_PASSWORD}
    Check logged in  ${USER1_SHORT}
    Logout
    Check logged out

Login Negative
    Login          ${USER1_NAME}         ${USER1_PASSWORD}
    Check logged out


*** Keywords ***

Test Setup
    Set Browser Timeout  ${BROWSER_TIMEOUT}
    New Page       ${URL}
    New Browser    chromium  headless=false
    New Context    viewport={'width': 1920, 'height': 1080}
    New Page       ${URL}
    Get Title      ==    ${TEXT_MainTitle}
    sleep  1
Test Teardown
    Log To Console    Test finished
Suite Setup
    Log To Console    Suite started
Suite Teardown
    Log To Console    Suite finished
Login
    [Arguments]     ${pemail}      ${pheslo}
    sleep  1
    Click          ${SEL_HeaderLogin}

    Type Text      ${SEL_Email}       ${pemail}
    Fill Secret    ${SEL_Password}    ${pheslo}


    Click          ${SEL_ClickLogin}

Logout
    Click          ${SEL_Header}
    Click          ${SEL_LogoutClick}

Check logged in
    [Arguments]    ${user}
    Get Text       ${SEL_HeaderIcon}      ==      ${user}

Check logged out
    Get Text       ${SEL_HeaderIcon}      ==      ${TEXT_Prihlasit}
