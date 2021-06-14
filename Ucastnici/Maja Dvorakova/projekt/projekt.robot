*** Settings ***
Documentation   Testing website rohlik.cz
Library         SeleniumLibrary
Resource        TestovaciData.robot


*** Variables ***




*** Test Cases ***

Login and logout with valid data

    Open Browser                        ${URL}                                 chrome
    Click Element                       id=headerLogin
    ${AllLinks}=                        Get All Links
    Log                                 ${AllLinks}
    Input Text                          ${SEL_LoginValidEmail}                 TesterNotARobot12@gmail.com
    Input Text                          ${SEL_LoginValidPwd}                   hesloNeniPassword34
    Press Keys                          ${SEL_BtnSignIn}                       [Return]
    ${AllLinks}=                        Get All Links
    Log                                 ${AllLinks}
    Press Keys                          ${SEL_TTBtn}                           [Return]
    ${AllLinks}=                        Get All Links
    Log                                 ${AllLinks}
    Press Keys                          ${SEL_UserBoxLogoutBtn}                [Return]
    Close Browser


Login with invalid username

    Open Browser                        ${URL}                                  Chrome
    Click Element                       ${SEL_HeaderLogin}
    ${AllLinks}=                        Get All Links
    Log                                 ${AllLinks}
    Input Text                          ${SEL_LoginValidEmail}                  jsemprihlasen
    Input Text                          ${SEL_LoginValidPwd}                    hesloNeniPassword34
    Press Keys                          ${SEL_BtnSignIn}                        [Return]
    Element Text Should Be              emailError                              ${ERROR_TEXT_FillCorrectEmail}
    Close Browser


Login with invalid password

    Open Browser                        ${URL}                                  Chrome
    Click Element                       ${SEL_HeaderLogin}
    ${AllLinks}=                        Get All Links
    Log                                 ${AllLinks}
    Input Text                          ${SEL_LoginValidEmail}                  TesterNotARobot12@gmail.com
    Input Text                          ${SEL_LoginValidPwd}                    passwordispassword
    Press Keys                          ${SEL_BtnSignIn}                        [Return]
    ${AllLinks}=                        Get All Links
    Log                                 ${AllLinks}
    Element Text Should Be              emailError                              ${ERROR_TEXT_IncorrectEmailOrPwd}
    Close Browser



*** Keywords ***
