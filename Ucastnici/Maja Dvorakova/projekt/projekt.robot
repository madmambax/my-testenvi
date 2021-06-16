*** Settings ***
Documentation   Testing website rohlik.cz
Library         SeleniumLibrary
Resource        TestovaciData.robot

Test Setup      Open ${URL} Chrome
Test Teardown   Close Browser

*** Variables ***




*** Test Cases ***

Login and logout with valid data


    Click Element                       id=headerLogin
    ${AllLinks}=                        Get All Links
    Log                                 ${AllLinks}
    Input Text                          ${SEL_LoginValidEmail}                 ${USER1_NAME}
    Input Text                          ${SEL_LoginValidPwd}                   ${USER1_PWD}
    Press Keys                          ${SEL_BtnSignIn}                       [Return]
    ${AllLinks}=                        Get All Links
    Log                                 ${AllLinks}
    Press Keys                          ${SEL_TTBtn}                           [Return]
    ${AllLinks}=                        Get All Links
    Log                                 ${AllLinks}
    Press Keys                          ${SEL_UserBoxLogoutBtn}                [Return]


Login with invalid username


    Click Element                       ${SEL_HeaderLogin}
    ${AllLinks}=                        Get All Links
    Log                                 ${AllLinks}
    Input Text                          ${SEL_LoginValidEmail}                  ${BAD_USER1}
    Input Text                          ${SEL_LoginValidPwd}                    ${USER1_PWD}
    Press Keys                          ${SEL_BtnSignIn}                        [Return]
    Element Text Should Be              emailError                              ${ERROR_TEXT_FillCorrectEmail}



Login with invalid password


    Click Element                       ${SEL_HeaderLogin}
    ${AllLinks}=                        Get All Links
    Log                                 ${AllLinks}
    Input Text                          ${SEL_LoginValidEmail}                  ${USER1_NAME}
    Input Text                          ${SEL_LoginValidPwd}                    ${BAD_USER1_PWD}
    Press Keys                          ${SEL_BtnSignIn}                        [Return]
    ${AllLinks}=                        Get All Links
    Log                                 ${AllLinks}
    Element Text Should Be              emailError                              ${ERROR_TEXT_IncorrectEmailOrPwd}




*** Keywords ***

Login and logout with valid data


