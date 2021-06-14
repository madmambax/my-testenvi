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

    Open Browser                        ${URL}                                                                                                        Chrome
    Click Element                       id=headerLogin
    ${AllLinks}=                        Get All Links
    Log                                 ${AllLinks}
    Input Text                          xpath=//*[@id="email"]                                                                                        jsemprihlasen
    Input Text                          xpath=//*[@id="password"]                                                                                     hesloNeniPassword34
    Press Keys                          xpath=//*[@id="header"]/div[1]/div[1]/div/div[2]/div/div[2]/div/div[1]/form/button/x-translation              [Return]
    Element Text Should Be              emailError                                                                                                    Zadejte platný email
    Close Browser


Login with invalid password

    Open Browser                        ${URL}                                                                                                        Chrome
    Click Element                       id=headerLogin
    ${AllLinks}=                        Get All Links
    Log                                 ${AllLinks}
    Input Text                          xpath=//*[@id="email"]                                                                                        TesterNotARobot12@gmail.com
    Input Text                          xpath=//*[@id="password"]                                                                                     passwordispassword
    Press Keys                          xpath=//*[@id="header"]/div[1]/div[1]/div/div[2]/div/div[2]/div/div[1]/form/button/x-translation              [Return]
    ${AllLinks}=                        Get All Links
    Log                                 ${AllLinks}
    Element Text Should Be              emailError                                                                                                    Zadal(a) jste nesprávný e-mail nebo heslo.
    Close Browser



*** Keywords ***
