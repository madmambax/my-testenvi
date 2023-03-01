*** Settings ***
Library  Browser


*** Variables ***
${pemail}       thcsrvqxqkdnnjpqrz@bbitf.com
${pheslo}       Test1234?
${pnastane}     sss


*** Keywords ***
Login
    [Arguments]     ${pemail}      ${pheslo}     ${pnastane}

    log             ${pemail}
    log             ${pheslo}
    log             ${pnastane}

    #Otevři browser pinterestu a zvaliduj title
    New Browser    chromium    headless=false
    New Page       https://cz.pinterest.com/
    Get Title      ==    Pinterest - Česká republika

    #Klikni na login
    Click    "Log in"
    Type Text      id=email    ${pemail}
    Type Text      id=password    ${pheslo}
    Click    xpath= //*[@id="__PWS_ROOT__"]/div/div[1]/div/div[2]/div/div/div/div/div/div[4]/form/div[7]/button/div
    Get Text    xpath=//*[@id="HeaderContent"]/div/div/div[2]/div/div/div/div[5]/div[4]/div/div/div/a/div/div/div/div/div/div/svg/text       contain     T
    Sleep    1
    


*** Test Cases ***
Přihlášení validnímy údaji
    Login    ${pemail}    ${pheslo}    ${pnastane}

