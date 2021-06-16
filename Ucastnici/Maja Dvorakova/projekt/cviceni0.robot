*** Settings ***
Documentation   Testing website rohlik.cz
Library         SeleniumLibrary


*** Variables ***
${URL}              http://rohlik.cz



*** Test Cases ***

Login and logout with valid data

    Open Browser                        ${URL}                                                                                                       chrome
    Click Element                       id=headerLogin
    ${AllLinks}=                        Get All Links
    Log                                 ${AllLinks}
    Input Text                          xpath=//*[@id="email"]                                                                                       TesterNotARobot12@gmail.com
    Input Text                          xpath=//*[@id="password"]                                                                                    hesloNeniPassword34
    Press Keys                          xpath=//*[@id="header"]/div[1]/div[1]/div/div[2]/div/div[2]/div/div[1]/form/button/x-translation             [Return]
    ${AllLinks}=                        Get All Links
    Log                                 ${AllLinks}
    Press Keys                          xpath=//*[@id="headerUser"]/div                                                                              [Return]
    ${AllLinks}=                        Get All Links
    Log                                 ${AllLinks}
    Press Keys                          xpath=//*[@id="header"]/div[1]/div[1]/div/div[2]/div/div[2]/div[5]/a/x-translation                           [Return]
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







