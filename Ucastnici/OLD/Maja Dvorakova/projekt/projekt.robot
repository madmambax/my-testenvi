*** Settings ***
Documentation   Testing website rohlik.cz
Library         SeleniumLibrary
Resource        TestovaciData.robot

*** Variables ***




*** Test Cases ***

Login and logout with valid data

    #Open Browser                        ${URL}                                  Chrome
    #Click Element                       id=headerLogin
    #${AllLinks}=                        Get All Links
    #Log                                 ${AllLinks}
    #Input Text                          ${SEL_LoginValidEmail}                 ${USER1_NAME}
    #Input Text                          ${SEL_LoginValidPwd}                   ${USER1_PWD}
    #Press Keys                          ${SEL_BtnSignIn}                       [Return]
    #${AllLinks}=                        Get All Links
    #Log                                 ${AllLinks}
    #Press Keys                          ${SEL_TTBtn}                           [Return]
    #${AllLinks}=                        Get All Links
    #Log                                 ${AllLinks}
    #Press Keys                          ${SEL_UserBoxLogoutBtn}                [Return]
    #Close Browser



Login with invalid username

    #Open Browser                        ${URL}                                  Chrome
    Click Element                       ${SEL_HeaderLogin}
    ${AllLinks}=                        Get All Links
    Log                                 ${AllLinks}
    Input Text                          ${SEL_LoginValidEmail}                  ${BAD_USER1}
    Input Text                          ${SEL_LoginValidPwd}                    ${USER1_PWD}
    Press Keys                          ${SEL_BtnSignIn}                        [Return]
    Element Text Should Be              emailError                              ${ERROR_TEXT_FillCorrectEmail}
    #Close Browser


Login with invalid password

    #Open Browser                        ${URL}                                  Chrome
    Click Element                       ${SEL_HeaderLogin}
    ${AllLinks}=                        Get All Links
    Log                                 ${AllLinks}
    Input Text                          ${SEL_LoginValidEmail}                  ${USER1_NAME}
    Input Text                          ${SEL_LoginValidPwd}                    ${BAD_USER1_PWD}
    Press Keys                          ${SEL_BtnSignIn}                        [Return]
    ${AllLinks}=                        Get All Links
    Log                                 ${AllLinks}
    Element Text Should Be              emailError                              ${ERROR_TEXT_IncorrectEmailOrPwd}
    #Close Browser


*** Keywords ***

Login
    [Arguments]                         ${USERNAME}                           ${PASSWORD}               ${ERROR_TEXT}

    Open Browser                        ${URL}
    Click Element                       ${SEL_HeaderLogin}
    ${AllLinks}=                        Get All Links
    Log                                 ${AllLinks}
    Input Text                          ${SEL_LoginValidEmail}                  ${USERNAME}
    Input Text                          ${SEL_LoginValidPwd}                    ${PASSWORD}
    Press Keys                          ${SEL_BtnSignIn}                        [Return]
    ${AllLinks}=                        Get All Links
    Log                                 ${AllLinks}
    Element Text Should Be              emailError                              ${ERROR_TEXT}







