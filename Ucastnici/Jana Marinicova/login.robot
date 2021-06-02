*** Settings ***

Documentation  Testovani loginu
Library     SeleniumLibrary
Library     Collections


*** Variables ***
${url}      https://ponoziska.cz/my-account/
${browser}  Chrome

*** Test Cases ***
Login
    Open Browser        ${url}  ${browser}
    Log                 Adresa aplikace je ${url}
    Login               janka.pasakova@gmail.com    tester.testersky
    Welcome Page Should Contain  Odhlásit se
    [Teardown]           Close Browser


*** Keywords ***

Login
    [Arguments]       ${username}    ${password}
    Input Text        username     ${username}
    Log               Do aplikace se hlásí ${username}
    Input Text        password    ${password}
    Click Button      login

Welcome Page Should Contain
    [Arguments]     ${text}
    Log             Zjištujeme či stránka obsahuje text ${text}
    ${element}      Get WebElement  xpath://*[@id='post-110']/div/div/div/p[1]/a
    ${locator_list}  Get Text    ${element}
    Should Be Equal  ${text}    ${locator_list}



