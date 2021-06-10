*** Settings ***
Documentation           Testování přihlasování do rohlíku
Library                 Browser


*** Variables ***
${url}                  https://rohlik.cz
${url_p}                https://ponoziska.cz

*** Test Cases ***
Přihlášení
    Login               janka.pasakova@gmail.com                tester1234              TT


Odhlášení
    Log_out             Přihlásit


Zamítnuté přihlášení - zlé heslo
    Login               janka.pasakova@gmail.com                   tester1234           Přihlásit


Zamítnuté přihlášení - zlý email
    Login               janka@gmail.com                            tester1234           Přihlásit

Ponoziska prihlaseni
    Login_ponoziska     janka.pasakova@gmail.com        tester.testersky        Odhlásit se

Ponoziska odhlaseni
    Log_out_ponoziska  janka.pasakova@gmail.com         tester.testersky        Odhlásit se     Přihlášení



*** Keywords ***
Login
    [Arguments]         ${email}                                    ${heslo}           ${validation}
    New Page            ${url}
    Get Title           contains                                    Rohlik
    Click               id=headerLogin
    Type Text           data-test=user-login-form-email             ${email}
    Type Text           data-test=user-login-form-password          ${heslo}
    Click               data-test=btnSignIn
    Get Text            data-test=header-user-icon                  ==                  ${validation}
    ${log}=             Get Text                                    data-test=header-user-icon
    Log                 ${log}
    Take Screenshot

Log_out
    [Arguments]         ${od}       ${pri}
    New Page            ${url}
    Get Title           contains                                    Rohlik
    Click               id=headerLogin
    Type Text           data-test=user-login-form-email             janka.pasakova@gmmail.com
    Type Text           data-test=user-login-form-password          tester1234
    Click               data-test=btnSignIn
    Click               data-test=header-user-icon
    #Get Text            data-key=user:logOut                        ==             ${od}
    Click               data-test=user-box-logout-button
    Get Text            data-key=common:header.user.logInShort      ==    ${pri}
    Take Screenshot

Login_ponoziska
    [Arguments]         ${email}                                    ${heslo}    ${text}
    New Page            ${url_p}
    Get Title           contains                                    Ponožiska
    Click               xpath=//*[@id='et-secondary-nav']/li[3]
    Type Text           id=username                                 ${email}
    Type Text           id=password                                 ${heslo}
    Click               xpath=//*[@id="customer_login"]/div[1]/form/p[3]/button
    Get Text            xpath=//*[@id='post-110']/div/div/div/p[1]/a    contains    ${text}
    Take Screenshot

Log_out_ponoziska
    [Arguments]         ${email}        ${heslo}        ${text}     ${logout}
    New Page            ${url_p}
    Get Title           contains                                    Ponožiska
    Click               xpath=//*[@id='et-secondary-nav']/li[3]
    Type Text           id=username                                 ${email}
    Type Text           id=password                                 ${heslo}
    Click               xpath=//*[@id="customer_login"]/div[1]/form/p[3]/button
    Get Text            xpath=//*[@id='post-110']/div/div/div/p[1]/a   contains      ${text}
    Click               xpath=//*[@id='post-110']/div/div/div/p[1]/a
    Get Text            id=customer_login                               contains    ${logout}
    Take Screenshot
