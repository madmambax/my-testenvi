*** Settings ***
Library  Browser

*** Variables ***
${TestMessage}      Toje Test
${User}             tojetester23@gmail.com
${Password}         Patriot2023!
${URL}              https://google.com
${Title}            Google
${Cookies}          xpath=//*[@id="L2AGLb"]/div
${LogonForm}        xpath=//*[@id="gb"]/div/div[2]/a
${InuptUserFiels}   xpath=//*[@id="identifierId"]
${BUttonToPasswd}   id=identifierNext
${InuptPassField}   xpath=//*[@id="password"]/div[1]/div/div[1]/input
${ButtonLogon}      id=passwordNext
${LoginFormOpen}    xpath=//*[@id="gb"]/div/div[2]/div[2]/div/a/img

*** Test Cases ***

Logon and logout google
    Login               ${User}        ${Password}        ${TestMessage}


#*** Keywords ***
*** Keywords ***
Login
    [Arguments]     ${UserName}     ${Passwd}     ${TestValue}

    log     ${UserName}
    log     ${Passwd}
    log     ${TestValue}


    #open browser, no working in chromium of webkit for google
    New Browser    chromium    headless=false
    # open url
    New Page       ${URL}
    # check pahe
    Get Title      contains    ${Title}
    Sleep          5
    # confirm cookies
    Click          ${Cookies}
    Sleep          5
    # open logon form
    Click          ${LogonForm}
    Sleep          2
    # insert user name
    Type Text      ${InuptUserFiels}      ${User}
    Sleep          5
    # continue to password
    Click          ${BUttonToPasswd}
    Sleep          5
    # insert password
    Type Text      ${InuptPassField}   ${Password}
    Sleep          5
    # continue to logon
    Click          ${ButtonLogon}
    # verify logon - success
    Sleep          2
    Get Text       text="${TestMessage}"
    Sleep          2
    # open login form with "odhlásit"
    Click          ${LoginFormOpen}
    Sleep          2
    # logout from google
#    Click          css=
#    Sleep          5
     # verify logout