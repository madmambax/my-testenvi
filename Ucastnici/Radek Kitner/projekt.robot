
*** Settings ***
Documentation     Simple example using SeleniumLibrary.
Library           SeleniumLibrary


*** Variables ***
${LOGIN URL}      http://testovani.kitner.cz/login_app/
${BROWSER}        Chrome


*** Test Cases ***
Login
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Login  novak    tajnenovak
    Welcome Page Should Be Open
    [Teardown]    Close Browser

*** Keywords ***
Login
    [Arguments]    ${username}     ${password}
    Input Text    inputUsernameID    ${username}
    Input Text    inputPasswordID    ${password}
    Click Button    buttonID


Welcome Page Should Have    ${text}
    Log     Oveření zda stránka obsahuje text: "${text}"
    Wait Until Page Contains    ${text}
    Log Location
