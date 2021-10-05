Web login to cloud.memsource.com

*** Settings ***
Documentation   Automatizace Memsource s Browser Library
Library         Browser
Resource        Data_and_Config/resources.robot


*** Variables ***

*** Test Cases ***

Login valid
    Login           ${SEL_logged}        ${TXT_logged}       ${username}     ${pwd}

Login wrong username
    Login           ${SEL_bad_login}     ${TXT_bad_login}    abcd            ${pwd}

Login wrong password
    Login           ${SEL_bad_login}     ${TXT_bad_login}    ${username}     abcd

Login empty Username
    Login Empty     1      ${SEL_empty_input_un}      password=${pwd}

Login empty password
    Login Empty     1      ${SEL_empty_input_pw}      username=${username}

Login empty password and username
    Login Empty     2      ${SEL_empty_input}



*** Keywords ***
Login Page
    [Documentation]     Opens the login page and fills the username and password
    [Arguments]         ${username}             ${password}
    New Page            ${url_login}
    Get Title           contains                ${TXT_web_title}
    Type Text           ${SEL_input_username}   ${username}
    Type Text           ${SEL_input_password}   ${password}
    Click               ${button_submit}


Login
    [Documentation]     Evaluates Login with username and password
    [Arguments]         ${validation_id}    ${validation_text}  ${username}     ${password}
    Login Page          ${username}         ${password}
    Get Text            ${validation_id}    ==                  ${validation_text}
    Take Screenshot


Login Empty
    [Documentation]     Evaluates Login where username and password can be empty, counts number of red fields
    [Arguments]         ${count}        ${element}=     ${username}=    ${password}=
    Login Page          ${username}     ${password}
    Get Element Count	${element}    ==  ${count}
    Take Screenshot
