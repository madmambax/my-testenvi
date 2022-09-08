*** Settings ***
Documentation    Simple example using Browser Library
Library Browser Library

*** Variables ***
${LOGIN URL}     https://www.jezdectvi.org/
${BROWSER}       Microsoft Edge

*** Test Cases ***
Valid login
    Open Browser To Login Page
    Input Username  stepanka.rosprimova
    Input Password  Vorman1793
    Submit Credentials
    Welcome Page Should Be Open
    [Teardown]  Close Browser

*** Keywords ***
Open Browser To Login Page
    Open Browser    ${LOGIN URL}   ${BROWSER}
    Title Should Be     CJF|Jezdecky informacni system

Input Username
[Arguments]     ${username}
Input Text  username_field      ${USERNAME}

Input Username
[Arguments]     ${password}
Input Text  password_field      ${PASSWORD}

Submit Credentials
    Click Button    Login_button

Welcome Page Should Be Open
    Title Should Be     Welcome Page


