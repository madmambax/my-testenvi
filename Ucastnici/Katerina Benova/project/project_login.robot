Web login to cloud.memsource.com

*** Settings ***
Documentation   Automatizace Memsource s Browser Library
Library  Browser
Resource  Data_and_Config/testData_memsource.robot

Suite Setup                     #spustí se před celou suite
Suite Teardown                  #spustí se po doběhnutí celé suite
Test Setup      Before Test     #spustí se před každým testem zvlášť
Test Teardown   After Test      #spustí se po každým testu zvlášť

Test Timeout  20    ¨¨
Resource  Data_and_Config/testData_memsource.robot

*** Variables ***

*** Test Cases ***

Login valid
#   [Setup]     Before Test   pretest pro jeden test
    Login       ${logged_id}    Jobs - Memsource    ${username}    ${pwd}
#   [Teardown]  prázdný teardown zruší obecný teardown nastavený v setupu

Login wrong username
    Login       ${bad_login_id}     ${bad_login_txt}      abcd    ${pwd}

Login wrong password
    Login       ${bad_login_id}     ${bad_login_txt}      ${username}   abcd

Login empty Username
    Login Empty  1      input#username      password=${pwd}

Login empty password
    Login Empty  1      input#password      username=${username}

Login empty password and username
    Login Empty  2



*** Keywords ***
Login Page
    [Documentation]     Opens the login page and fills the username and password
    [Arguments]         ${username}     ${password}
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
