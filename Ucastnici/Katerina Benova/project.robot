Web login to cloud.memsource.com

*** Settings ***
Documentation   Automatizace Memsource s Browser Library
Library  Browser


*** Variables ***
${URL}              https://cloud.memsource.com/web/login
${logged_id}        title
${bad_login_id}     div > .errors
${bad_login_txt}    Sorry, we were not able to find a user with that username and password.


*** Test Cases ***

Login valid
    Login       ${logged_id}    Jobs - Memsource    ben_ling2   mpls6868

Login wrong username
    Login       ${bad_login_id}     ${bad_login_txt}      ab@ce.df    mpls6868

Login wrong password
    Login       ${bad_login_id}     ${bad_login_txt}      ben_ling2   abcd

Login empty Username
    Login Empty  1      input#username      password=mpls6868

Login empty password
    Login Empty  1      input#password      username=ben_ling2

Login empty password and username
    Login Empty  2



*** Keywords ***
Login Page
    [Documentation]     Opens the login page and fills the username and password
    [Arguments]         ${username}     ${password}
    New Page            ${URL}
    Get Title           contains        Memsource
    Type Text           id=username     ${username}
    Type Text           id=password     ${password}
    Click               id=submit


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
    Get Element Count	.ms-text-field-wrapper--error ${element}    ==  ${count}
    Take Screenshot