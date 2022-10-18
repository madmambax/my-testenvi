*** Settings ***
Library  Browser

*** Variables ***
${URL}      https://lmsstage.scormium.com/login
${Login1}   Test
${Password1}

*** Test Cases ***
Prihlaseni login
    Login               rosprimovastepanka@seznam.cz                    Vorman1793.                      ŠR

*** Keywords ***
Login
    [Arguments]     ${pemail}      ${pheslo}     ${pnastane}

    Log             ${pemail}
    Log             ${pheslo}
    Log             ${pnastane}

    New Browser     chromium    headless=false
    New Page        ${URL}
    Get Title        ==     SCORMIUM LMS Login
    Sleep           3    # nutné z důvodu chyby
    Type Text       xpath=//*[@id="kt_login_signin_form"]/*/input[@name="email"]      ${pemail}
    Type Text       xpath=//*[@id="kt_login_signin_form"]/*/input[@name="password"]   ${pheslo}
    Sleep           1
    Click           xpath=//*[@id="kt_login_signin_submit"]
    Click           xpath=//*[@id="main_layout"]/div[1]/div[1]/div[2]/div[2]
    Sleep           1
    Click           xpath=//*[@id="main_layout"]/div[1]/div[2]/div[2]/div/div[2]/div[1]/div
    Get Title       ==      SCORMIUM LMS Add student - TestPortal



