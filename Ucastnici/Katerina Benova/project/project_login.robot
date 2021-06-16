Web login to cloud.memsource.com

*** Settings ***
Documentation   Automatizace Memsource s Browser Library
Library         Browser
Resource        Data_and_Config/resources.robot


*** Variables ***

*** Test Cases ***

Login valid
    Login           ${logged_id}        ${logged_txt}       ${username}     ${pwd}

Login wrong username
    Login           ${bad_login_id}     ${bad_login_txt}    abcd            ${pwd}

Login wrong password
    Login           ${bad_login_id}     ${bad_login_txt}    ${username}     abcd

Login empty Username
    Login Empty     1      ${empty_input_un}      password=${pwd}

Login empty password
    Login Empty     1      ${empty_input_pw}      username=${username}

Login empty password and username
    Login Empty     2      ${empty_input}



*** Keywords ***
Login Page
    [Documentation]     Opens the login page and fills the username and password
    [Arguments]         ${username}         ${password}
    New Page            ${url_login}
    Get Title           contains            ${web_title}
    Type Text           ${input_username}   ${username}
    Type Text           ${input_password}   ${password}
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
